//
//  WelcomeViewModal.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 4/2/21.
//

import Foundation
protocol WelcomeViewModelProtocol {
    func SignUp(email: String)
    
}
class WelcomeViewModel{
    
    // MARK:- Properties
    weak var view: SignUpProtocol!
    var delegate: WelcomeViewModelProtocol?
    // MARK:- Initialization Methods
    init(view: SignUpProtocol) {
        self.view = view
    }
}
extension WelcomeViewModel: WelcomeViewModelProtocol {
    func SignUp(email: String) {
        print(email)
        self.view.showLoader()
        APIManager.VendorRegister(storeName: "", emailNumber: email, landLine: "", storeLocation:  "", storeFile: "" , password: "") { (response) in
            switch response {
            case .failure(let err):
                print(err)
                self.view.showAlert(title: "Sorry!", msg: "Email Is Aleardy Token.")
                self.view.hideLoader()
            case .success(let result):
                print(result)
                UserDefaultsManager.shared().Email = result.data?.emailNumber
                self.view.hideLoader()
                self.view.presentTabBar()
            }
        }
    }
}
