//
//  BaseRouter.swift
//  PokeApi
//
//  Created by Mykhailo Zabarin on 5/31/18.
//  Copyright © 2018 Selecto. All rights reserved.
//

import Foundation
import Alamofire

typealias APIParams = [String: Any]?
typealias api_success_block = (_ success: Bool, _ object: APIParams, _ errMessage: String?) -> Void

let kServerBaseURL = "http://pokeapi.co/api/v2/"

// MARK: - Router
protocol RouterProtocol {
    var method: Alamofire.HTTPMethod { get }
    var parameters: APIParams {get}
    var path: String { get }
    var baseUrl: String { get }
    var encoding: Alamofire.ParameterEncoding? { get }

}

class BaseRouter: RouterProtocol, URLRequestConvertible {
  
     init() {}
    
    var method: HTTPMethod {
        fatalError("[\(self) - \(#function))] Must be overridden in subclass")
    }
    
    var parameters: APIParams {
        fatalError("[\(self) - \(#function))] Must be overridden in subclass")
    }
    
    var path: String {
        fatalError("[\(self) - \(#function))] Must be overridden in subclass")
    }
    
    var encoding: ParameterEncoding? {
        fatalError("[\(self) - \(#function))] Must be overridden in subclass")
    }
    
    var baseUrl: String {
        return kServerBaseURL
    }
    
    func asURLRequest() throws -> URLRequest {
        let baseURL = NSURL(string: baseUrl)
        let mutableURLRequest = NSMutableURLRequest(url: (baseURL?.appendingPathComponent(path))!)
        mutableURLRequest.httpMethod = method.rawValue
        
        if let encoding = encoding {
            return try encoding.encode(mutableURLRequest as URLRequest, with: parameters)
        }
        
        return mutableURLRequest as URLRequest
    }
    
}
