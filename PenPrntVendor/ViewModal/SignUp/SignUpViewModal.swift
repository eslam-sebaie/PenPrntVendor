//
//  SignUpViewModal.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 4/2/21.
//

import UIKit
protocol SignUpViewModelProtocol {
    func SignUp(email: String?, landlineNumber: String?, storeName: String?, storeLocation: String?, password: String?, image: String?)
    func saveImage(image: UIImage?) -> String
}
class SignUpViewModel{
    
    // MARK:- Properties
    weak var view: SignUpProtocol!
    var imag: String = ""
    // MARK:- Initialization Methods
    init(view: SignUpProtocol) {
        self.view = view
    }
}
extension SignUpViewModel: SignUpViewModelProtocol {
    func SignUp(email: String?, landlineNumber: String?, storeName: String?, storeLocation: String?, password: String?, image: String?) {
        
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
            APIManager.VendorRegister(storeName: storeName ?? "", emailNumber: email, landLine: landlineNumber ?? "", storeLocation: storeLocation ?? "", storeFile: image ?? "" , password: password) { (response) in
                switch response {
                case .failure(let err):
                    print(err)
                    self.view.showAlert(title: "Sorry!", msg: "Email Is Aleardy Token.")
                    self.view.hideLoader()
                case .success(let result):
                    print(result)
                    self.view.hideLoader()
                    self.view.presentSignIn()
                }
            }
        }
        
        
        
    }
    
    func saveImage(image: UIImage?) -> String {
        self.view.showLoader()
        APIManager.uploadPhoto(image: image!) { (err, img) in
            self.view.hideLoader()
            print(img?.data ?? "")
            self.imag = img?.data ?? ""
        }
        return imag
    }
    
    
}
