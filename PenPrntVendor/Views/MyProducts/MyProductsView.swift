//
//  MyProductsView.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 4/3/21.
//

import UIKit

class MyProductsView: UIView {

    @IBOutlet var myProductsTableView: UITableView!
    @IBOutlet var addProductDesign: UIButton!
    
    func updateUI(){
        addProductDesign.setCornerRadius(radius: 8)
    }
}
