//
//  Constants.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 3/22/21.
//

import Foundation
// Storyboards
struct Storyboards {
    static let main = "Main"
    static let OrderDetails = "OrderDetails"
    static let OrderConfirmation = "OrderConfirmation"
    static let ProductsInfo = "ProductsInfo"
}

// View Controllers
struct ViewControllers {
    static let welcomeVC = "WelcomeVC"
    static let signInVC =  "SignInVC"
    static let signUpVC =  "SignUpVC"
    static let loginPhoneVC = "LoginPhoneVC"
    static let phoneVerifyVC = "PhoneVerifyVC"
    static let TabBarController = "TabBarController"
    static let OrdersStatusVC = "OrdersStatusVC"
    static let ProductInfoVC = "ProductInfoVC"
    
}
struct URLs {
    // MARK:- base
    static let base = "http://penprnt.com/penprnt/api/"
    static let vendorSignUp = "signUp"
    static let login = "login"
    static let order = "getALLOrderVendor"
    static let updateStatusOrder = "updateStatusOrder"
    static let uploadPhoto = base + "uploadImage"
    static let product = "product"
    static let createCategory = "createCategory"
    static let SubCategory = "SubCategory"
}
struct ParameterKeys {
    static let storeName = "storeName"
    static let emailNumber = "emailNumber"
    static let landLine = "landLine"
    static let storeLocation = "storeLocation"
    static let storeFile = "storeFile"
    static let password = "password"
    
}
struct UserDefaultsKeys {
    static let token = "token"
    static let email = "email"
    static let VendorID = "VendorID"
}
struct TableCells {
    static let orderCell = "cell"
}
