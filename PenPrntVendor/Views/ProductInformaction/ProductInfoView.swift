//
//  ProductInfoView.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 3/27/21.
//

import UIKit
import IGColorPicker
class ProductInfoView: UIView, UIPickerViewDelegate {

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
//    @IBOutlet weak var unitTF: UITextField!
    @IBOutlet weak var barCodeTF: UITextField!
//    @IBOutlet weak var stockTF: UITextField!
    @IBOutlet weak var uploadDesignView: UIView!
    @IBOutlet weak var saveDesign: UIButton!
    
    @IBOutlet weak var upload: UIImageView!
    @IBOutlet weak var uploadLabel: UILabel!
    
    @IBOutlet weak var uploadHeight: NSLayoutConstraint!
    
    @IBOutlet weak var mainColorView: UIView!
    @IBOutlet weak var colorPickrView: ColorPickerView!
    
    @IBOutlet weak var productSizeTF: UITextField!
    
    @IBOutlet weak var productColorTF: UITextField!
    
    @IBOutlet weak var productCategoryTF: UITextField!
    
    @IBOutlet weak var productSubCategoryTF: UITextField!
    
    @IBOutlet weak var savedView: UIView!
    
    @IBOutlet weak var stockSeg: UISegmentedControl!
    
    @IBOutlet var sizeView: UIView!
    @IBOutlet var sizeAddedTF: UITextField!
    @IBOutlet var sizeSaveDesign: UIButton!
    
    @IBOutlet var sizeAddDesign: UIButton!
    
    
    var stockValue = true
    var colorArray = [String]()
    var colorArray1 = [String]()
    var savedSizeArray = [String]()
    var sizePickerView = UIPickerView()
    var categoryPickerView = UIPickerView()
    var subCategoryPickerView = UIPickerView()
    var productColoPickerView = UIPickerView()
    var result = ""
    var result1 = ""
    func updateUI() {
        
        savedView.isHidden = true
        sizeView.isHidden = true
        sizeView.dropShadow(radius: 16, shadow: 2)
        sizeSaveDesign.setCornerRadius(radius: 8)
        sizeAddDesign.setCornerRadius(radius: 8)
        savedView.setCornerRadius(radius: 16)
        uploadHeight.constant = 0
        uploadDesignView.isHidden = true
        imageContainerView.dropShadow(radius: 12, shadow: 4)
        descriptionTV.setBCdesign(borderWidth: 1, borderColor: ColorName.borderColor.color, radius: 8)
        saveDesign.setBCdesign(borderWidth: 0, borderColor: .white, radius: 12)
        uploadDesignView.dropShadow(radius: 12, shadow: 2)
//        colorPickrView.setCornerRadius(radius: 20)
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        result1 = formatter.string(from: date)
        let date1 = formatter.date(from: result1)
        let dateStamp:TimeInterval = date1!.timeIntervalSince1970
        let dateSt:Int = Int(dateStamp)
        result = String(dateSt)
    }
    
    

}
