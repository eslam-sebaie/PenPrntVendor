//
//  ViewController.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 3/22/21.
//

import UIKit

class WelcomeVC: UIViewController {

    
    @IBOutlet var welcomeView: WelcomeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeView.updateUI()
    }

    // MARK:- Public Methods
    class func create() -> WelcomeVC {
        let welcomeVC: WelcomeVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.welcomeVC)
        return welcomeVC
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        let signIn = SignInVC.create()
        self.present(signIn, animated: true, completion: nil)
    }
    
    
    @IBAction func continueWithPhonePressed(_ sender: Any) {
        let phoneVC = LoginPhoneVC.create()
        self.present(phoneVC, animated: true, completion: nil)
    }
    

}

