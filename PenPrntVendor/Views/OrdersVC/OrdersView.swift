//
//  OrdersView.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 3/27/21.
//

import UIKit

class OrdersView: UIView {

    @IBOutlet var orderTableView: UITableView!
    
    func updateTableCell(cell: OrdersTableViewCell, indexPath: IndexPath, orders: [OrderInfo]) {
        cell.orderNumber.text = orders[indexPath.row].orderNumber
        cell.orderPrice.text = "KD \(orders[indexPath.row].totalPrice ?? "")"
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
