//
//  MapController.swift
//  UwUber
//
//  Created by Hrishikesh Vikram on 4/4/22.
//

import Foundation
import UIKit
import Firebase
import MapKit
import CoreLocation
import CoreLocationUI
import FloatingPanel



class MapController : UIViewController{
    
    
    
    
    
   
    
    
    
    
  
    
    
    
   
    
    
  
    
    
    
    
    
    

    private let locationManager = CLLocationManager()
    private let map: MKMapView = {
        let map = MKMapView()
        
        return map
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Map"
        checkLocationAuthorization()
        checkUserLoggedIn()
        

    }
    
    
    func checkUserLoggedIn (){
        
        if Auth.auth().currentUser?.uid == nil {
            print("Not logged in")
             //print not logged in
            DispatchQueue.main.async {
                let nav = self.storyboard?.instantiateViewController(withIdentifier: "LoginScreenController") as! LoginScreenController
                self.present(nav, animated: true, completion: nil)
                
            }
            print(" User is not logged in learn to spell")
        }
        else{
            print (" User ID is \(Auth.auth().currentUser?.uid)")
            setHomeScreenView()
            print("test")
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        map.frame=view.bounds
        
    }

    func signUserOut(){
        
        do {
            try Auth.auth().signOut()
            print("User signed out")
        } catch {
            print("Debug: Error signing out")
            
        }
    }
    

    
    func setHomeScreenView(){
        super.viewDidLoad()
        view.addSubview(map)
        let panel = FloatingPanelController()
        panel.set(contentViewController: SearchViewController())
        panel.addPanel(toParent: self)

        
        
        map.showsUserLocation = true
        map.userTrackingMode = .follow
        
        
        
    }
    
    func checkLocationAuthorization() {	
        
            switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse:
                locationManager.requestAlwaysAuthorization()
                break
            case .denied:
                locationManager.requestAlwaysAuthorization()
                break
            case .notDetermined:
                locationManager.requestAlwaysAuthorization()
            case .restricted:
                locationManager.requestAlwaysAuthorization()
                break
            case .authorizedAlways:
                locationManager.startUpdatingLocation()
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
            }
        }
    
    
    
}
