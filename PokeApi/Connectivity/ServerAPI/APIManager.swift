//
//  SELAPIManager.swift
//  PokeApi
//
//  Created by Mykhailo Zabarin on 5/31/18.
//  Copyright © 2018 Selecto. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    
    // MARK: - Properties
    
    private static var sharedNetworkManager: APIManager = {
        return APIManager()
    }()
    
    // Initialization
    
    private init() {
    }
    
    // MARK: - Accessors
    
    class func shared() -> APIManager {
        return sharedNetworkManager
    }
    
    // MARK: - Private Methods
    
    private func isOnline() -> Bool {
        if SELNetworkManager.sharedManager.isInternetReachable() {
            return true
        }
        return false
    }
    
    private func fireRequestWith(router: BaseRouter, completionHandler: @escaping api_success_block) {
        if isOnline(){
//            print("API -->: \(router.path), params: \(String(describing: router.parameters))")
            Alamofire.request(router).validate().responseJSON(completionHandler: {[weak self](response) in
                guard let strongSelf = self else {return}
//                print("Request: \(String(describing: response.request!))")  // original url request
//                print("Result: \(response.result)")                         // response serialization result
                
                guard response.result.error == nil else {
                    let statusCode = response.response?.statusCode ?? -1
                    print("Status Code = \(statusCode)")
                    let errMessage = strongSelf.getErrorText(strongSelf.jsonFromData(response.data))
                    print("Error: \(errMessage)")
                    completionHandler(false, nil, errMessage)
                    return
                }
                
                guard let json = response.result.value as? [String: Any] else {
                    if let array = response.result.value as? [Any] {
                    //    print("API <---: \(router.path), response: \(array)")
                        completionHandler(true, ["items": array], nil)
                        return
                    }
                    print("didn't get todo object as JSON from API")
                    //                print("Error: \(response.result.error)")
                    completionHandler(false, nil, "JSON Decode error")
                    return
                }
                
               // print("API <---: \(router.path), response: \(json)")
                completionHandler(true, json, nil)
            })
        }
    }
    
    func getItemById(itemId: Int, success: @escaping api_success_block) {
        let router = PokemonRouter(anEndpoint: .GetPokemonById(itemId, nil))
        self.fireRequestWith(router: router, completionHandler: success)
    }
    
    
    
    //-------------------------------------------------------------------------------------------
    // MARK: - Handle errors
    //-------------------------------------------------------------------------------------------
    
    func jsonFromData(_ data: Data?) -> APIParams {
        guard let json = try? JSONSerialization.jsonObject(with: data!) as? [String: Any] else {
            return nil
        }
        
        return json
    }
    
    func getErrorText(_ dict:APIParams) -> String {
        guard let dict = dict else {
            return "Server error"
        }
        
        print("Error: \(dict)")
        
        guard let errorMsg = dict["error"] as? String else {
            return "Server error"
        }
        
        return errorMsg
    }

}
