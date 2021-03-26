//
//  SignInVC.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 3/23/21.
//

import UIKit

class SignInVC: UIViewController {

    @IBOutlet var signInView: SignInView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInView.updateUI()
    }
    
    class func create() -> SignInVC {
        let signInVC: SignInVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.signInVC)
        return signInVC
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        let signUp = SignUpVC.create()
        self.present(signUp, animated: true, completion: nil)
        
        
    }
    

}
