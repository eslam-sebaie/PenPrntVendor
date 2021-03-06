//
//  PhoneVerifyVC.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 3/25/21.
//

import UIKit
import SGCodeTextField
import FirebaseAuth
class PhoneVerifyVC: UIViewController {
    
    @IBOutlet var phoneVerifyView: PhoneVerifyView!
    var verificationID = ""
    var email = ""
    var name = ""
    var phone = ""
    var address = ""
    var image = ""
    var password = ""
    private var phoneViewModal: WelcomeViewModelProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneVerifyView.updateUI()
        
    }
    
    class func create() -> PhoneVerifyVC {
        let phoneVerifyVC: PhoneVerifyVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.phoneVerifyVC)
        phoneVerifyVC.phoneViewModal = WelcomeViewModel(view: phoneVerifyVC)
        return phoneVerifyVC
    }
    
    
    @IBAction func verifyPressed(_ sender: Any) {
        
        if self.phoneVerifyView.tf_otp.text?.count == 6 {
            let credienial = PhoneAuthProvider.provider().credential(withVerificationID: self.verificationID, verificationCode: self.phoneVerifyView.tf_otp.text!)
            Auth.auth().signIn(with: credienial) { (authData, error) in
                if error != nil {
                    print(error)
                    self.show_Alert("Sorry!", "Invalid Code")
                }
                else {
                    self.phoneVerifyView.showLoader()
                    APIManager.VendorRegister(storeName: self.name, emailNumber: self.email, landLine: self.phone, storeLocation: self.address, storeFile: self.image , password: self.password) { (response) in
                        switch response {
                        case .failure(let err):
                            print(err)
                            self.showAlert(title: "Sorry!", msg: "Email Is Aleardy Token.")
                            self.phoneVerifyView.hideLoader()
                        case .success(let result):
                            print(result)
                            self.phoneVerifyView.hideLoader()
                            let signInVC = SignInVC.create()
                            self.present(signInVC ,animated: true, completion: nil)
                       
                        }
                    }
                }
            }
        }
        else {
            show_Alert("Sorry!", "Please Complete Verification Number.")
        }
        
    }
    
    
    
    
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func hide(sender: SGCodeTextField){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        hideKeyboardWhenTappedAround()
    }
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
extension PhoneVerifyVC: SignUpProtocol{
    
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
