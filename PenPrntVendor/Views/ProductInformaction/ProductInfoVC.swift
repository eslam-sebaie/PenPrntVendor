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
class ProductInfoVC: UIViewController, UIDocumentPickerDelegate {
    
    
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
     
        self.productInfoViewModal.check(emailNumber: UserDefaultsManager.shared().Email!, image: self.productImg, title: self.productView.titleTF.text, description: self.productView.descriptionTV.text, itemNo: self.productView.itemNoTF.text, brandName: self.productView.brandTF.text, price: self.productView.priceTF.text, wholeSale: self.productView.salePriceTF.text, quantity: self.productView.quantity.text, unit: self.productView.unitTF.text, barCode: self.productView.barCodeTF.text, stock: self.productView.stockTF.text, design: self.fileLink, isActive: true)
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
