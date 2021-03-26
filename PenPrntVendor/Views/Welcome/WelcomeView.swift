//
//  WelcomeView.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 3/22/21.
//

import UIKit

class WelcomeView: UIView {

    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var faceBookView: UIView!
    @IBOutlet weak var googleView: UIView!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var faceImage: UIImageView!
    @IBOutlet weak var googleImage: UIImageView!
    @IBOutlet weak var phoneImage: UIImageView!
    
    func updateUI() {
        logoImageView.image = Asset.logo.image
        faceImage.image = Asset.facebookIcon.image
        googleImage.image = Asset.googleIcon.image
        phoneImage.image = Asset.phone.image
        faceBookView.setBCdesign(borderWidth: 1, borderColor: ColorName.welcomeBorder.color, radius: 8)
        googleView.setBCdesign(borderWidth: 1, borderColor: ColorName.welcomeBorder.color, radius: 8)
        phoneView.setBCdesign(borderWidth: 1, borderColor: ColorName.welcomeBorder.color, radius: 8)
        
        
    }
    
}
