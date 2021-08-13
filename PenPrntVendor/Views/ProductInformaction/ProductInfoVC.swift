//
//  ProductInfoVC.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 3/27/21.
//

import UIKit
import OpalImagePicker
import Photos
import MobileCoreServices
import IGColorPicker
import SDWebImage
protocol ProductProtocol: class {
    func hideLoader()
    func showLoader()
    func showAlert(title: String , msg: String)
    func presentTabBar()
    func presentSignIn()
}
class ProductInfoVC: UIViewController, UIDocumentPickerDelegate, ColorPickerViewDelegate, ColorPickerViewDelegateFlowLayout, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    
    @IBOutlet var productView: ProductInfoView!
    let imagePicker = OpalImagePickerController()
    let productImagePicker = UIImagePickerController()
    var productInfoViewModal: ProductInfoViewModal!
    var productImg = ""
    var fileLink = ""
    var sizeArray = ["S", "M", "L"]
    var size = ""
    var sizeCheck = false
    var catID = [Int]()
    var catName = [String]()
    
    var subCatID = [Int]()
    var subCatName = [String]()
    
    var savedCatID = 0
    var savedSubCatID = 0
    var checkEditProduct = false
    var receiveProductID = 0
    var newSizeArray = [String]()
    
    var colorName = ["White", "Silver","Gray", "Black", "Red","Maroon","Yellow", "Olive", "Lime","Green","Aqua","Blue", "Navy", "Fuchsia", "Purple", "Brown", "LightBlue","Pink", "Gold"]
    var colorCode = ["#FFFFFF", "#C0C0C0","#808080","#000000","#FF0000","#800000", "#FFFF00","#808000", "#00FF00","#008000", "#00FFFF","#0000FF", "#000080", "#FF00FF", "#800080", "#A52A2A","#ADD8E6","#FFC0CB", "#FFD700"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("!@#$%%%")
        print(receiveProductID)
        
        productImagePicker.delegate = self
        
        productView.sizePickerView.delegate = self
        productView.productSizeTF.inputView = productView.sizePickerView
        productView.categoryPickerView.delegate = self
        productView.subCategoryPickerView.delegate = self
        productView.productCategoryTF.inputView = productView.categoryPickerView
        productView.productSubCategoryTF.inputView = productView.subCategoryPickerView
        
        productView.productColoPickerView.delegate = self
        productView.productColoPickerView.dataSource = self
        productView.productColorTF.inputView = productView.productColoPickerView
        
        productView.sizePickerView.dataSource = self
        productView.categoryPickerView.dataSource = self
        productView.subCategoryPickerView.dataSource = self
        productView.updateUI()
//        productView.colorPickrView.delegate = self
//        productView.colorPickrView.layoutDelegate = self
//        productView.colorPickrView.style = .circle
//        productView.colorPickrView.selectionStyle = .check
//        productView.colorPickrView.isSelectedColorTappable = false
        productView.mainColorView.isHidden = true
        let tabGesture = UITapGestureRecognizer()
        tabGesture.addTarget(self, action: #selector(ProductInfoVC.openGallery(tabGesture:)))
        productView.productImage.isUserInteractionEnabled = true
        productView.productImage.addGestureRecognizer(tabGesture)
        
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == productView.productSubCategoryTF {
            if productView.productCategoryTF.text == "" {
                self.showAlert(title: "Sorry.", msg: "Choose Category First.")
            }
        }
    }
    var getCatID = ""
    var getSubCatID = ""
    override func viewWillAppear(_ animated: Bool) {
        productView.productSubCategoryTF.delegate = self
        if checkEditProduct == true {
            APIManager.getProduct(emailNumber: UserDefaultsManager.shared().Email!) { (response) in
                switch response {
                case .failure(let err):
                    print(err)
                case .success(let result):
                    for i in result.data! {
                        if self.receiveProductID == i.id {
                            self.getCatID = i.categoryId ?? ""
                            self.getSubCatID = i.subcategoryId ?? ""
                            self.productView.titleTF.text = i.name
                            self.productView.descriptionTV.text = i.description
                            self.productView.itemNoTF.text = i.itemNo
                            self.productView.brandTF.text = i.brandName
                            self.productView.priceTF.text = i.price
                            self.productView.salePriceTF.text = i.wholeSale
                            self.productView.quantity.text = i.quantity
                            self.productView.barCodeTF.text = i.barCode
                            self.productImg = i.image ?? ""
                            self.productView.productImage.sd_setImage(with: URL(string: i.image ?? ""), completed: nil)
                            self.productView.upload.isHidden = true
                            self.productView.uploadLabel.isHidden = true
                            self.productView.imageContainerView.dropShadow(radius: 12, shadow: 0)
                            self.productView.productImage.layer.cornerRadius = 12
                            self.productView.productImage.clipsToBounds = true
                            for j in i.productColor ?? [] {
                                self.productView.productColorTF.text! += "\(j) "
                                self.productView.colorArray = i.productColor ?? []
                                self.productView.colorArray1 = i.productColor ?? []
                            }
                            for j in i.size ?? [] {
                                self.productView.productSizeTF.text! += "\(j) "
                                self.productView.savedSizeArray = i.size ?? []
                            }
                            if i.isActive == true {
                                self.productView.stockValue = true
                                self.productView.stockSeg.selectedSegmentIndex = 0
                            }
                            else {
                                self.productView.stockValue = false
                                self.productView.stockSeg.selectedSegmentIndex = 1
                            }
                        }
                    }
                }
            }
        }
        
        APIManager.getCategories(vendorId: UserDefaultsManager.shared().VendorID ?? 0) { (response) in
            switch response {
            case .failure(let err):
                print(err)
            case .success(let result):
                print("$%")
                print(result)
                for i in result.data ?? [] {
                    self.catID.append(i.id ?? 0)
                    self.catName.append(i.name ?? "")
                    if self.checkEditProduct {
                        if Int(self.getCatID) == i.id {
                            self.productView.productCategoryTF.text = i.name
                            self.getSubCategoryID(categoryId: Int(self.getCatID) ?? 0)
                        }
                        
                    }
                }
            }
        }
    }
    var catInfo = [CategoryInfo]()
    var x = [CategoryInfo]()
    func getSubCategoryID(categoryId:Int) -> [CategoryInfo] {
        self.productView.showLoader()
        APIManager.getSubCategories(categoryId: categoryId) { (response) in
            switch response {
            case .failure(let err):
                print(err)
            case .success(let result):
                print("$%")
                print(result)
                self.catInfo = result.data ?? []
                for i in result.data ?? [] {
                    self.subCatID.append(i.id ?? 0)
                    self.subCatName.append(i.name ?? "")
                    if self.checkEditProduct {
                        if Int(self.getSubCatID) == i.id {
                            print("INFFFFF")
                            self.productView.productSubCategoryTF.text = i.name
                        }
                    }
                }
                self.productView.hideLoader()
            }
        }
        return catInfo
    }
    
    
    @objc func openGallery(tabGesture: UITapGestureRecognizer) {
        self.setImagePicker()
    }
    
    
    class func create() -> ProductInfoVC {
        let productInfoVC: ProductInfoVC = UIViewController.create(storyboardName: Storyboards.ProductsInfo, identifier: ViewControllers.ProductInfoVC)
        productInfoVC.productInfoViewModal = ProductInfoViewModal(view: productInfoVC)
        return productInfoVC
    }
    
    @IBAction func addSizePressed(_ sender: Any) {
        productView.sizeView.isHidden = false
        
    }
    
    @IBAction func saveSizePressed(_ sender: Any) {
        guard let size = productView.sizeAddedTF.text, size != "" else {
            showAlert(title: "Please!", msg: "Enter Product Size.")
            return
            
        }
        
        if self.productView.savedSizeArray.contains(size) {
            self.showAlert(title: "Sorry!", msg: "This Color Is Exist.")
        }
        else {
            self.productView.savedSizeArray.append(size)
            self.newSizeArray.append(size)
        }
        for  i in newSizeArray {
            self.productView.productSizeTF.text! += "\(i), "
        }
        newSizeArray = []
        self.productView.sizeAddedTF.text = ""
        
        
        
    }
    
    @IBAction func cancelSizePressed(_ sender: Any) {
        self.productView.sizeView.isHidden = true
    }
    
    @objc func popupHide() {
        self.productView.savedView.isHidden = true
    }
    
    
    
    @IBAction func colorPressed(_ sender: Any) {
        productView.mainColorView.isHidden = false
    }
    
    
    @IBAction func donePress(_ sender: Any) {
        for i in self.productView.colorArray {
            self.productView.productColorTF.text! += "\(i) "
        }
        self.productView.colorArray = []
        self.productView.mainColorView.isHidden = true
    }
    
    // MARK: - ColorPickerViewDelegateFlowLayout
    var colorCheck = false
    func colorPickerView(_ colorPickerView: ColorPickerView, didSelectItemAt indexPath: IndexPath) {
        let colorBlueHex = productView.colorPickrView.colors[indexPath.item].toHexString()
        for i in self.productView.colorArray1 {
            if i.contains(colorBlueHex) {
                self.showAlert(title: "Sorry!", msg: "This Color Is Exist.")
                colorCheck = true
            }
        }
        if !colorCheck {
            productView.savedView.isHidden = false
            self.perform(#selector(self.popupHide), with: self, afterDelay: 1)
            self.productView.colorArray.append(colorBlueHex)
            self.productView.colorArray1.append(colorBlueHex)
        }
        else {
            colorCheck = false
        }
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 48, height: 48)
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 11
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        sizeCheck = false
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == self.productView.productColoPickerView {
            return colorName.count
        }
        else if pickerView == self.productView.categoryPickerView {
            return catID.count
        }
        else {
            return catInfo.count
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == self.productView.productColoPickerView {
            return colorName[row]
        }
        else if pickerView == self.productView.categoryPickerView {
            
            return catName[row]
        }
        else {
            return catInfo[row].name
        }
    }
    var color = ""
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == self.productView.productColoPickerView {
            color = colorCode[row]
            self.view.endEditing(true)
            for i in 0..<self.productView.colorArray1.count {
                if self.productView.colorArray1[i].contains(color) {
                    self.showAlert(title: "Sorry!", msg: "This Color Is Exist.")
                    sizeCheck = true
                    self.view.endEditing(true)
                }
            }
            if !sizeCheck {
                self.productView.colorArray1.append(colorCode[row])
                self.productView.productColorTF.text! += "\(colorCode[row]) "
            }
        }
        else if pickerView == self.productView.categoryPickerView {
            self.productView.productCategoryTF.text = catName[row]
            savedCatID = catID[row]
            self.productView.productSubCategoryTF.text = ""
            self.getSubCategoryID(categoryId: savedCatID)
        }
        else  {
            self.productView.productSubCategoryTF.text = catInfo[row].name
            savedSubCatID = catInfo[row].id ?? 0
        }
    }
    
    
    @IBAction func stockSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            productView.stockValue = true
        case 1:
            productView.stockValue = false
        default:
            print("OL")
        }
    }
    
    
    @IBAction func virtualProductPressed(_ sender: UIButton) {
        
        if sender.isSelected {
            sender.isSelected = false
            productView.uploadHeight.constant = 0
            productView.uploadDesignView.isHidden = true
        }
        else {
            sender.isSelected = true
            productView.uploadHeight.constant = 45
            productView.uploadDesignView.isHidden = false
        }
    }
    
    @IBAction func uploadPressed(_ sender: Any) {
        
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypePDF as String, kUTTypePNG as String, kUTTypeJPEG as String, kUTTypePDF as String, kUTTypeScript as String, kUTTypeURL as String, kUTTypeGIF as String, kUTTypeRTF as String, kUTTypeData as String, kUTTypeItem as String, kUTTypeText as String, kUTTypeFolder as String, kUTTypeFileURL as String, kUTTypePresentation as String, kUTTypeDatabase as String, kUTTypeZipArchive as String, kUTTypeVideo as String ], in: .import)
        
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker,animated: true,completion: nil)
    }
    
    
    @IBAction func savePressed(_ sender: Any) {
        print("!#%@")
        print(self.productView.savedSizeArray)
        if checkEditProduct {
            self.productInfoViewModal.checkEdit = true
            self.productInfoViewModal.check1(id: receiveProductID, image: self.productImg, title: self.productView.titleTF.text, description: self.productView.descriptionTV.text, itemNo: self.productView.itemNoTF.text, brandName: self.productView.brandTF.text, price: self.productView.priceTF.text, wholeSale: self.productView.salePriceTF.text, quantity: self.productView.quantity.text, barCode: self.productView.barCodeTF.text, design: self.fileLink, isActive: self.productView.stockValue, productColor: self.productView.colorArray1, productSize: self.productView.savedSizeArray, productDate: self.productView.result, categoryId: Int(getCatID) ?? 0, subcategoryId: Int(getSubCatID) ?? 0)
        }
        else {
            self.productInfoViewModal.check(emailNumber: UserDefaultsManager.shared().Email!, image: self.productImg, title: self.productView.titleTF.text, description: self.productView.descriptionTV.text, itemNo: self.productView.itemNoTF.text, brandName: self.productView.brandTF.text, price: self.productView.priceTF.text, wholeSale: self.productView.salePriceTF.text, quantity: self.productView.quantity.text, barCode: self.productView.barCodeTF.text, design: self.fileLink, isActive: self.productView.stockValue, productColor: self.productView.colorArray1, productSize: self.productView.savedSizeArray, productDate: self.productView.result, categoryId: savedCatID, subcategoryId: savedSubCatID)
        }
        
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
extension ProductInfoVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func setImagePicker(){
        productImagePicker.sourceType = .photoLibrary
        productImagePicker.allowsEditing = true
        self.present(productImagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        productView.upload.isHidden = true
        productView.uploadLabel.isHidden = true
        productView.imageContainerView.dropShadow(radius: 12, shadow: 0)
        productView.productImage.image = image
        productView.productImage.layer.cornerRadius = 12 // To get Rounded Corner
        productView.productImage.clipsToBounds = true
        productInfoViewModal.saveImage(image: productView.productImage.image) {
            self.productImg = self.productInfoViewModal.retImg()
        }
        
        picker.dismiss(animated: false, completion: nil)
    }
}
extension ProductInfoVC: ProductProtocol {
    
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
        self.dismiss(animated: true, completion: nil)
    }
}
extension PHAsset {
    
    var image : UIImage {
        var thumbnail = UIImage()
        let imageManager = PHCachingImageManager()
        imageManager.requestImage(for: self, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: nil, resultHandler: { image, _ in
            thumbnail = image!
        })
        return thumbnail
    }
}
extension ProductInfoVC {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        let fileName = UUID().uuidString
        
        guard let documentURL = urls.first else {
            return
        }
        print(documentURL)
        let myData = NSData(contentsOf: documentURL)
        
        APIManager.uploadDocument(file: myData! as Data, fileName: fileName) { (err, str) in
            if let err = err {
                print("#$%%")
                print(err)
            }
            else {
                print("#%")
                self.fileLink = str?.data ?? ""
                print(str?.data ?? "")
            }
        }
    }
    
    
}
