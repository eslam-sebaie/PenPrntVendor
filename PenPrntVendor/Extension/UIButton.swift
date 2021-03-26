//
//  UIButton.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 3/23/21.
//


import UIKit
extension UIButton {
    func setRadius(radius: CGFloat, borderWidth: CGFloat, borderColor: UIColor) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    
}
