//
//  ExtUIApplication.swift
//  listUps
//
//  Created by Roma Osiychuk on 12.02.18.
//  Copyright © 2018 Selecto. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    class func openAppSettings() {
        UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
    }

}
