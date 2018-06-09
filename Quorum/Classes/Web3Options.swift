//
//  Web3Options.swift
//  ios-quorum
//
//  Created by Dmytro Nasyrov on 6/8/18.
//  Copyright © 2018 Pharos Production Inc for Kimlic. All rights reserved.
//

import Foundation
import BigInt
import web3swift

extension Web3Options {
    
    public static func quorumOptions() -> Web3Options {
        let gasParams = Web3ParamsGas()
        var options = Web3Options()
        options.gasLimit = BigUInt(gasParams.gasLimit)
        options.gasPrice = BigUInt(gasParams.gasPrice)
        options.value = BigUInt(gasParams.value)
        
        return options
    }
}
