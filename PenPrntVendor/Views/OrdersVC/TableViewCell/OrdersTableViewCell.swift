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
    @IBOutlet weak var newOrderIcon: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.dropShadow(radius: 10, shadow: 3)
        
       
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateTableCell(cell: OrdersTableViewCell, indexPath: IndexPath, orders: [OrderInfo]) {
        
        
        cell.orderNumber.text = "#\(orders[indexPath.row].orderID)"
        cell.orderPrice.text = "KD \(orders[indexPath.row].order.totalPrice )"
        
        if orders[indexPath.row].order.orderStatus == "0" {
            cell.orderStatus.text = L10n.newOrder
            cell.orderStatus.textColor = ColorName.skyColor.color
            cell.newOrderIcon.isHidden = false
        }
        else if orders[indexPath.row].order.orderStatus == "1" {
            cell.orderStatus.text = L10n.inProgress
            cell.orderStatus.textColor = ColorName.progressColor.color
            cell.newOrderIcon.isHidden = true
        }
        
        else if orders[indexPath.row].order.orderStatus == "2" {
            cell.orderStatus.text = L10n.completed
            cell.orderStatus.textColor = ColorName.completeColor.color
            cell.newOrderIcon.isHidden = true
        }
    }
    
}
