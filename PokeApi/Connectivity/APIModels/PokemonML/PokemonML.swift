//
//  PokemonModel.swift
//  PokeApi
//
//  Created by Mykhailo Zabarin on 5/31/18.
//  Copyright © 2018 Selecto. All rights reserved.
//

import Foundation

enum PokemonMLKeys: String, CodingKey {
    case id = "id"
    case name = "name"
    case baseExperience = "base_experience"
    case height = "height"
    case isDefault = "is_default"
}

final class PokemonML: SELDecodableFromParams{
    
    private var _id: Int!
    private var _name: String!
    private var _baseExperience: Int!
    private var _isDefault: Bool?
    private var _height: Int?
    
    var id: Int{
        get {
            return _id
        }
    }
    
    var name: String{
        get {
            return _name
        }
    }
    
    var baseExperience: Int{
        get {
            return _baseExperience
        }
        set {
            _baseExperience = newValue
        }
    }
    
    var height: Int{
        get {
            return _height!
        }
        set {
            _height = newValue
        }
    }
    
    var isDefault: Bool{
        get {
            return _isDefault!
        }
        set {
            _isDefault = newValue
        }
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
        
        if  let isDef = try? container.decode(Bool.self, forKey: .isDefault) {
            _isDefault = isDef
        } else {
            _isDefault = false
        }
        
        print("id: \(id), name:  \(name), baseExperience: \(baseExperience), height: \(height), isDefault:\(isDefault)")
    }
}
