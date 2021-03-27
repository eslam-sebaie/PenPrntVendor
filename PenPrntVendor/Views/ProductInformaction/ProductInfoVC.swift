//
//  ProductInfoVC.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 3/27/21.
//

import UIKit

class ProductInfoVC: UIViewController {

    
    @IBOutlet var productView: ProductInfoView!
    override func viewDidLoad() {
        super.viewDidLoad()
        productView.updateUI()
    }
    
    class func create() -> ProductInfoVC {
        let productInfoVC: ProductInfoVC = UIViewController.create(storyboardName: Storyboards.ProductsInfo, identifier: ViewControllers.ProductInfoVC)
        return productInfoVC
    }
  

}
