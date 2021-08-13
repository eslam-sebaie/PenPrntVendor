//
//  MyProductsViewModal.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 4/10/21.
//

import Foundation
protocol MyProductViewModelProtocol {
    func getProducts(email: String?, completion: @escaping()->())
    func returnProducts()-> [getProductInfo]
    
}
class MyProductViewModel{
    
    // MARK:- Properties
    weak var view: SignUpProtocol!
    var productInfo = [getProductInfo]()
    // MARK:- Initialization Methods
    init(view: SignUpProtocol) {
        self.view = view
    }
}
extension MyProductViewModel: MyProductViewModelProtocol {
    func returnProducts()-> [getProductInfo] {
        return productInfo
    }
    
    func getProducts(email: String?, completion: @escaping()->())  {
        self.view.showLoader()
        APIManager.getProduct(emailNumber: email!) { (response) in
            switch response {
            case .failure(let err):
                print(err)
            case .success(let result):
                if result.message == "faild" {
                    self.view.showAlert(title: "Sorry!", msg: "No Orders Found.")
                }
                else {
                    print(result)
                    self.productInfo = result.data!
                }
                self.view.hideLoader()
            }
            completion()
        }
    }
    
    
}
