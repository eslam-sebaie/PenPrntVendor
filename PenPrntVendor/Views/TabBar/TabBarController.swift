//
//  TabBarController.swift
//  corner&shadowTabbar
//
//  Created by 📲Ghazzway📱 😎 on 24/02/1441 AH.
//  Copyright © 1441 📲Ghazzway📱 😎. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    let coustmeTabBarView:UIView = {
        
        //  daclare coustmeTabBarView as view
        let view = UIView(frame: .zero)
        
        // to make the cornerRadius of coustmeTabBarView
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        
        // to make the shadow of coustmeTabBarView
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: -4.0)
        view.layer.shadowOpacity = 0.05
        view.layer.shadowRadius = 4
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addcoustmeTabBarView()
        hideTabBarBorder()
    }
    
    class func create() -> TabBarController {
        let tabVC: TabBarController = UIViewController.create(storyboardName: Storyboards.OrderDetails, identifier: ViewControllers.TabBarController)
        return tabVC
    }
    
    override func viewDidLayoutSubviews() {
          super.viewDidLayoutSubviews()
         coustmeTabBarView.frame = tabBar.frame
      }
    
    override func viewDidAppear(_ animated: Bool) {
        var newSafeArea = UIEdgeInsets()

        // Adjust the safe area to the height of the bottom views.
        newSafeArea.bottom = 20

        // Adjust the safe area insets of the
        //  embedded child view controller.
        self.children.forEach({$0.additionalSafeAreaInsets = newSafeArea})
    }

    private func addcoustmeTabBarView() {
        //
       coustmeTabBarView.frame = tabBar.frame
        view.addSubview(coustmeTabBarView)
        view.bringSubviewToFront(self.tabBar)
    }
    
    
    func hideTabBarBorder()  {
        let tabBar = self.tabBar
        tabBar.backgroundImage = UIImage.from(color: .clear)
        tabBar.shadowImage = UIImage()
        tabBar.clipsToBounds = true

    }
    

}


extension UIImage {
    static func from(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}
