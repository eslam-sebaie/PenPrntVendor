//
//  SignUpVC.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 3/23/21.
//

import UIKit

class SignUpVC: UIViewController, sendingAddress {

    @IBOutlet var signupView: SignUpView!
    override func viewDidLoad() {
        super.viewDidLoad()
        signupView.updateUI()
        
    }
    
    class func create() -> SignUpVC {
        let signUpVC: SignUpVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.signUpVC)
        return signUpVC
    }
    
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func mapPressed(_ sender: Any) {
        instantiateMapVC()
    }
    func send(address: String) {
        signupView.storeLocationTF.text = address
    }

    
    @IBAction func signUpPressed(_ sender: Any) {
        
        let tabVC = TabBarController.create()
        self.present(tabVC ,animated: true, completion: nil)
    }
}

