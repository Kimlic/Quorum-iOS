//
//  MnemonicParams.swift
//  ios-quorum
//
//  Created by Dmytro Nasyrov on 6/7/18.
//  Copyright © 2018 Pharos Production Inc. for Kimlic. All rights reserved.
//

import Foundation

struct MnemonicParams {
    
    let mnemonic: String
    
    enum CodingKeys: String, CodingKey {
        case mnemonic
    }
}

extension MnemonicParams: Codable {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        mnemonic = try values.decode(String.self, forKey: .mnemonic)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(mnemonic, forKey: .mnemonic)
    }
}
