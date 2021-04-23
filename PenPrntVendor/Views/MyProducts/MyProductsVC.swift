//
//  MyProductsVC.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 4/3/21.
//

import UIKit
import SDWebImage
class MyProductsVC: UIViewController, UITableViewDataSource, UITableViewDelegate, productsDelegate {
    
    @IBOutlet var myProductsView: MyProductsView!
    var myproductViewModal: MyProductViewModelProtocol!
    var products = [getProductInfo]()
    var index = 0
    var path: IndexPath!
    override func viewDidLoad() {
        super.viewDidLoad()
        myProductsView.updateUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getProduts()
    }
    
    func getProduts(){
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
    func btnCloseTapped(cell: MyProductsTableViewCell) {
        let indexPath = self.myProductsView.myProductsTableView.indexPath(for: cell)
        index = indexPath?.row as! Int
        path = indexPath
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myProductsView.myProductsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyProductsTableViewCell
        cell.productImage.sd_setImage(with: URL(string: products[indexPath.row].image ?? ""), completed: nil)
        cell.productName.text = products[indexPath.row].name
        cell.priceLabel.text = "KD \(products[indexPath.row].price ?? "")"
        cell.activityIndicate.isHidden = true
        let d = Int(products[indexPath.row].date ?? "") ?? 0
        let date = convertTimeStamp(date: d)
        cell.productDate.text = date
        cell.delegate = self
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
        cell.activeDesign.addTarget(self, action: #selector(activePressed(sender:)), for: .touchUpInside)
        cell.editDesign.addTarget(self, action: #selector(editPressed(sender:)), for: .touchUpInside)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    @objc func activePressed(sender: UIButton) {
//        let cell = self.myProductsView.myProductsTableView.cellForRow(at: self.path as IndexPath) as! MyProductsTableViewCell
        if products[index].isActive == true {
            APIManager.changeActivate(id: products[index].id ?? 0, isActive: false) { (response) in
                switch response {
                case .failure(let err):
                    print(err)
                case .success( _):
                    self.getProduts()
                }
            }
        }
        else {
            APIManager.changeActivate(id: products[index].id ?? 0, isActive: true) { (response) in
                switch response {
                case .failure(let err):
                    print(err)
                case .success( _):
                    self.getProduts()
                }
            }
        }
        
    }
    @objc func editPressed(sender: UIButton) {
        let product = ProductInfoVC.create()
        product.checkEditProduct = true
        product.receiveProductID = products[index].id ?? 0
        self.present(product, animated: true, completion: nil)
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
