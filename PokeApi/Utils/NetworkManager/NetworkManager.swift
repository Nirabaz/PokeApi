//
//  SELNetworkManager.swift
//  listUps
//
//  Created by Sergii Lyahovchuk on 09.01.2018.
//  Copyright © 2018 Selecto. All rights reserved.
//

import UIKit
//import Reachability
//
//class SELNetworkManager: NSObject {
//
//    static let sharedManager = SELNetworkManager()
//    private let reachability = Reachability()!
//
//    private override init() {
//        super.init()
//        observeInternetConnection()
//        print("SELNetworkManager - init")
//    }
//
//    private func observeInternetConnection() {
//        // Internet is reachable
//        reachability.whenReachable = { reachability in
//            if reachability.connection == .wifi {
//                print("Reachable via WiFi")
//            } else {
//                print("Reachable via Cellular")
//            }
//
//            NotificationCenter.default.post(name: .SELNetworkDidBecomeReachableNotification, object: nil)
//        }
//
//        // Internet is not reachable
//        reachability.whenUnreachable = { _ in
//            print("Not reachable")
//            NotificationCenter.default.post(name: .SELNetworkDidBecomeUnreachableNotification, object: nil)
//        }
//
//        do {
//            try reachability.startNotifier()
//        } catch {
//            print("Unable to start notifier")
//        }
//    }
//
//    func isInternetReachable() -> Bool {
//        switch reachability.connection {
//        case .wifi:
//            print("Reachable via WiFi")
//            return true
//        case .cellular:
//            print("Reachable via Cellular")
//            return true
//        case .none:
//            print("Network not reachable")
//            return false
//        }
//    }
//
//}
