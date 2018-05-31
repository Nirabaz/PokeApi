//
//  SELUserDefSettings.swift
//  listUps
//
//  Created by Sergii Lyahovchuk on 2/15/18.
//  Copyright © 2018 Selecto. All rights reserved.
//

import Foundation

final class SELUserDefSettings {
    
    //-------------------------------------------------------------------------------------------
    // MARK: - Get value
    //-------------------------------------------------------------------------------------------
    
    class func getObject(key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
    
    class func getInt(key: String) -> Int {
        return UserDefaults.standard.integer(forKey: key)
    }
    
    class func getBool(key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
    
    class func getFloat(key: String) -> Float {
        return UserDefaults.standard.float(forKey: key)
    }
    
    class func getString(key: String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }
    
    class func getData(key: String) -> Data? {
        return UserDefaults.standard.data(forKey: key)
    }
    
    class func getArray(key: String) -> [Any]? {
        return UserDefaults.standard.array(forKey: key)
    }
    
    class func getDictionary(key: String) -> [String: Any]? {
        return UserDefaults.standard.dictionary(forKey: key)
    }
    
    
    //-------------------------------------------------------------------------------------------
    // MARK: - Get value with default value
    //-------------------------------------------------------------------------------------------
    
    class func getObject(key: String, defaultValue: Any) -> Any? {
        if getObject(key: key) == nil {
            return defaultValue
        }
        return getObject(key: key)
    }
    
    class func getInt(key: String, defaultValue: Int) -> Int {
        if getObject(key: key) == nil {
            return defaultValue
        }
        return getInt(key: key)
    }
    
    class func getBool(key: String, defaultValue: Bool) -> Bool {
        if getObject(key: key) == nil {
            return defaultValue
        }
        return getBool(key: key)
    }
    
    class func getFloat(key: String, defaultValue: Float) -> Float {
        if getObject(key: key) == nil {
            return defaultValue
        }
        return getFloat(key: key)
    }
    
    class func getString(key: String, defaultValue: String) -> String? {
        if getObject(key: key) == nil {
            return defaultValue
        }
        return getString(key: key)
    }
    
    class func getData(key: String, defaultValue: Data) -> Data? {
        if getObject(key: key) == nil {
            return defaultValue
        }
        return getData(key: key)
    }
    
    class func getArray(key: String, defaultValue: [Any]) -> [Any]? {
        if getObject(key: key) == nil {
            return defaultValue
        }
        return getArray(key: key)
    }
    
    class func getDictionary(key: String, defaultValue: [String: Any]) -> [String: Any]? {
        if getObject(key: key) == nil {
            return defaultValue
        }
        return getDictionary(key: key)
    }
    
    
    //-------------------------------------------------------------------------------------------
    // MARK: - Set value
    //-------------------------------------------------------------------------------------------
    
    class func setObject(key: String, value: Any?) {
        if value == nil {
            UserDefaults.standard.removeObject(forKey: key)
        } else {
            UserDefaults.standard.set(value, forKey: key)
        }
        
        Sync()
    }
    
    class func setInt(key: String, value: Int) {
        UserDefaults.standard.set(value, forKey: key)
        Sync()
    }
    
    class func setBool(key: String, value: Bool) {
        UserDefaults.standard.set(value, forKey: key)
        Sync()
    }
    
    class func setFloat(key: String, value: Float) {
        UserDefaults.standard.set(value, forKey: key)
        Sync()
    }
    
    class func setString(key: String, value: String?) {
        if (value == nil) {
            UserDefaults.standard.removeObject(forKey: key)
        } else {
            UserDefaults.standard.set(value, forKey: key)
        }
        Sync()
    }
    
    class func setData(key: String, value: Data) {
        setObject(key: key, value: value)
    }
    
    class func setArray(key: String, value: NSArray) {
        setObject(key: key, value: value)
    }
    
    
    class func setDictionary(key: String, value: NSDictionary) {
        setObject(key: key, value: value)
    }
    
    
    //-------------------------------------------------------------------------------------------
    // MARK: - Synchronize
    //-------------------------------------------------------------------------------------------
    
    class func Sync() {
        UserDefaults.standard.synchronize()
    }
    
    //-------------------------------------------------------------------------------------------
    // MARK: - Remove value
    //-------------------------------------------------------------------------------------------
    
    class func removeValueBy(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        Sync()
    }
}
