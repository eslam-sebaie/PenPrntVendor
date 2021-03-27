//
//  OrdersStatusTableViewCell.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 3/27/21.
//

import UIKit

class OrdersStatusTableViewCell: UITableViewCell {

    
    @IBOutlet weak var orderMainView: UIView!
    @IBOutlet weak var orderImage: UIImageView!
    @IBOutlet weak var orderName: UILabel!
    @IBOutlet weak var orderPrice: UILabel!
    @IBOutlet weak var orderQuantity: UILabel!
    @IBOutlet weak var orderColor: UILabel!
    @IBOutlet weak var orderSize: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        orderMainView.dropShadow(radius: 10, shadow: 4)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
