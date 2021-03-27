//
//  OrdersTableViewCell.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 3/27/21.
//

import UIKit

class OrdersTableViewCell: UITableViewCell {

    @IBOutlet var mainView: UIView!
    @IBOutlet var orderNumber: UILabel!
    @IBOutlet var orderStatus: UILabel!
    @IBOutlet var orderDate: UILabel!
    @IBOutlet var orderPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.dropShadow(radius: 10, shadow: 3)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
