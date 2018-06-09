//
//  Web3Params.swift
//  ios-quorum
//
//  Created by Dmytro Nasyrov on 6/8/18.
//  Copyright © 2018 Pharos Production Inc for Kimlic. All rights reserved.
//

import Foundation

protocol Web3Params {
    var scheme: String { get }
    var host: String { get }
    var port: Int { get }
    var networkId: Int { get }
}

struct Web3ParamsLocalhost: Web3Params {
    let scheme = "http"
    let host = "127.0.0.1"
    let port = 22000
    let networkId = 10
}

struct Web3ParamsGas {
    let gasPrice = 0
    let gasLimit = 4612388
    let value = 0
}
