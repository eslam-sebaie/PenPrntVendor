//
//  MapVCView.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 3/24/21.
//

import UIKit
import MapKit
import CoreLocation
class MapVCView: UIView {
    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var addressLabel: UILabel!
    
    let locationManager = CLLocationManager()
    
    func updateUI(){
        saveButton.layer.cornerRadius = 8
        saveButton.layer.masksToBounds = true
        
    }
    
}
