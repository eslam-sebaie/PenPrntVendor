//
//  ProductInfoView.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 3/27/21.
//

import UIKit

class ProductInfoView: UIView {

    @IBOutlet weak var productHeaderLabel: UILabel!
    
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descriptionTV: UITextView!
    @IBOutlet weak var itemNoTF: UITextField!
    @IBOutlet weak var brandTF: UITextField!
    @IBOutlet weak var priceTF: UITextField!
    @IBOutlet weak var salePriceTF: UITextField!
    @IBOutlet weak var quantity: UITextField!
    @IBOutlet weak var unitTF: UITextField!
    @IBOutlet weak var barCodeTF: UITextField!
    @IBOutlet weak var stockTF: UITextField!
    @IBOutlet weak var uploadDesignView: UIView!
    @IBOutlet weak var saveDesign: UIButton!
    
    
    func updateUI() {
        imageContainerView.dropShadow(radius: 12, shadow: 4)
        descriptionTV.setBCdesign(borderWidth: 1, borderColor: ColorName.borderColor.color, radius: 8)
        saveDesign.setBCdesign(borderWidth: 0, borderColor: .white, radius: 12)
        uploadDesignView.dropShadow(radius: 12, shadow: 2)
    }
    
    

}
