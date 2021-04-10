//
//  SignUpVC.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 3/23/21.
//

import UIKit
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
    var storeImg = ""
    var imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
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
        self.signUpViewModel.SignUp(email: signupView.emailPhoneTF.text, landlineNumber: signupView.landlineTF.text, storeName: signupView.storeNameTF.text, storeLocation: signupView.storeLocationTF.text, password: signupView.passwordTF.text, image: storeImg)
        
        
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
    func setImagePicker(){
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        signupView.signUpImage.image = image
        storeImg = signUpViewModel.saveImage(image: signupView.signUpImage.image)
        
        picker.dismiss(animated: false, completion: nil)
    }
}
