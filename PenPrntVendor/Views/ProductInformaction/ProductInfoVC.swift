//
//  ProductInfoVC.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 3/27/21.
//

import UIKit
import OpalImagePicker
import Photos
class ProductInfoVC: UIViewController {

    
    @IBOutlet var productView: ProductInfoView!
    let imagePicker = OpalImagePickerController()
    let productImagePicker = UIImagePickerController()
    var productInfoViewModal: ProductInfoViewModal!
    var productImg = ""
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
  
//    @IBAction func photoLibraryTapped(_ sender: Any) {
//        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
//            self.show_Alert("Sorry!", "SomeThing Went Wrong.")
//            return
//        }
//        //Present Image Picker
//        presentOpalImagePickerController(imagePicker, animated: true, select: { (_ img) in
//            //Save Images, update UI
//           let x = self.getAssetThumbnail(asset: img[0])
//            self.imga.image = x
//            //Dismiss Controller
//            self.imagePicker.dismiss(animated: true, completion: nil)
//        }, cancel: {
//
//        })
//    }
//
//    func getAssetThumbnail(asset: PHAsset) -> UIImage {
//        var retimage = UIImage()
////        println(retimage)
//        let manager = PHImageManager.default()
//        manager.requestImage(for: asset, targetSize: CGSize(width: 100.0, height: 100.0), contentMode: .aspectFit, options: nil, resultHandler: {(result, info)->Void in
//            retimage = result!
//        })
//        print(retimage)
//        return retimage
//    }

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
        productImg = productInfoViewModal.saveImage(image: productView.productImage.image)
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
