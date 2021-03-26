//
//  ViewController.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 3/22/21.
//

import UIKit
import FacebookCore
import FacebookLogin
import SwiftyJSON
import FirebaseAuth
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

    @IBAction func faceBookPressed(_ sender: Any) {
        handleFacebook()
    }
    
    // MARK:- Google SignUp
    
    
}



extension WelcomeVC {
    
    // MARK:- FaceBook Login
    func handleFacebook(){
        print("in Handle")
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [.publicProfile, .email, .userGender, .userBirthday], viewController: self) { (result) in
            
            switch result {
            case .success(granted: _, declined: _, token: _):
                print("Succefully logged to faceBook")
                self.signIntoFirebase()
                
            case .failed(let err):
                print(err)
                
            case .cancelled:
                print("canceled")
                
            }
        }
    }
    func signIntoFirebase(){
        print("signIntoFirebase")
        guard let authenticationToken = AccessToken.current?.tokenString else {return}
        let credintial = FacebookAuthProvider.credential(withAccessToken: authenticationToken)
        Auth.auth().signIn(with: credintial) { (user, err) in
            if err != nil {
                print("error")
                return
            }
            self.fetchFacebookUser()
        }
    }
    
    
    func fetchFacebookUser(){
        
        GraphRequest(graphPath: "/me", parameters: ["fields": "id, email, name, first_name, last_name, gender, birthday, picture.type(large)"]).start { (connection, result, err) in
            if err != nil {
                print("Fail")
                return
            }
            
            let json = JSON(result)
            self.welcomeView.name = json["name"].string ?? ""
            self.welcomeView.email = json["email"].string ?? ""
            print(self.welcomeView.name)
            print(self.welcomeView.email)
            
            // navigate to Continue Sign Up
            
        }
    }
}
