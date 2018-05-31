//
//  SELConstants.swift
//  listUps
//
//  Created by Sergii Lyahovchuk on 14.12.2017.
//  Copyright © 2017 Selecto. All rights reserved.
//

import UIKit

let kMainStoryboard = UIStoryboard(name: "Main", bundle: nil)
let APP_DELEGATE = UIApplication.shared.delegate as! AppDelegate

struct inAppFonts {
    
    static let SomeFont_14 = UIFont(name: "SomeFont", size: 14)
}

struct Constants {
    
    static let DATABASE_NAME = "SecuredAccount"
    
    static let ONE_PX = (1.0 / UIScreen.main.scale)
    static let FASTER_ANIMATION_DURATION = 0.15
    static let DEFAULT_ANIMATION_DURATION = 0.25
    static let SLOWER_ANIMATION_DURATION  = 0.5
}

struct StoryboardID {
    static let NavigationController = "NavigationController"
}

struct ViewControllerIDs {
    
    static let kRootNavigationController = "NavigationController"
    
}

struct RegExPatterns {
    static let email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    static let secret = "[^a-zA-Z0-9]"
    static let getSecret = "(?<=secret=)(.*?)(?=&)"
    static let getIssuer = "(?<=issuer=)(.*)[^13]"
    static let getAccountDetails = "(?<=totp/)(.*)(?=[?])"
}

public struct UDEF {
    static let SomeParameterId            = "Id"
}

public struct FolderNames {
    static let savedLots = "SavedLots"
}
