//
//  TypeML.swift
//  PokeApi
//
//  Created by Mykhailo Zabarin on 7/4/18.
//  Copyright © 2018 Selecto. All rights reserved.
//

import Foundation

enum TypeMLKeys: String, CodingKey {
    case slot
    case type
}

final class TypeML: DecodableFromParams {
    private var _slot: Int!
    private var _type: SlotCharacteristicsML!
    
    
    var slot: Int {
        get {
            return _slot
        }
    }
    
    var type: SlotCharacteristicsML {
        get {
            return _type
        }
    }
    
    var stringDescription: String {
        let description = " slot: \(_slot!),\n           type: {\(_type.stringDescription)\n           }"
        return description
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TypeMLKeys.self)
        
        _slot = try container.decode(Int.self, forKey: .slot)
        
        let aType = try container.decode([String: Any].self, forKey: .type)
        _type = try SlotCharacteristicsML(from: aType)
    }
}
