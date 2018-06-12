//
//  QuorumTests.swift
//  QuorumTests
//
//  Created by Dmytro Nasyrov on 6/9/18.
//  Copyright © 2018 Pharos Production Inc. All rights reserved.
//

import XCTest
@testable import Quorum

struct SimpleStorageContract: QuorumContract {
    
    struct Getters {
        let getValue = "get"
    }
    
    struct Transactions {
        let setValue = "set"
        let setDefaultValue = "setEmpty"
    }
    
    let address: String
    let ABI: String
    let getters = Getters()
    let transactions = Transactions()
    
    init(address: String) throws {
        self.address = address
        
        ABI = "[{\"constant\": true,\"inputs\": [],\"name\": \"storedData\",\"outputs\": [{\"name\": \"\",\"type\": \"uint256\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"inputs\": [{\"name\": \"initVal\",\"type\": \"uint256\"}],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"constructor\"},{\"constant\": false,\"inputs\": [{\"name\": \"x\",\"type\": \"uint256\"}],\"name\": \"set\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [],\"name\": \"setEmpty\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [],\"name\": \"get\",\"outputs\": [{\"name\": \"retVal\",\"type\": \"uint256\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},]"
    }
}

class QuorumTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        let simpleStorageContract = try! SimpleStorageContract(address: "0xa29495d736697ced921cf5fca1ea38dd9337755c")
        
        let quorum1 = Quorum()
        print("Q1: ", quorum1.params)
        
        let config = Web3Config(scheme: "http", host: "127.0.0.2", port: 22000, networkId: 10)
        let quorumManager = Quorum(config)
        print("Q2: ", quorumManager.params)
        
        let mnemonic = try! Quorum.mnemonic()
        print("MNEMONIC: ", mnemonic, "\n")
        try! Quorum.keystoreWith(mnemonic: mnemonic)
        
        let value = try! quorumManager.call(contract: simpleStorageContract, method: simpleStorageContract.getters.getValue)
        print("STORED VALUE: ", value, "\n")
        
        do {
            let receiptSet = try quorumManager.send(contract: simpleStorageContract, method: simpleStorageContract.transactions.setValue, params: [10])
            print("RECEIPT SET: ", receiptSet, "\n")
        } catch let err {
            print("CATCHED: \(err)")
        }
        
        
        let newValue = try! quorumManager.call(contract: simpleStorageContract, method: "get")
        print("NEW STORED VALUE: ", newValue, "\n")
        
        let receiptSetDefault = try! quorumManager.send(contract: simpleStorageContract, method: simpleStorageContract.transactions.setDefaultValue)
        print("RECEIPT SETDEFAULT: ", receiptSetDefault, "\n")
        
        let newNewValue = try! quorumManager.call(contract: simpleStorageContract, method: "get")
        print("NEW NEW STORED VALUE: ", newNewValue, "\n")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
