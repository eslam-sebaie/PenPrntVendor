//
//  OrderStatusViewModel.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 4/9/21.
//

import Foundation
protocol OrderStatusViewModelProtocol {
    func updateStatus(id: Int, orderStatus: Int, completion: @escaping()-> Void)
    
}
class OrderStatusViewModel{
    
    // MARK:- Properties
    weak var view: SignUpProtocol!
    
    // MARK:- Initialization Methods
    init(view: SignUpProtocol) {
        self.view = view
    }
    
}
extension OrderStatusViewModel: OrderStatusViewModelProtocol{
    func updateStatus(id: Int, orderStatus: Int, completion: @escaping()-> Void) {
        self.view.showLoader()
        APIManager.OrderStatus(id: id, orderStatus: orderStatus) { [self] (response) in
            switch response {
            case .failure( _):
                self.view.showAlert(title: "Sorry!", msg: "Somthing Went Wrong.")
            case .success( _):
                print("Ok")
                self.view.hideLoader()
            }
            completion()
        }
    }
    
    
}
