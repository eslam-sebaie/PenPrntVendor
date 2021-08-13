//
//  NotificationTableViewCell.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 8/13/21.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var productNumber: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
