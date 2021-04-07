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
        let d = Int(orders[indexPath.row].orderDate!)!
        let date = Date(timeIntervalSince1970: TimeInterval(d))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = L10n.date
        let strDate = dateFormatter.string(from: date)
        let array = strDate.components(separatedBy: CharacterSet(charactersIn: "/"))
        
        cell.orderNumber.text = orders[indexPath.row].orderNumber
        cell.orderPrice.text = "KD \(orders[indexPath.row].totalPrice ?? "")"
        cell.orderDate.text = array[0]
        if orders[indexPath.row].orderStatus == "0" {
            cell.orderStatus.text = L10n.newOrder
            cell.orderStatus.textColor = ColorName.skyColor.color
            cell.newOrderIcon.isHidden = false
        }
        else if orders[indexPath.row].orderStatus == "1" {
            cell.orderStatus.text = L10n.inProgress
            cell.orderStatus.textColor = ColorName.progressColor.color
            cell.newOrderIcon.isHidden = true
        }
        
        else if orders[indexPath.row].orderStatus == "2" {
            cell.orderStatus.text = L10n.completed
            cell.orderStatus.textColor = ColorName.completeColor.color
            cell.newOrderIcon.isHidden = true
        }
    }
    
}
