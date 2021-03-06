//
//  OrdersStatusView.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 3/27/21.
//

import UIKit

class OrdersStatusView: UIView {

    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var orderStatusView: UIView!
    @IBOutlet weak var orderStatusLabel: UILabel!
    @IBOutlet weak var orderStatusDate: UILabel!
    @IBOutlet weak var orderStatusTableView: UITableView!
    @IBOutlet weak var orderDesign: UIButton!
    @IBOutlet weak var totalOrderLabel: UILabel!
    
    
    func setMainView(order: OrderInfo) {
        orderStatusView.dropShadow(radius: 10, shadow: 4)
        orderNumberLabel.text = "Order \(order.orderID)"
    
        if order.order.orderStatus == "0" {
            orderStatusLabel.textColor = ColorName.skyColor.color
            orderStatusLabel.text = L10n.newOrder
            orderDesign.setBCdesign(borderWidth: 0, borderColor: .white, radius: 8)
            orderDesign.setTitle(L10n.startOrder, for: .normal)
            orderDesign.backgroundColor = ColorName.startColor.color
            orderDesign.isHidden = false
        }
        else if order.order.orderStatus == "1" {
            orderStatusLabel.textColor = ColorName.progressColor.color
            orderStatusLabel.text = L10n.inProgress
            orderDesign.setBCdesign(borderWidth: 0, borderColor: .white, radius: 8)
            orderDesign.setTitle(L10n.completeOrder, for: .normal)
            orderDesign.backgroundColor = ColorName.skyColor.color
            orderDesign.isHidden = false
        }
        else if order.order.orderStatus == "2" {
            orderStatusLabel.textColor = ColorName.completeColor.color
            orderStatusLabel.text = L10n.completed
            orderDesign.isHidden = true
        }
        
        
    }
   

}
