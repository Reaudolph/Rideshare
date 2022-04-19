//
//  SignUpController.swift
//  UwUber
//
//  Created by Hrishikesh Vikram on 4/3/22.
//

import Foundation
import Firebase
import UIKit
import GeoFire


class SignUpController: UIViewController {
    
    
    
    
    @IBOutlet weak var userUsernameTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userRoleChoice: UISegmentedControl!
    
    var location = LocationHandler.shared.locationManager.location
    
    @IBAction func SignUserUp(_ sender: Any) {
        
        guard let userEmail = userEmailTextField.text else { return }
        guard let userPassword = passwordTextField.text else { return }
        guard let userUsername  = userUsernameTextField.text else { return }
        let userIndexChoice = userRoleChoice.selectedSegmentIndex

        print(userEmail)
        print(userUsername)
        print(userPassword)
        
        

//        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { (result, error) in
//            if let error = error {
//                print("an error occured \(error)")
//
//            }
//            guard let uid  = result?.user.uid else { return }
//
//
//            if userIndexChoice == 1{
//                var geofire = GeoFire(firebaseRef: REF_DRIVER_LOCATIONS)
//
////                geofire.setLocation(location, forKey: uid, with: GFCompletionBlock : { (Error?) in
////
////
////                }
////            )
//            }
//
//
//            let data  = [ "email" : userEmail,
//                          "userName" : userUsername,
//                          "userRole" : userIndexChoice] as [String : Any]
//
//          REF_USERS.child(uid).updateChildValues(data) { error, ref in
//                guard let controller  = UIApplication.shared.keyWindow?.rootViewController as? MapController else {return}
//                guard let thisController = SignUpController() as? UIViewController else { return }
//                thisController.presentingViewController?.dismiss(animated: false, completion:nil)
//
//                print("Saved Data")
//            }
//        }
        
        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { (result, error) in
            if let error = error {
                print("DEBUG: Failed to register user with error \(error.localizedDescription)")
                return
            }
            
            guard let uid = result?.user.uid else { return }
            
            let values = ["email": userEmail,
                          "fullname": userUsername,
                          "accountType": userIndexChoice] as [String : Any]
            
            if userIndexChoice == 1 {
                let geofire = GeoFire(firebaseRef: REF_DRIVER_LOCATIONS)
                guard let location = self.location else { return }
                
                geofire.setLocation(location, forKey: uid, withCompletionBlock: { (error) in
                    REF_USERS.child(uid).updateChildValues(values) { error, ref in
                                  guard let controller  = UIApplication.shared.keyWindow?.rootViewController as? MapController else {return}
                                  guard let thisController = SignUpController() as? UIViewController else { return }
                                  thisController.presentingViewController?.dismiss(animated: false, completion:nil)
                    
                                  print("Saved Data")
                                }
                })
            }
            REF_USERS.child(uid).updateChildValues(values) { error, ref in
                          guard let controller  = UIApplication.shared.keyWindow?.rootViewController as? MapController else {return}
                          guard let thisController = SignUpController() as? UIViewController else { return }
                          thisController.presentingViewController?.dismiss(animated: false, completion:nil)
            
                          print("Saved Data")
                        }
            
           
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        title = "Sign Up"
        let sharedLocationManager = LocationHandler.shared.locationManager
//        print("Debig: Location is \(sharedLocationManager?.location)")
        
        
        // Do any additional setup after loading the view.
    }
    
    
}


