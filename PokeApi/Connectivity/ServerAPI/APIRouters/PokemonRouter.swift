//
//  PokemonRouter.swift
//  PokeApi
//
//  Created by Mykhailo Zabarin on 5/31/18.
//  Copyright © 2018 Selecto. All rights reserved.
//

import Foundation
import Alamofire

enum PokemonEndpoint {
    case GetPokemonById(Int, APIParams)
}

class PokemonRouter: BaseRouter {
    
    private var endpoint: PokemonEndpoint
    
    init(anEndpoint: PokemonEndpoint) {
        endpoint = anEndpoint
    }
    
    override var method: HTTPMethod {
        switch endpoint {
        case .GetPokemonById(_):
            return .get
       
        }
    }
    
    override var path: String {
        switch endpoint {
        case .GetPokemonById(let itemId, _):
            return "pokemon/\(itemId)"
       
        }
    }
    
    override var parameters: APIParams {
        switch endpoint {
        case .GetPokemonById(_, let params):
            return params
        }
    }
    
    override var encoding: ParameterEncoding? {
        switch endpoint {
        case .GetPokemonById:
            return JSONEncoding.default
        }
    }
}
