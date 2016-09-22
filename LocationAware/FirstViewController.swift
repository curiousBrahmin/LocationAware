//
//  FirstViewController.swift
//  LocationAware
//
//  Created by Rambo on 9/21/16.
//  Copyright © 2016 Rambo. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class FirstViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    var locationManager = CLLocationManager()
    
    
    @IBOutlet weak var latitudeLbl: UILabel!
    
    @IBOutlet weak var longitudeLbl: UILabel!
    
    @IBOutlet weak var courseLbl: UILabel!
    
    @IBOutlet weak var speedLbl: UILabel!
    
    @IBOutlet weak var altitudeLbl: UILabel!

    @IBOutlet weak var addressLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self

        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0]
        
        self.latitudeLbl.text = String(userLocation.coordinate.latitude)
        
        self.longitudeLbl.text = String(userLocation.coordinate.longitude)
        
        self.courseLbl.text = String(userLocation.course)
        
        self.speedLbl.text = String(userLocation.speed)
        
        self.altitudeLbl.text = String(userLocation.altitude)
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            
            if error != nil{
                print(error)
                
            }else{
                
                if let placemarks = placemarks?[0]{
                    
                    var address = ""
                    
                    if placemarks.subThoroughfare != nil{
                        
                        address += placemarks.subThoroughfare! + " "
                        
                    }
                    
                    if placemarks.thoroughfare != nil{
                        
                        address += placemarks.thoroughfare! + "\n"
                    }
                    
                    if placemarks.subLocality != nil{
                        
                        address += placemarks.subLocality! + "\n"
                    }
                    
                    if placemarks.subAdministrativeArea != nil{
                        
                        address += placemarks.subAdministrativeArea! + "\n"
                    }
                    
                    if placemarks.postalCode != nil{
                        
                        address += placemarks.postalCode! + "\n"
                    }
                    
                    if placemarks.country != nil{
                        
                        address += placemarks.country! + "\n"
                    }
                    
                    self.addressLbl.text = address
                    
                }
                
                
            }
            
        }
        

    }

}

