//
//  MyProductsVC.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 4/3/21.
//

import UIKit
import SDWebImage
class MyProductsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var myProductsView: MyProductsView!
    var myproductViewModal: MyProductViewModelProtocol!
    var products = [getProductInfo]()
    override func viewDidLoad() {
        super.viewDidLoad()
        myProductsView.updateUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myproductViewModal = MyProductViewModel(view: self)
        myproductViewModal.getProducts(email: UserDefaultsManager.shared().Email) {
            self.products = self.myproductViewModal.returnProducts()
            self.myProductsView.myProductsTableView.reloadData()
            
        }
    }
    
    @IBAction func addProductPressed(_ sender: Any) {
        let productInfo = ProductInfoVC.create()
        self.present(productInfo, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myProductsView.myProductsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyProductsTableViewCell
        cell.productImage.sd_setImage(with: URL(string: products[indexPath.row].image ?? ""), completed: nil)
        cell.productName.text = products[indexPath.row].title
        cell.priceLabel.text = "KD \(products[indexPath.row].price ?? "")"
        cell.activityIndicate.isHidden = true
//        let d = Int(products[indexPath.row].orderDate!)!
//        let date = convertTimeStamp(date: d)
        if products[indexPath.row].isActive == true {
            cell.productActiveLabel.text = "Online"
            cell.productActiveImage.image = Asset.online.image
            cell.activeLabelEye.text = "Deactivate"
            cell.activeIconeEye.image = Asset.deactiviate.image
        }
        else {
            cell.productActiveLabel.text = "Offline"
            cell.productActiveImage.image = Asset.offline.image
            cell.activeLabelEye.text = "Activate"
            cell.activeIconeEye.image = Asset.activiate.image
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
extension MyProductsVC: SignUpProtocol {
    
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
