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

class MapController : UIViewController {
    
    
    private let map: MKMapView = {
        let map = MKMapView()
        return map
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Map"
        
        
        checkUserLoggedIn()
       
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func checkUserLoggedIn (){
        
        if Auth.auth().currentUser?.uid == nil {
            
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
    }
    


}
