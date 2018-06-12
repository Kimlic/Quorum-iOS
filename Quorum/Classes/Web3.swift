//
//  Web3.swift
//  ios-quorum
//
//  Created by Dmytro Nasyrov on 6/7/18.
//  Copyright © 2018 Pharos Production Inc. for Kimlic. All rights reserved.
//

import Foundation
import BigInt
import web3swift

extension Web3 {
    
    // MARK: - Public
    
    static func quorum(keyManager: KeystoreManager, params: Web3Params) throws -> web3 {
        guard let fromAddress = keyManager.addresses?.first else { throw Web3Error.keyManagerAddress }

        let url = try buildURL(scheme: params.scheme, host: params.host, port: params.port, path: params.path)
        let network = Networks.Custom(networkID: BigUInt(params.networkId))
        guard let provider = Web3HttpProvider(url, network: network, keystoreManager: keyManager) else { throw Web3Error.webProvider(url: url, network: network) }
        let web = web3(provider: provider)
        web.options = quorumOptions(fromAddress)
        
        return web
    }
    
    // MARK: - Private
    
    private static func buildURL(scheme: String, host: String, port: Int, path: String?) throws -> URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.port = port
        
        if let path = path {
            components.path = path
        }
        
        return try components.asURL()
    }
    
    private static func quorumOptions(_ fromAddress: EthereumAddress) -> Web3Options {
        var opts = Web3Options.quorumOptions()
        opts.from = fromAddress
        
        return opts
    }
}
