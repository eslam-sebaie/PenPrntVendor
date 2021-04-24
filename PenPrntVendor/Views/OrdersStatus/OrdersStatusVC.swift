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
    var orderStatusViewModal: OrderStatusViewModel!
    var newOrder = false
    var inProgressOrder = false
    var completeOrder = false
    var ord = OrderDetail(id: 0, orderNumber: "", orderDate: "", orderStatus: "", totalPrice: "", userID: "")
    var orderDetail = OrderInfo(id: 0, productID: "", orderID: "", price: "", quantity: "", color: "", size: "", name: "", image: "", order: OrderDetail(id: 0, orderNumber: "", orderDate: "", orderStatus: "", totalPrice: "", userID: ""))
    var isProgress = false
    
    
    var receiveOrders = [OrderInfo]()
    var receiveID = 0
    var specificOrders = [OrderInfo]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderStatusView.setMainView(order: orderDetail)
//        let d = Int(orderDetail.orderDate!)
//        let date = convertTimeStamp(date: d!)
        orderStatusView.orderStatusDate.text = orderDetail.order.orderDate
        orderStatusView.orderStatusTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        for i in receiveOrders {
            if Int(i.orderID) == receiveID {
                specificOrders.append(i)
            }
        }
        
    }
    
    class func create() -> OrdersStatusVC {
        let ordersStatusVC: OrdersStatusVC = UIViewController.create(storyboardName: Storyboards.OrderConfirmation, identifier: ViewControllers.OrdersStatusVC)
        ordersStatusVC.orderStatusViewModal = OrderStatusViewModel(view: ordersStatusVC)
        return ordersStatusVC
    }
    
    @IBAction func orderStatusPressed(_ sender: Any) {
        
        if orderDetail.order.orderStatus == "0" && isProgress == false{
            orderStatusViewModal.updateStatus(id: Int(orderDetail.orderID)!, orderStatus: 1) {
                self.orderStatusView.orderStatusLabel.textColor = ColorName.progressColor.color
                self.orderStatusView.orderStatusLabel.text = L10n.inProgress
                self.orderStatusView.orderDesign.setTitle(L10n.completeOrder, for: .normal)
                self.orderStatusView.orderDesign.backgroundColor = ColorName.skyColor.color
                self.orderStatusView.orderDesign.isHidden = false
                self.isProgress = true
            }
        }
        else if orderDetail.order.orderStatus == "1" || isProgress == true{
            orderStatusViewModal.updateStatus(id: Int(orderDetail.orderID)!, orderStatus: 2) {
                self.orderStatusView.orderStatusLabel.textColor = ColorName.completeColor.color
                self.orderStatusView.orderStatusLabel.text = L10n.completed
                self.orderStatusView.orderDesign.isHidden = true
            }
        }
        else {
            orderStatusView.orderDesign.isHidden = true
        }
        
     }
    
    
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return specificOrders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = orderStatusView.orderStatusTableView.dequeueReusableCell(withIdentifier: TableCells.orderCell, for: indexPath) as! OrdersStatusTableViewCell
        cell.orderName.text = specificOrders[indexPath.row].name
        cell.orderImage.sd_setImage(with: URL(string: specificOrders[indexPath.row].image), completed: nil)
        cell.orderPrice.text = "KD \(specificOrders[indexPath.row].price)"
        cell.orderQuantity.text = "x \(specificOrders[indexPath.row].quantity)"
        cell.orderSize.text = specificOrders[indexPath.row].size
        cell.orderColor.backgroundColor =  UIColor(hexString: specificOrders[indexPath.row].color)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
}
extension OrdersStatusVC: SignUpProtocol {
    
    func presentSignIn() {
        let signInVC = SignInVC.create()
        self.present(signInVC ,animated: true, completion: nil)
    }
    
    func hideLoader() {
        self.view.hideLoader()
    }
    
    func showLoader() {
        self.view.showLoader()
    }
    
    func showAlert(title: String, msg: String) {
        self.show_Alert(title, msg)
    }
    func presentTabBar() {
        let tabVC = TabBarController.create()
        self.present(tabVC ,animated: true, completion: nil)
    }
}
