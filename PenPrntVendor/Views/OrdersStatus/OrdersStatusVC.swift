//
//  OrdersStatusVC.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 3/27/21.
//

import UIKit

class OrdersStatusVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var orderStatusView: OrdersStatusView!
    var newOrder = false
    var inProgressOrder = false
    var completeOrder = false
    override func viewDidLoad() {
        super.viewDidLoad()
        orderStatusView.updateUI(newOrder: newOrder, progress: inProgressOrder, complete: completeOrder)
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = orderStatusView.orderStatusTableView.dequeueReusableCell(withIdentifier: TableCells.orderCell, for: indexPath) as! OrdersStatusTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
}
