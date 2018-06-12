//
//  Quorum.swift
//  ios-quorum
//
//  Created by Dmytro Nasyrov on 5/23/18.
//  Copyright © 2018 Pharos Production Inc. for Kimlic. All rights reserved.
//
 
import Foundation
import BigInt
import Result
import web3swift

public final class Quorum {
    
    //MARK: - Constants
    
    private static let password = "kimlic"
    private static let keystoreDir = getUserDir() + "/bip32_keystore"
    private static let keystoreFile = Quorum.keystoreDir + "/key.json"
    private static let mnemonicFile = Quorum.keystoreDir + "/mnemonic.json"

    //MARK: - Variables
    
    public private(set) var params: Web3Params!
    private lazy var web3 = try! Web3.quorum(keyManager: Quorum.getBip32KeystoreManager(), params: Web3ParamsLocalhost())
    
    //MARK: - Public
    
    public static func mnemonic() throws -> String {
        if let data = FileManager.default.contents(atPath: Quorum.mnemonicFile) {
            return try JSONDecoder().decode(MnemonicParams.self, from: data).mnemonic
        } else {
            return try mnemonicCreate()
        }
    }
    
    public static func keystoreWith(mnemonic: String) throws {
        if let address = getBip32KeystoreManager().addresses?.first {
            guard let _ = getBip32KeystoreManager().walletForAddress(address) as? BIP32Keystore else { throw Web3Error.invalidWalletFormat }
        } else {
            let _ = try Quorum.createKeystoreWithMnemonic(mnemonic)
        }
    }
    
    public static func cleanMnemonic() throws {
        try FileManager.default.removeItem(atPath: Quorum.mnemonicFile)
    }
    
    public func accountAddress() -> String? {
        return account()?.address
    }
    
    public func accountBalance() throws -> Int? {
        guard let account = account() else { return nil }
        let balance = web3.eth.getBalance(address: account)
        
        switch balance {
        case .success(let success): return Int(success)
        case .failure(let error): throw Web3Error.invalidBalance(error: error.localizedDescription)
        }
    }
    
    public func call(contract: QuorumContract, method: String, params: [Any] = []) throws -> [String: Any] {
        guard let account = account() else { throw Web3Error.walletNotFound }
        guard let contractAddress = EthereumAddress(contract.address) else { throw Web3Error.invalidContractAddress }
        
        var options = Web3Options.quorumOptions()
        options.from = account
        
        let result = web3.contract(contract.ABI, at: contractAddress, abiVersion: 2)!
            .method(method, parameters: [], options: options)!
            .call(options: options)
        
        switch result {
        case .success(let success): return success
        case .failure(let error): return ["error": error.localizedDescription]
        }
    }
    
    public func send(contract: QuorumContract, method: String, params: [Any] = []) throws -> [String: Any] {
        guard let account = account() else { throw Web3Error.walletNotFound }
        guard let contractAddress = EthereumAddress(contract.address) else { throw Web3Error.invalidContractAddress }
        
        var options = Web3Options.quorumOptions()
        options.from = account

        let temp = web3
            .contract(contract.ABI, at: contractAddress, abiVersion: 2)!
            .method(method, parameters: params as [AnyObject], options: options)!

        let nonce = web3.eth.getTransactionCount(address: account).value!
        try! temp.setNonce(nonce)
        var transaction = temp.transaction
        let keyManager = web3.provider.attachedKeystoreManager!
        let key = try! keyManager.UNSAFE_getPrivateKeyData(password: Quorum.password, account: account)
        try! Web3Signer.EIP155Signer.sign(transaction: &transaction, privateKey: key)
        temp.transaction = transaction

        let result = temp.sendSigned()

        switch result {
        case .success(let success):
            guard let txHash = success["txhash"] else { throw Web3Error.invalidTransactionStatus(result: success) }
            return receiptFrom(txHash: txHash)
            
        case .failure(let error): return ["error": error.localizedDescription]
        }
    }
    
    //MARK: - Life
    
    public convenience init(_ params: Web3Params = Web3ParamsLocalhost()) {
        self.init()
        
        self.params = params
    }
    
    private init() {}
    
    //MARK: - Private
    
    private static func mnemonicCreate(_ entropy: Int = 128) throws -> String {
        guard let mnemonic = try BIP39.generateMnemonics(bitsOfEntropy: entropy) else { throw Web3Error.mnemonicCreate }
        let toEncode = MnemonicParams(mnemonic: mnemonic)
        let mnemonicData = try JSONEncoder().encode(toEncode)
        FileManager.default.createFile(atPath: Quorum.mnemonicFile, contents: mnemonicData, attributes: nil)
        
        return mnemonic
    }
    
    private static func createKeystoreWithMnemonic(_ mnemonic: String) throws -> BIP32Keystore {
        guard let bip32ks = try BIP32Keystore.init(
            mnemonics: mnemonic,
            password: Quorum.password,
            mnemonicsPassword:
            Quorum.password) else { throw Web3Error.keystoreCreate }
        
        let keydata = try JSONEncoder().encode(bip32ks.keystoreParams)
        FileManager.default.createFile(atPath: Quorum.keystoreFile, contents: keydata, attributes: nil)
        
        return bip32ks
    }
    
    private func receiptFrom(txHash: String) -> [String: Any] {
        let receipt = self.web3.eth.getTransactionReceipt(txHash)
        
        switch receipt {
        case .success(let receiptSuccess): return ["receipt": receiptSuccess]
        case .failure(let error): return ["error": error.localizedDescription]
        }
    }
    
    private func account() -> EthereumAddress? {
        return web3.wallet.getAccounts().value?.first
    }
    
    private static func getUserDir() -> String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }

    private static func getBip32KeystoreManager() -> KeystoreManager {
        return KeystoreManager.managerForPath(Quorum.keystoreDir, scanForHDwallets: true)!
    }
}
