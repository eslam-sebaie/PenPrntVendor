//
//  SignUpVC.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 3/23/21.
//

import UIKit
import SKCountryPicker
import FirebaseAuth
// MARK:- Protocols
protocol SignUpProtocol: class {
    func hideLoader()
    func showLoader()
    func showAlert(title: String , msg: String)
    func presentTabBar()
    func presentSignIn()
}
class SignUpVC: UIViewController, sendingAddress {

    @IBOutlet var signupView: SignUpView!
    private var signUpViewModel: SignUpViewModelProtocol!
    var storeImg: String!
    var email = ""
    var name = ""
    var phone = ""
    var address = ""
    var image = ""
    var password = ""
    var imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCountryCode()
        signupView.updateUI()
        imagePicker.delegate = self
        
    }
    
    class func create() -> SignUpVC {
        let signUpVC: SignUpVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.signUpVC)
        signUpVC.signUpViewModel = SignUpViewModel(view: signUpVC)
        return signUpVC
    }
    @IBAction func uploadPressed(_ sender: Any) {
        setImagePicker()
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        let signIn = SignInVC.create()
        self.present(signIn, animated: true, completion: nil)
    }
    
    @IBAction func mapPressed(_ sender: Any) {
        instantiateMapVC()
    }
    func send(address: String) {
        signupView.storeLocationTF.text = address
    }

    @IBAction func signUpPressed(_ sender: Any) {
//        self.signUpViewModel.SignUp(email: signupView.emailPhoneTF.text, landlineNumber: signupView.landlineTF.text, storeName: signupView.storeNameTF.text, storeLocation: signupView.storeLocationTF.text, password: signupView.passwordTF.text, image: storeImg)
        
        
        
        guard let email = signupView.emailPhoneTF.text, email != "" else {
            self.showAlert(title: "Please", msg: "Enter Store Email")
            
            return
        }
        guard let phone = signupView.landlineTF.text, phone != "" else {
            self.show_Alert("Please", "Enter Store Phone Number")
            return
        }
        guard let name = signupView.storeNameTF.text, name != "" else {
            self.showAlert(title: "Please", msg: "Enter Store Name")
            
            return
        }
        
        guard let address = signupView.storeLocationTF.text, address != "" else {
            self.show_Alert("Please", "Enter Store Address")
            return
        }
        
        guard let password = signupView.passwordTF.text, password != "" else {
            self.showAlert(title: "Please", msg: "Enter Store Password")
            return
        }
        guard let img = storeImg, img != "" else {
            self.showAlert(title: "Please", msg: "Enter Store Image")
            return
        }
        print("%^")
        print(img)
        
        let response = Validation.shared.validate(values: (type: Validation.ValidationType.email, email))
        
        switch response {
        case .failure( _):
            self.showAlert(title: "Invalid", msg: "SomeThing Went Wrong.")
        case .success:
            self.email = email
            self.name = name
            self.phone = phone
            self.address = address
            self.image = img
            self.password = password
            self.checkotp()
          
        }
        
        
    }
    func checkotp() {
        // +201142373945
        signupView.phoneNumberWithCode = signupView.codeLabel.text! + signupView.landlineTF.text!
        print(signupView.phoneNumberWithCode)
        PhoneAuthProvider.provider().verifyPhoneNumber(signupView.phoneNumberWithCode, uiDelegate: nil) { (verificationID, error) in
            if error == nil{
                self.signupView.verification_id = verificationID
                if self.signupView.verification_id != nil {
                    self.hideLoader()
                    let phoneVerify = PhoneVerifyVC.create()
                    phoneVerify.verificationID = verificationID!
                    phoneVerify.email = self.email
                    phoneVerify.name = self.name
                    phoneVerify.phone = self.phone
                    phoneVerify.address = self.address
                    phoneVerify.image = self.image
                    phoneVerify.password = self.password
                    self.present(phoneVerify, animated: true, completion: nil)
//                    self.signupView.mainOTPView.isHidden = false
                }
            }
            else {
                self.show_Alert("Sorry!", "You Are Blocked Try Later")
            }
        }
    }
    
    @IBAction func codePressed(_ sender: Any) {
        let countryController = CountryPickerWithSectionViewController.presentController(on: self) { [weak self] (country: Country) in
            
            guard let self = self else { return }
            self.signupView.codeImage.image = country.flag
            self.signupView.codeLabel.text = country.dialingCode
        }
        countryController.flagStyle = .corner
        countryController.detailColor = UIColor.red
    }
    func updateCountryCode() {
        let countryController = CountryPickerWithSectionViewController.presentController(on: self) { [weak self] (country: Country) in
            
            guard let self = self else { return }
            self.signupView.codeImage.image = country.flag
            self.signupView.codeLabel.text = country.dialingCode
            
        }
        
        guard let country = CountryManager.shared.currentCountry else {
            self.signupView.codeLabel.text = "+1"
            signupView.codeImage.isHidden = false
            signupView.codeImage.image = UIImage(named: "US.png")
            return
        }
        signupView.codeLabel.text = country.dialingCode
        signupView.codeImage.image = country.flag
        signupView.codeLabel.clipsToBounds = true
    }
    
    
}
extension SignUpVC: SignUpProtocol{
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
extension SignUpVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func setImagePicker() {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
//        signupView.signUpImage.image = image
        APIManager.uploadPhoto(image: signupView.signUpImage.image!) { (err, img) in
            self.view.hideLoader()
            print(img?.data ?? "")
            self.storeImg = img?.data ?? ""
            print("#$#")
            print(self.storeImg)
        }
//        storeImg = signUpViewModel.saveImage(image: signupView.signUpImage.image)
        
        picker.dismiss(animated: false, completion: nil)
    }
}
