//
//  Web3Error.swift
//  ios-quorum
//
//  Created by Dmytro Nasyrov on 6/7/18.
//  Copyright © 2018 Pharos Production Inc. for Kimlic. All rights reserved.
//

import Foundation
import web3swift

public enum Web3Error: Error, CustomStringConvertible {
    case keyManagerAddress
    case webProvider(url: URL, network: Networks)
    case mnemonicCreate
    case keystoreCreate
    case invalidWalletFormat
    case keystoreNotFound
    case walletNotFound
    case invalidContractAddress
    case invalidContract
    case invalidMethod
    case invalidBalance(error: String)
    case invalidTransactionStatus(result: Any)
    case serverError
    
    public var description: String {
        switch self {
        case .keyManagerAddress: return "Key manager doesn't contain any address"
        case .webProvider(let url, let network): return "Unable to create web3 provider for URL: \(url), network: \(network)"
        case .mnemonicCreate: return "Unable to create mnemonic phrase"
        case .keystoreCreate: return "Unable to create keystore"
        case .invalidWalletFormat: return "Invalid wallet format"
        case .keystoreNotFound: return "Keystore not found"
        case .walletNotFound: return "Wallet not found"
        case .invalidContractAddress: return "Invalid contract address"
        case .invalidContract: return "Invalid contract"
        case .invalidMethod: return "Invalid method"
        case .invalidBalance(let error): return "Invalid balance: \(error)"
        case .invalidTransactionStatus(let result): return "Transaction status is invalid: \(result)"
        case .serverError: return "Server error"
        }
    }
}
