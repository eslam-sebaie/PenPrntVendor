//
//  UIViewControllers.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 3/22/21.
//

import UIKit

extension UIViewController {
    class func create<T: UIViewController>(storyboardName: String, identifier: String) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
    public func show_Alert(_ title: String, _ msg: String) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in}
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }
    func instantiateMapVC() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let mapVC = sb.instantiateViewController(withIdentifier: "MapVC") as! MapVC
        mapVC.delegate = (self as! sendingAddress)
        self.present(mapVC ,animated: true, completion: nil)
    }
    
    func convertTimeStamp(date: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(date))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = L10n.date
        let strDate = dateFormatter.string(from: date)
        let array = strDate.components(separatedBy: CharacterSet(charactersIn: "/"))
        return array[0]
    }
    
    
}
