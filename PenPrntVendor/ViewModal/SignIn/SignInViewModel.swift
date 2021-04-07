//
//  SignInViewModel.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 4/2/21.
//

import Foundation
protocol SignInViewModelProtocol {
    func SignIn(email: String?, password: String?)
    
}
class SignInViewModel{
    
    // MARK:- Properties
    weak var view: SignUpProtocol!
    
    // MARK:- Initialization Methods
    init(view: SignUpProtocol) {
        self.view = view
    }
}
extension SignInViewModel: SignInViewModelProtocol {
    func SignIn(email: String?, password: String?) {
        guard let email = email, email != "" else {
            self.view.showAlert(title: "Please", msg: "Enter Your Email")
            
            return
        }
        guard let password = password, password != "" else {
            self.view.showAlert(title: "Please", msg: "Enter Your Password")
            return
        }
        
        let response = Validation.shared.validate(values: (type: Validation.ValidationType.email, email),(Validation.ValidationType.password,password))
        
        switch response {
        case .failure(_, let message):
            self.view.showAlert(title: "Invalid", msg: message.localized())
        case .success:
            self.view.showLoader()
            APIManager.VendorLogin(emailNumber: email, password: password) { (response) in
                switch response {
                case .failure(let err):
                    print(err)
                    self.view.showAlert(title: "Sorry!", msg: "Email Or Password Is Wrong.")
                    self.view.hideLoader()
                case .success(let result):
                    print(result)
                    UserDefaultsManager.shared().Token = result.message
                    UserDefaultsManager.shared().Email = result.data?.emailNumber
                    self.view.hideLoader()
                    self.view.presentTabBar()
                }
            }
            
        }
    }
    
    
}
