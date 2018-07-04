//
//  Utils.swift
//  listUps
//
//  Created by Nimtur K. on 12/21/17.
//  Copyright © 2017 Selecto. All rights reserved.
//

import Foundation
import UIKit
//import Kingfisher
import SafariServices

class Utils {
    
   
    
    
    //MARK: - TOP VIEWCONTROLLER
    
    static func topViewController(base: UIViewController? = APP_DELEGATE.window?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
    
    //MARK: - ALERT ACTIONS
    
    static func showSimpleAlert(message: String) {
        Utils.showSimpleAlertWithMessage(message: message, title: "")
    }
    
    static func showSimpleAlertWithMessage(message: String, title: String) {
        guard let topVC = Utils.topViewController(), !topVC.isKind(of: UIAlertController.self) else {
            return
        }
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alertVC.view.tintColor = UIColor.blue
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel) { action in
            alertVC.dismiss(animated: true, completion: nil)
        }
        
        alertVC.addAction(actionCancel)
        
        topVC.present(alertVC, animated: true, completion: nil)
    }
    
    static func showSimpleAlertWithMessage(message: String, title: String, completionBlock: @escaping void_block) {
        guard let topVC = Utils.topViewController(), !topVC.isKind(of: UIAlertController.self) else {
            return
        }
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alertVC.view.tintColor = UIColor.blue
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel) { action in
            alertVC.dismiss(animated: true, completion: nil)
            completionBlock()
        }
        
        alertVC.addAction(actionCancel)
        
        topVC.present(alertVC, animated: true, completion: nil)
    }
    
    static func standartAlertMessage(message: String, title: String, completionBlock: @escaping void_block){
        guard let topVC = Utils.topViewController(), !topVC.isKind(of: UIAlertController.self) else {
            return
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: "OK", style: .cancel) { action in
            alertController.dismiss(animated: true, completion: nil)
            completionBlock()
        }
        alertController.addAction(actionCancel)
        topVC.present(alertController, animated: true, completion: nil)
        
        return
    }
    
    static func showSimpleAlertWithMessage(message: String, title: String, buttons: [String], completionBlock: @escaping int_block) {
        guard let topVC = Utils.topViewController(), !topVC.isKind(of: UIAlertController.self) else {
            return
        }
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        for button in buttons.enumerated() {
            var actionItem = UIAlertAction()
            if button.element == "Never"{
                actionItem = UIAlertAction(title: button.element, style: .destructive) { action in
                    alertVC.dismiss(animated: true, completion: nil)
                    completionBlock(button.offset)
                }
            }else{
                actionItem = UIAlertAction(title: button.element, style: .default) { action in
                    alertVC.dismiss(animated: true, completion: nil)
                    completionBlock(button.offset)
                }
            }
            alertVC.addAction(actionItem)
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .default) { action in
            alertVC.dismiss(animated: true, completion: nil)
        }
        alertVC.addAction(actionCancel)
        
        topVC.present(alertVC, animated: true, completion: nil)
    }
  
}
