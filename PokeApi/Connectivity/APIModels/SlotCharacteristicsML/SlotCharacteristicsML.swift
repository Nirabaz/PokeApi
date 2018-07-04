//
//  TypeML.swift
//  PokeApi
//
//  Created by Mykhailo Zabarin on 7/4/18.
//  Copyright © 2018 Selecto. All rights reserved.
//

import Foundation
/*
"type":{
    "url":"https://pokeapi.co/api/v2/type/4/",
    "name":"poison"
}
 */

enum SlotCharacteristicsMLKeys: String, CodingKey {
    case name
    case url
}

final class SlotCharacteristicsML: DecodableFromParams {
    
    private var _url: String!
    private var _name: String!
    
    var url: String {
        get {
            return _url
        }
    }
    
    var name: String {
        get {
            return _name
        }
    }

    var stringDescription: String {
        let description = "\n                  url: \(_url!),\n                  type: \(_name!)"
        return description
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SlotCharacteristicsMLKeys.self)
        _name = try container.decode(String.self, forKey: .name)
        _url = try container.decode(String.self, forKey: .url)
    }
}
