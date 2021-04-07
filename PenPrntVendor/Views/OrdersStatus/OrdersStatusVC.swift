//
//  OrdersStatusVC.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 3/27/21.
//

import UIKit
import SDWebImage
class OrdersStatusVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var orderStatusView: OrdersStatusView!
    var newOrder = false
    var inProgressOrder = false
    var completeOrder = false
    var orderDetail = OrderInfo(id: 0, orderNumber: "", orderDate: "", orderStatus: "", totalPrice: "", orderDetails: [])
    override func viewDidLoad() {
        super.viewDidLoad()
        orderStatusView.setMainView(order: orderDetail)
        let d = Int(orderDetail.orderDate!)
        let date = convertTimeStamp(date: d!)
        orderStatusView.orderStatusDate.text = date
        orderStatusView.orderStatusTableView.reloadData()
    }
    
    class func create() -> OrdersStatusVC {
        let ordersStatusVC: OrdersStatusVC = UIViewController.create(storyboardName: Storyboards.OrderConfirmation, identifier: ViewControllers.OrdersStatusVC)
        return ordersStatusVC
    }
    
    @IBAction func orderStatusPressed(_ sender: Any) {
        let product = ProductInfoVC.create()
        self.present(product, animated: true, completion: nil)
    }
    
    
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderDetail.orderDetails?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = orderStatusView.orderStatusTableView.dequeueReusableCell(withIdentifier: TableCells.orderCell, for: indexPath) as! OrdersStatusTableViewCell
        cell.orderName.text = orderDetail.orderDetails?[indexPath.row].orderName
        cell.orderImage.sd_setImage(with: URL(string: orderDetail.orderDetails?[indexPath.row].orderImage ?? ""), completed: nil)
        cell.orderPrice.text = "KD \(orderDetail.orderDetails?[indexPath.row].orderPrice ?? "")"
        cell.orderQuantity.text = "x \(orderDetail.orderDetails?[indexPath.row].orderQuantity ?? "")"
        cell.orderSize.text = orderDetail.orderDetails?[indexPath.row].orderSize
        cell.orderColor.textColor =  UIColor(hexString: orderDetail.orderDetails?[indexPath.row].orderColor ?? "")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
}
