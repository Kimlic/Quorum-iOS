//
//  Web3Params.swift
//  ios-quorum
//
//  Created by Dmytro Nasyrov on 6/8/18.
//  Copyright © 2018 Pharos Production Inc for Kimlic. All rights reserved.
//

import Foundation

public protocol Web3Params {
    var scheme: String { get }
    var host: String { get }
    var port: Int { get }
    var networkId: Int { get }
}

public struct Web3ParamsLocalhost: Web3Params {
    public let scheme = "http"
    public let host = "127.0.0.1"
    public let port = 22000
    public let networkId = 10
}

public struct Web3Config: Web3Params {
    public let scheme: String
    public let host: String
    public let port: Int
    public let networkId: Int
}

struct Web3ParamsGas {
    let gasPrice = 0
    let gasLimit = 4612388
    let value = 0
}
