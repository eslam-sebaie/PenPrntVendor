//
//  OrdersVC.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 3/27/21.
//

import UIKit

class OrdersVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var ordersView: OrdersView!
    var orderViewModal: OrderViewModelProtocol!
    var orders = [OrderInfo]()
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    override func viewWillAppear(_ animated: Bool) {
        orderViewModal = OrderViewModel(view: self)
//        orderViewModal.getOrders(email: UserDefaultsManager.shared().Email)m
        orderViewModal.getOrders(email: UserDefaultsManager.shared().Email) {
            self.orders = self.orderViewModal.returnOrder()
            self.ordersView.orderTableView.reloadData()
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ordersView.orderTableView.dequeueReusableCell(withIdentifier: TableCells.orderCell, for: indexPath) as! OrdersTableViewCell
        cell.updateTableCell(cell: cell, indexPath: indexPath, orders: orders)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let status = OrdersStatusVC.create()
        status.inProgressOrder = true
        self.present(status, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    

}
extension OrdersVC: SignUpProtocol {
    
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
