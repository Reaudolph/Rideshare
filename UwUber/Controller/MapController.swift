//
//  MapController.swift
//  UwUber
//
//  Created by Hrishikesh Vikram on 4/4/22.
//

import Foundation
import UIKit
import Firebase


class MapController : UIViewController {
    
    
    
    
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Map"
        
        
        checkUserLoggedIn()
        view.backgroundColor = .white
        
        
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
        }
    }
    
    func signUserOut(){
        
        do {
            try Auth.auth().signOut()
            print("User signed out")
        } catch {
            print("Debug: Error signing out")
            
        }
    }


}
