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
import Firebase
import GoogleSignIn
class WelcomeVC: UIViewController {

    
    @IBOutlet var welcomeView: WelcomeView!
    private var welcomeViewModal: WelcomeViewModelProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        welcomeView.updateUI()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        welcomeViewModal = WelcomeViewModel(view: self)
    }
    
    
   
    // MARK:- Public Methods
    class func create() -> WelcomeVC {
        
        let welcomeVC: WelcomeVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.welcomeVC)
        welcomeVC.welcomeViewModal = WelcomeViewModel(view: welcomeVC)
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
    
    @IBAction func googlePressed(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
   
    
    
    
    
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
            
            self.welcomeViewModal.SignUp(email: self.welcomeView.email)
            
        }
    }
}
extension WelcomeVC: GIDSignInDelegate {
    // MARK:- Google SignUp
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
       
        if let error = error {
            print("failed To sign in", error)
            return
        }
        guard let authentication  = user.authentication else {return}
        let credintial = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        self.welcomeView.email = user.profile.email

        Auth.auth().signIn(with: credintial) { (result, err) in
            if let error = error {
                print("failed To sign in", error)
                return
            }
            guard let myEmail = result?.user.email else {return}
            self.welcomeView.email = myEmail
            print(self.welcomeView.email)
            self.welcomeViewModal.SignUp(email: self.welcomeView.email)
        }
    }
}
extension WelcomeVC: SignUpProtocol {
    
    func presentSignIn() {
        let signInVC = SignInVC.create()
        self.present(signInVC ,animated: true, completion: nil)
    }
    
    func hideLoader() {
        self.view.hideLoader()
    }
    
    func showLoader() {
        self.view.showLoader()
    }
    
    func showAlert(title: String, msg: String) {
        self.show_Alert(title, msg)
    }
    func presentTabBar() {
        let tabVC = TabBarController.create()
        self.present(tabVC ,animated: true, completion: nil)
    }
}
