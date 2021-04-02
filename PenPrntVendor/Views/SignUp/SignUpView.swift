//
//  SignUpView.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 3/23/21.
//

import UIKit

class SignUpView: UIView {

    @IBOutlet weak var signupView: UIView!
    @IBOutlet weak var signUpImage: UIImageView!
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var emailPhoneTF: UITextField!
    @IBOutlet weak var landlineTF: UITextField!
    @IBOutlet weak var storeNameTF: UITextField!
    @IBOutlet weak var storeLocationTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var uploadStoreDesign: UIButton!
    
    @IBOutlet weak var signUpDesign: UIButton!
    @IBOutlet weak var upperSignUpView: UIView!
    
    func updateUI(){
        
        signUpImage.image = Asset.signInBG.image
        signUpLabel.text = L10n.signUpLabel
        
        signupView.dropShadow(scale: true, radius: 8, shadow: 4)
        upperSignUpView.setCornerRadius(radius: 8)
        upperSignUpView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        uploadStoreDesign.setBCdesign(borderWidth: 1, borderColor: ColorName.storeBorder.color, radius: 8)
        signUpDesign.setCornerRadius(radius: 8)
        
    }
}
