//
//  PokemonModel.swift
//  PokeApi
//
//  Created by Mykhailo Zabarin on 5/31/18.
//  Copyright © 2018 Selecto. All rights reserved.
//

import Foundation

enum PokemonMLKeys: String, CodingKey {
    case id
    case name
    case baseExperience = "base_experience"
    case height
    case isDefault = "is_default"
    case types
}

final class PokemonML: DecodableFromParams {
    
    private var _id: Int!
    private var _name: String!
    private var _baseExperience: Int!
    private var _isDefault: Bool?
    private var _height: Int?
    private let _types: [TypeML]?
    
    var id: Int {
        get {
            return _id
        }
    }
    
    var name: String {
        get {
            return _name
        }
    }
    
    var baseExperience: Int {
        get {
            return _baseExperience
        }
        set {
            _baseExperience = newValue
        }
    }
    
    var height: Int {
        get {
            return _height!
        }
        set {
            _height = newValue
        }
    }
    
    var isDefault: Bool {
        get {
            return _isDefault!
        }
        set {
            _isDefault = newValue
        }
    }
    
    var stringDescription: String {
        var typesDescription = ""
        for element in _types!{
            typesDescription.append("\n         {\n          \(element.stringDescription)\n         }")
        }
        let description = "pokemon: { \n id: \(id),\n name: \(name),\n baseExperience: \(baseExperience),\n height: \(height),\n isDefault: \(isDefault)\n types: \(typesDescription)\n}"
        return description
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PokemonMLKeys.self)
       
        _id = try container.decode(Int.self, forKey: .id)
        _name = try container.decode(String.self, forKey: .name)
        _baseExperience = try container.decode(Int.self, forKey: .baseExperience)
       
        if let h = try? container.decode(Int.self, forKey: .height) {
            _height = h
        } else {
            _height = 0
        }
        
        if let isDef = try? container.decode(Bool.self, forKey: .isDefault) {
            _isDefault = isDef
        } else {
            _isDefault = false
        }
               
        if let aTypes = try? container.decode([TypeML].self, forKey: .types) {
            _types = aTypes
        } else {
            _types = [TypeML]()
        }
    }
}
