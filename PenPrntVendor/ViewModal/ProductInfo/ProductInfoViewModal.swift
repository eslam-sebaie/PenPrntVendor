//
//  ProductInfoViewModal.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 4/9/21.
//

import UIKit
protocol ProductInfoViewModalProtocol {
    func saveImage(image: UIImage?) -> String
    
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
}
