//
//  OrdersVC.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 3/27/21.
//

import UIKit

class OrdersVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var ordersView: OrdersView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ordersView.orderTableView.dequeueReusableCell(withIdentifier: TableCells.orderCell, for: indexPath) as! OrdersTableViewCell
        cell.orderStatus.textColor = ColorName.skyColor.color
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
