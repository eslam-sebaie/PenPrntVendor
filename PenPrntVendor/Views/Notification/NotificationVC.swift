//
//  NotificationVC.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 8/13/21.
//

import UIKit

class NotificationVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet var notificationView: NotificationView!
    var orders = [OrderInfo]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
    }
    override func viewWillAppear(_ animated: Bool) {
        getNewOrders()
    }
    
    func getNewOrders(){
        self.notificationView.showLoader()
        APIManager.getOrder(emailNumber: UserDefaultsManager.shared().Email ?? "") { (response) in
            switch response {
            case .failure(let err):
                print(err)
                self.show_Alert("Sorry!", "SomeThing Went Wrong.")
            case .success(let result):
                self.orders = []
                if result.message == "faild" {
                    self.show_Alert("Sorry!", "No Orders Found.")
                }
               
                else {
                    for i in result.data {
                        if i.order.orderStatus == "0" {
                            self.orders.append(i)
                        }
                    }
                    self.notificationView.notificationTableView.reloadData()
                }
                self.view.hideLoader()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.notificationView.notificationTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NotificationTableViewCell
        cell.productImage.sd_setImage(with: URL(string: orders[indexPath.row].image ?? ""), completed: nil)
        cell.productImage.setCornerRadius(radius: 4)
        cell.productNumber.text = "Order \(orders[indexPath.row].order.orderNumber)"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    
}
