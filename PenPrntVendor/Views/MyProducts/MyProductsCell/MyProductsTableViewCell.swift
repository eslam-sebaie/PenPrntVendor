//
//  MyProductsTableViewCell.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 4/3/21.
//

import UIKit

class MyProductsTableViewCell: UITableViewCell {

    @IBOutlet var mainView: UIView!
    @IBOutlet var productImage: UIImageView!
    @IBOutlet var productName: UILabel!
    @IBOutlet var productDate: UILabel!
    @IBOutlet var productActiveImage: UIImageView!
    @IBOutlet var productActiveLabel: UILabel!
    @IBOutlet var editView: UIView!
    @IBOutlet var deactiveView: UIView!
    @IBOutlet var editDesign: UIButton!
    @IBOutlet var activeDesign: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.dropShadow(radius: 10, shadow: 3)
        productImage.setCornerRadius(radius: 8)
        editView.setCornerRadius(radius: 6)
        deactiveView.setCornerRadius(radius: 6)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    @IBAction func editPressed(_ sender: Any) {
        
    }
    
    @IBAction func activePressed(_ sender: Any) {
        
    }
    

}
