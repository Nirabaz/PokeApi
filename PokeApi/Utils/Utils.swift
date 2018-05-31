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
    
    // MARK: - String Functions
    static func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    static func deleteFirstAndLastSpacesFromString (str: String) -> String?  {
        var resultString = str
        
        while (resultString.first == " ") && (!resultString.isEmpty) {
            resultString.remove(at: resultString.startIndex)
        }
        
        while (resultString.last == " ") && (!resultString.isEmpty) {
            resultString.remove(at: resultString.index(before: resultString.endIndex))
        }
        
        return resultString
    }
    
    static func matchingStrings(str: String, regex: String) -> String {
        guard let regex = try? NSRegularExpression(pattern: regex, options: []) else { return "" }
        let nsString = str as NSString
        
        let match = regex.firstMatch(in: str, options:.init(rawValue: 0), range: NSRange.init(location: 0, length: nsString.length))
        if (match != nil) {
            let matchRange = match?.range(at: 1)
            let matchString = nsString.substring(with: matchRange!)
            if (matchString.isNotEmpty) {
                return matchString
            }
        }
        return ""
    }
    
    // MARK: -  Filemanager methods
    
    static func getFolderBy(name: String) -> URL? {
        let fileManager = FileManager.default
        if let tDocumentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let filePath = tDocumentDirectory.appendingPathComponent(name)
            let myFilePath = filePath.path
            let exist = Utils.directoryExistsAtPath(myFilePath)
            if !exist{
                do {
                    try fileManager.createDirectory(atPath: filePath.path,
                                                    withIntermediateDirectories: false,
                                                    attributes: nil)
                } catch {
                    print("Error creating images folder in documents dir: \(error)")
                }
            }
            return filePath
        }
        return nil
    }
    
    static func removeFileAtPath(_ filePath: String) {
        let fileManager = FileManager.default
        
        do {
            try fileManager.removeItem(atPath: filePath)
            print("file removed --->>> \(filePath)")
        }
        catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
    }
    
    static func directoryExistsAtPath(_ path: String) -> Bool {
        var isDirectory = ObjCBool(true)
        let exists = FileManager.default.fileExists(atPath: path, isDirectory: &isDirectory)
        return exists && isDirectory.boolValue
    }
    
    static func getAllFilesInFolderWith(url: URL) -> [URL]? {
        let fileManager = FileManager.default
        do {
            return try fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
        } catch {
            print("Error while enumerating files \(url): \(error.localizedDescription)")
            return nil
        }
    }
    
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
    
    //MARK: - Clear image cache
//    static func clearAllImageCache() {
//        let cache = ImageCache.default
//        // Clear memory cache right away.
//        cache.clearMemoryCache()
//
//        // Clear disk cache. This is an async operation.
//        cache.clearDiskCache()
//
//        // Clean expired or size exceeded disk cache. This is an async operation.
//        cache.cleanExpiredDiskCache()
//    }
    
    static func openWithSafariVC(url: String, parentVC: BaseVC){
        let svc = SFSafariViewController(url: URL.init(string: url)!)
        svc.delegate = parentVC
        svc.preferredControlTintColor = UIColor.colorWithHexString(hex: "271C44")
        //        svc.
        parentVC.present(svc, animated: true, completion: nil)
    }
    
    //MARK: - Other
    static func getDeviceOrientation() -> UIImageOrientation {
        var currentDevice: UIDevice
        currentDevice = .current
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        var deviceOrientation: UIDeviceOrientation
        deviceOrientation = currentDevice.orientation
        
        var imageOrientation: UIImageOrientation!
        
        if deviceOrientation == .portrait {
            imageOrientation = .right
        }else if (deviceOrientation == .landscapeLeft){
            imageOrientation = .up
        }else if (deviceOrientation == .landscapeRight){
            imageOrientation = .down
        }else{
            imageOrientation = .right
        }
        return imageOrientation
    }
}
