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
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneVerifyView.updateUI()
        
    }
    
    class func create() -> PhoneVerifyVC {
        let phoneVerifyVC: PhoneVerifyVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.phoneVerifyVC)
        return phoneVerifyVC
    }
    
    
    @IBAction func verifyPressed(_ sender: Any) {
        
        if self.phoneVerifyView.tf_otp.text?.count == 6 {
            let credienial = PhoneAuthProvider.provider().credential(withVerificationID: self.verificationID, verificationCode: self.phoneVerifyView.tf_otp.text!)
            Auth.auth().signIn(with: credienial) { (authData, error) in
                if error != nil {
                    self.show_Alert("Code Error")
                }
                else {
                    print("Auth success" + (authData?.user.phoneNumber)!)
                    // write Api SignUp Function
                }
            }
        }
        else {
            show_Alert("Please Complete Verification Number.")
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
