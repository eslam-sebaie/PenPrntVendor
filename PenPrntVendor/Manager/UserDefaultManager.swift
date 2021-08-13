//
//  UserDefaultManager.swift
//  PatientHistory
//
//  Created by Abdul Rahman Alansari on 11/19/20.
//  Copyright © 2020 Eslam Sebaie. All rights reserved.
//

import Foundation
class UserDefaultsManager {
    
    // MARK:- Singleton
    private static let sharedInstance = UserDefaultsManager()
    
    class func shared() -> UserDefaultsManager {
        return UserDefaultsManager.sharedInstance
    }
    
    // MARK:- Properties

    
    var Token: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.token)
        }
        get {
            guard UserDefaults.standard.object(forKey: UserDefaultsKeys.token) != nil else {
                return nil
            }
            return UserDefaults.standard.string(forKey: UserDefaultsKeys.token)
        }
    }
    
    var Email: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.email)
        }
        get {
            guard UserDefaults.standard.object(forKey: UserDefaultsKeys.email) != nil else {
                return nil
            }
            return UserDefaults.standard.string(forKey: UserDefaultsKeys.email)
        }
    }
    var VendorID: IntegerLiteralType? {
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.VendorID)
        }
        get {
            guard UserDefaults.standard.object(forKey: UserDefaultsKeys.VendorID) != nil else {
                return nil
            }
            return UserDefaults.standard.integer(forKey: UserDefaultsKeys.VendorID)
        }
    }
    
}
