//
//  QuorumContract.swift
//  ios-quorum
//
//  Created by Dmytro Nasyrov on 6/8/18.
//  Copyright © 2018 Pharos Production Inc for Kimlic. All rights reserved.
//

import Foundation
import web3swift

public protocol QuorumContract {
    var address: String { get }
    var ABI: String { get }
}
