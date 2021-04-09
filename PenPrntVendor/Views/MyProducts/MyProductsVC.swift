//
//  MyProductsVC.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 4/3/21.
//

import UIKit

class MyProductsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var myProductsView: MyProductsView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myProductsView.updateUI()
        
    }
    
    @IBAction func addProductPressed(_ sender: Any) {
        let productInfo = ProductInfoVC.create()
        self.present(productInfo, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myProductsView.myProductsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyProductsTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
