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



class MapController : UIViewController, SearchViewControllerDelegate {
    
    
    var user:User? {
        didSet{ }
    }

    private let locationManager = LocationHandler.shared.locationManager
    private let map: MKMapView = {
        let map = MKMapView()
        
        return map
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Map"
        
        checkLocationAuthorization()
        checkUserLoggedIn()
        fetchUserData()
        fetchDrivers()
        
        
        
    }
   
    
    func fetchDrivers(){
        guard let location = locationManager?.location else { return}
        Service.shared.fetchDrivers(location: location) { driver in
            print("Debug driver is \(driver.location)")
            guard let coordinate = driver.location?.coordinate else { return
                
            }
            let anno = DriverA(uid: driver.uid, coordinate: coordinate)
            
            self.map.addAnnotation(anno)
           
        }
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
            DispatchQueue.main.async {
                let nav = self.storyboard?.instantiateViewController(withIdentifier: "LoginScreenController") as! LoginScreenController
                self.present(nav, animated: true, completion: nil)
                
            }

            print("User signed out")
        } catch {
            print("Debug: Error signing out")
            
        }
    }

    func setHomeScreenView(){
        super.viewDidLoad()
        view.addSubview(map)
        let searchVC = SearchViewController()
        searchVC.delegateSelect = self
        let panel = FloatingPanelController()
        panel.set(contentViewController: searchVC)
        panel.addPanel(toParent: self)
        map.showsUserLocation = true
        map.userTrackingMode = .follow
  
    }
    
    func checkLocationAuthorization() {	
        
            switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse:
                locationManager?.requestAlwaysAuthorization()
                break
            case .denied:
                locationManager?.requestAlwaysAuthorization()
                break
            case .notDetermined:
                locationManager?.requestAlwaysAuthorization()
            case .restricted:
                locationManager?.requestAlwaysAuthorization()
                break
            case .authorizedAlways:
                locationManager?.startUpdatingLocation()
                locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            }
        }
    
    func searchViewController(_ vc: SearchViewController, didSelectLocationWith coordinates: CLLocationCoordinate2D?) {
        guard let coordinates = coordinates else {
            print("tesssst")
            return
        }
//        map.removeAnnotations(map.annotations)
        print("owotest")
        let pin = MKPointAnnotation()
        pin.coordinate = coordinates
        map.addAnnotation(pin)
        map.setRegion(MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.7, longitudeDelta: 0.7)), animated: true)
    }
    
    func fetchUserData (){
        guard let currentUid = Auth.auth().currentUser?.uid else { return}
        Service.shared.fetchUserData(uid:currentUid) { user in
            self.user = user
        }
    }
    
    
}
