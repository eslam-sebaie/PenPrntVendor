//
//  ProductInfoViewModal.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 4/9/21.
//

import UIKit
protocol ProductInfoViewModalProtocol {
    func saveImage(image: UIImage?, completion: @escaping() -> Void)
    func retImg()-> String
    func saveProduct(emailNumber:String,  image: String?,  title: String?,  description: String?,  itemNo: String?,  brandName: String?,  price: String?,  wholeSale: String?,  quantity: String?, barCode: String?,  design: String?,  isActive: Bool?, productColor: [String]?, productSize: [String]?, productDate: String, categoryId: Int?, subcategoryId: Int?)
    
    func editProduct(id:Int,  image: String?,  title: String?,  description: String?,  itemNo: String?,  brandName: String?,  price: String?,  wholeSale: String?,  quantity: String?, barCode: String?,  design: String?,  isActive: Bool?, productColor: [String]?, productSize: [String]?, productDate: String, categoryId: Int?, subcategoryId: Int?)
}
class ProductInfoViewModal{
    
    // MARK:- Properties
    weak var view: ProductProtocol!
    var delegate: ProductInfoViewModalProtocol?
    var imag: String = ""
    var imgArray = [String]()
    let group = DispatchGroup()
    var i = 0
    var checkEdit = false
    // MARK:- Initialization Methods
    init(view: ProductProtocol) {
        self.view = view
    }
    func check(emailNumber:String,  image: String?,  title: String?,  description: String?,  itemNo: String?,  brandName: String?,  price: String?,  wholeSale: String?,  quantity: String?, barCode: String?,  design: String?,  isActive: Bool?, productColor: [String]?, productSize: [String]?, productDate: String, categoryId: Int?, subcategoryId: Int?) {
        
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
       
        guard let barCode = barCode, barCode != "" else {
            self.view.showAlert(title: "Sorry!", msg: "please Enter Product BarCode.")
            return
        }
        
        guard let color = productColor, color != [] else {
            self.view.showAlert(title: "Sorry!", msg: "please Enter Product Color.")
            return
        }
        guard let size = productSize, size != [] else {
            self.view.showAlert(title: "Sorry!", msg: "please Enter Product Size.")
            return
        }
        guard let cat = categoryId, cat != 0 else {
            self.view.showAlert(title: "Sorry!", msg: "please Enter Product Category.")
            return
        }
        guard let subcat = subcategoryId, subcat != 0 else {
            self.view.showAlert(title: "Sorry!", msg: "please Enter Product SubCategory.")
            return
        }
       
            saveProduct(emailNumber: emailNumber, image: image!, title: title, description: description, itemNo: itemNo, brandName: brandName ?? "", price: price, wholeSale: wholeSale ?? "", quantity: quantity , barCode: barCode, design: design ?? "", isActive: isActive!,productColor: color,productSize: size, productDate: productDate, categoryId: categoryId, subcategoryId: subcat)
        }
        
    func check1(id:Int,  image: String?,  title: String?,  description: String?,  itemNo: String?,  brandName: String?,  price: String?,  wholeSale: String?,  quantity: String?, barCode: String?,  design: String?,  isActive: Bool?, productColor: [String]?, productSize: [String]?, productDate: String, categoryId: Int?, subcategoryId: Int?) {
        
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
       
        guard let barCode = barCode, barCode != "" else {
            self.view.showAlert(title: "Sorry!", msg: "please Enter Product BarCode.")
            return
        }
        
        guard let color = productColor, color != [] else {
            self.view.showAlert(title: "Sorry!", msg: "please Enter Product Color.")
            return
        }
        guard let size = productSize, size != [] else {
            self.view.showAlert(title: "Sorry!", msg: "please Enter Product Size.")
            return
        }
        guard let cat = categoryId, cat != 0 else {
            self.view.showAlert(title: "Sorry!", msg: "please Enter Product Category.")
            return
        }
        guard let subcat = subcategoryId, subcat != 0 else {
            self.view.showAlert(title: "Sorry!", msg: "please Enter Product SubCategory.")
            return
        }
        editProduct(id: id, image: image!, title: title, description: description, itemNo: itemNo, brandName: brandName ?? "", price: price, wholeSale: wholeSale ?? "", quantity: quantity , barCode: barCode, design: design ?? "", isActive: isActive!,productColor: color,productSize: size, productDate: productDate, categoryId: categoryId, subcategoryId: subcat)
        
      
        
        
    }
    
   
    
    
}
extension ProductInfoViewModal: ProductInfoViewModalProtocol {
    func retImg() -> String {
        return imag
    }
    
    
    func saveImage(image: UIImage?, completion: @escaping() -> Void) {
        self.view.showLoader()
        APIManager.uploadPhoto(image: image!) { (err, img) in
            self.view.hideLoader()
            print(img?.data ?? "")
            self.imag = img?.data ?? ""
            completion()
        }
        
        
    }
    
    
    func saveProduct(emailNumber: String, image: String?, title: String?, description: String?, itemNo: String?, brandName: String?, price: String?, wholeSale: String?, quantity: String?,  barCode: String?,  design: String?, isActive: Bool?, productColor: [String]?, productSize: [String]?, productDate: String, categoryId: Int?, subcategoryId: Int?) {
        self.view.showLoader()
        print("!@#")
        print(title)
        APIManager.saveProduct(emailNumber: emailNumber, image: image!, title: title!, description: description!, itemNo: itemNo!, brandName: brandName ?? "", price: price!, wholeSale: wholeSale ?? "", quantity: quantity!, barCode: barCode!,  design: design ?? "", isActive: isActive!,productColor: productColor!, productSize: productSize!, productDate: productDate,categoryId: categoryId!, subcategoryId: subcategoryId!) { (response) in
            switch response {
            case .failure(let err):
                print(err)
                self.view.showAlert(title: "Sorry!", msg: "SomeThing Went Wrong.")
            case .success(let result):
                print(result)
                self.view.hideLoader()
                self.view.presentTabBar()
            }
        }
    }
    func editProduct(id: Int, image: String?, title: String?, description: String?, itemNo: String?, brandName: String?, price: String?, wholeSale: String?, quantity: String?,  barCode: String?,  design: String?, isActive: Bool?, productColor: [String]?, productSize: [String]?, productDate: String, categoryId: Int?, subcategoryId: Int?) {
        self.view.showLoader()
        APIManager.editProduct(id: id, image: image!, title: title!, description: description!, itemNo: itemNo!, brandName: brandName ?? "", price: price!, wholeSale: wholeSale ?? "", quantity: quantity!, barCode: barCode!,  design: design ?? "", isActive: isActive!,productColor: productColor!, productSize: productSize!, productDate: productDate,categoryId: categoryId!, subcategoryId: subcategoryId!) { (response) in
            switch response {
            case .failure(let err):
                print(err)
                self.view.showAlert(title: "Sorry!", msg: "SomeThing Went Wrong.")
            case .success(let result):
                print(result)
                self.view.hideLoader()
                self.view.presentTabBar()
            }
        }
    }
}
