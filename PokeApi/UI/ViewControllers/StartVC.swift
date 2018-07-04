//
//  StartVC.swift
//  PokeApi
//
//  Created by Mykhailo Zabarin on 5/31/18.
//  Copyright © 2018 Selecto. All rights reserved.
//

import UIKit

class StartVC: BaseVC {
    
    @IBOutlet weak var infoTF: UITextView!
    @IBOutlet weak var idInputTF: UITextField!
    
    var myPokemon: PokemonML?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func onFindBtnPress(_ sender: Any) {
        idInputTF.resignFirstResponder()
        if let idString = idInputTF.text{
            if let idForSearch = Int(idString){
                getModel(id : idForSearch)
            } else {
                Utils.standartAlertMessage(message: idString == "" ? "You need to enter id for search" : "Id could be numeric type only", title: "Error!", completionBlock: {})
            }
        }
    }
    
    func getModel(id: Int) {
        guard let idString = idInputTF.text, let id = Int(idString)  else {return}
        let _ = APIManager.shared().getItemById(itemId: id) { [weak self](result, response, errMsg) in
            guard let strongSelf = self else { return }
            if result{
                do{
                    guard let responseDictionary = response else {return}
                    strongSelf.myPokemon = try PokemonML.self(from: responseDictionary)
                    print("success")
                    strongSelf.infoTF.text = strongSelf.myPokemon?.stringDescription
                } catch {
                    Utils.standartAlertMessage(message: "Something went wrong", title: "Error!", completionBlock: {})
                }
            }else{
                if errMsg != nil{
                    Utils.standartAlertMessage(message: "There is no pokemon with this id", title: "Error!", completionBlock: {})
                }
            }
        }
    }
    
}

