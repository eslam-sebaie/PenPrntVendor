//
//  PhoneVerifyView.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 3/25/21.
//

import UIKit
import SGCodeTextField
class PhoneVerifyView: UIView {

    @IBOutlet weak var tf_otp: SGCodeTextField!
    @IBOutlet weak var verifyDesign: UIButton!
    
    func updateUI() {
        self.tf_otp.addDoneOnKeyboardWithTarget(self, action: #selector(PhoneVerifyVC.hide(sender:)))
        verifyDesign.setCornerRadius(radius: 8)
    }
}
