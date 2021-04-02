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
        // SignUp And Go To Tab Bar
    }
}
