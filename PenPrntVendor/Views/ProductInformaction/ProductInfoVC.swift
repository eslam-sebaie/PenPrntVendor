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
class ProductInfoVC: UIViewController, UIDocumentPickerDelegate, ColorPickerViewDelegate, ColorPickerViewDelegateFlowLayout {
    
    
    @IBOutlet var productView: ProductInfoView!
    let imagePicker = OpalImagePickerController()
    let productImagePicker = UIImagePickerController()
    var productInfoViewModal: ProductInfoViewModal!
    var productImg = ""
    var fileLink = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        productImagePicker.delegate = self
        productView.updateUI()
        productView.colorPickrView.delegate = self
        productView.colorPickrView.layoutDelegate = self
        productView.colorPickrView.style = .circle
        productView.colorPickrView.selectionStyle = .check
        productView.colorPickrView.isSelectedColorTappable = false
        productView.mainColorView.isHidden = true
        let tabGesture = UITapGestureRecognizer()
        tabGesture.addTarget(self, action: #selector(ProductInfoVC.openGallery(tabGesture:)))
        productView.productImage.isUserInteractionEnabled = true
        productView.productImage.addGestureRecognizer(tabGesture)
        
        
    }
    @objc func openGallery(tabGesture: UITapGestureRecognizer) {
        self.setImagePicker()
    }
    
    
    class func create() -> ProductInfoVC {
        let productInfoVC: ProductInfoVC = UIViewController.create(storyboardName: Storyboards.ProductsInfo, identifier: ViewControllers.ProductInfoVC)
        productInfoVC.productInfoViewModal = ProductInfoViewModal(view: productInfoVC)
        return productInfoVC
    }
    
    @objc func popupHide() {
        productView.savedView.isHidden = true
    }
    
    
    @IBAction func colorPressed(_ sender: Any) {
        productView.mainColorView.isHidden = false
    }
    
    @IBAction func donePress(_ sender: Any) {
        for i in self.productView.colorArray {
            self.productView.productColorTF.text! += "\(i), "
        }
        self.productView.colorArray = []
        self.productView.mainColorView.isHidden = true
    }
    
    // MARK: - ColorPickerViewDelegateFlowLayout
    func colorPickerView(_ colorPickerView: ColorPickerView, didSelectItemAt indexPath: IndexPath) {
        productView.savedView.isHidden = false
        self.perform(#selector(self.popupHide), with: self, afterDelay: 1)
        let colorBlueHex = productView.colorPickrView.colors[indexPath.item].toHexString()
        self.productView.colorArray.append(colorBlueHex)
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
    
    @IBAction func stockSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            productView.stockValue = "Yes"
        case 1:
            productView.stockValue = "No"
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
       
        self.productInfoViewModal.check(emailNumber: UserDefaultsManager.shared().Email!, image: self.productImg, title: self.productView.titleTF.text, description: self.productView.descriptionTV.text, itemNo: self.productView.itemNoTF.text, brandName: self.productView.brandTF.text, price: self.productView.priceTF.text, wholeSale: self.productView.salePriceTF.text, quantity: self.productView.quantity.text, unit: self.productView.unitTF.text, barCode: self.productView.barCodeTF.text, stock: self.productView.stockValue, design: self.fileLink, isActive: true)
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
extension ProductInfoVC: SignUpProtocol {
    
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
        
            var fileName = UUID().uuidString
     
            guard let documentURL = urls.first else {
                return
            }
        print(documentURL)
            let myData = NSData(contentsOf: documentURL)
     
        APIManager.uploadDocument(file: myData as! Data, fileName: fileName) { (err, str) in
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
