//
//  ProductInfoViewModal.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 4/9/21.
//

import UIKit
protocol ProductInfoViewModalProtocol {
    func saveImage(image: UIImage?) -> String
    func saveProduct(emailNumber:String,  image: String?,  title: String?,  description: String?,  itemNo: String?,  brandName: String?,  price: String?,  wholeSale: String?,  quantity: String?,  unit: String?,  barCode: String?,  stock: String?,  design: [String]?,  isActive: Bool?)
}
class ProductInfoViewModal{
    
    // MARK:- Properties
    weak var view: SignUpProtocol!
    var delegate: ProductInfoViewModalProtocol?
    var imag: String = ""
    // MARK:- Initialization Methods
    init(view: SignUpProtocol) {
        self.view = view
    }
    func check(emailNumber:String,  image: String?,  title: String?,  description: String?,  itemNo: String?,  brandName: String?,  price: String?,  wholeSale: String?,  quantity: String?,  unit: String?,  barCode: String?,  stock: String?,  design: [String]?,  isActive: Bool?) {
        
        guard let img = image, img != "" else {
            self.view.showAlert(title: "Sorry!", msg: "please Upload Product Image.")
            return
        }
        guard let title = title, title != "" else {
            self.view.showAlert(title: "Sorry!", msg: "please Enter Product Title.")
            return
        }
        guard let description = description, description != "" else {
            self.view.showAlert(title: "Sorry!", msg: "please Enter Product Description.")
            return
        }
        guard let itemNo = itemNo, itemNo != "" else {
            self.view.showAlert(title: "Sorry!", msg: "please Enter Product itemNo.")
            return
        }
        guard let price = price, price != "" else {
            self.view.showAlert(title: "Sorry!", msg: "please Enter Product price.")
            return
        }
        guard let quantity = quantity, quantity != "0", quantity != "" else {
            self.view.showAlert(title: "Sorry!", msg: "please Enter Product quantity.")
            return
        }
        guard let unit = unit, unit != "" else {
            self.view.showAlert(title: "Sorry!", msg: "please Enter Product unit.")
            return
        }
        guard let barCode = barCode, barCode != "" else {
            self.view.showAlert(title: "Sorry!", msg: "please Enter Product BarCode.")
            return
        }
        saveProduct(emailNumber: emailNumber, image: image!, title: title, description: description, itemNo: itemNo, brandName: brandName ?? "", price: price, wholeSale: wholeSale ?? "", quantity: quantity, unit: unit , barCode: barCode, stock: stock ?? "", design: design ?? [], isActive: isActive!)
        
        
    }
    
    
}
extension ProductInfoViewModal: ProductInfoViewModalProtocol {

    func saveImage(image: UIImage?) -> String {
        self.view.showLoader()
        APIManager.uploadPhoto(image: image!) { (err, img) in
            self.view.hideLoader()
            print(img?.data ?? "")
            self.imag = img?.data ?? ""
        }
        return imag
    }
    
    func saveProduct(emailNumber: String, image: String?, title: String?, description: String?, itemNo: String?, brandName: String?, price: String?, wholeSale: String?, quantity: String?, unit: String?, barCode: String?, stock: String?, design: [String]?, isActive: Bool?) {
        self.view.showLoader()
        APIManager.saveProduct(emailNumber: emailNumber, image: image!, title: title!, description: description!, itemNo: itemNo!, brandName: brandName ?? "", price: price!, wholeSale: wholeSale ?? "", quantity: quantity!, unit: unit ?? "", barCode: barCode!, stock: stock ?? "", design: design ?? [], isActive: isActive!) { (response) in
            switch response {
            case .failure(let err):
                print(err)
            case .success(let result):
                print(result)
                self.view.hideLoader()
            }
        }
    }
}
