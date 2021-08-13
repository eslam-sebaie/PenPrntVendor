//
//  OrderViewModal.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 4/6/21.
//

import Foundation
protocol OrderViewModelProtocol {
    func getOrders(email: String?, completion: @escaping()->())
    func returnOrder()-> [OrderInfo]
    
}
class OrderViewModel{
    
    // MARK:- Properties
    weak var view: SignUpProtocol!
    var orderInfo = [OrderInfo]()
    // MARK:- Initialization Methods
    init(view: SignUpProtocol) {
        self.view = view
    }
}
extension OrderViewModel: OrderViewModelProtocol {
    func returnOrder()-> [OrderInfo] {
        return orderInfo
    }
    
    func getOrders(email: String?, completion: @escaping()->())  {
        self.view.showLoader()
        APIManager.getOrder(emailNumber: email!) { (response) in
            switch response {
            case .failure(let err):
                print(err)
                self.view.hideLoader()
                self.view.showAlert(title: "Sorry!", msg: "SomeThing Went Wrong.")
            case .success(let result):
                if result.message == "faild" {
                    self.view.showAlert(title: "Sorry!", msg: "No Orders Found.")
                }
                else {
                    self.orderInfo = result.data
                }
                self.view.hideLoader()
            }
            completion()
        }
    }
    
    
}
