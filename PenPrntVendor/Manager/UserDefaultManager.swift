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

    
//    var VendorPhone: String? {
//        set {
//            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.VendorPhone)
//        }
//        get {
//            guard UserDefaults.standard.object(forKey: UserDefaultsKeys.VendorPhone) != nil else {
//                return nil
//            }
//            return UserDefaults.standard.string(forKey: UserDefaultsKeys.VendorPhone)
//        }
//    }
    
}
