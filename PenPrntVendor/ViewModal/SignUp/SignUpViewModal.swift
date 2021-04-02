//
//  SignUpViewModal.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 4/2/21.
//

import Foundation
protocol SignUpViewModelProtocol {
    func SignUp(email: String?, landlineNumber: String?, storeName: String?, storeLocation: String?, password: String?)
    
}
class SignUpViewModel{
    
    // MARK:- Properties
    weak var view: SignUpProtocol!
    
    // MARK:- Initialization Methods
    init(view: SignUpProtocol) {
        self.view = view
    }
}
extension SignUpViewModel: SignUpViewModelProtocol {
    func SignUp(email: String?, landlineNumber: String?, storeName: String?, storeLocation: String?, password: String?) {
        
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
            // SignUp API And dismiss To SignIn
            print("OK")
            
        }
        
        
        
    }
    
    
}
