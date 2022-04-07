//
//  SignUpController.swift
//  UwUber
//
//  Created by Hrishikesh Vikram on 4/3/22.
//

import Foundation
import Firebase
import UIKit

class SignUpController: UIViewController {

    @IBOutlet weak var userUsernameTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userRoleChoice: UISegmentedControl!
    
    
    @IBAction func SignUserUp(_ sender: Any) {
        
        guard let userEmail = userEmailTextField.text else { return }
        guard let userPassword = passwordTextField.text else { return }
        guard let userUsername  = userUsernameTextField.text else { return }
        let userIndexChoice = userRoleChoice.selectedSegmentIndex
        
        
        
        
        
        
        
        print(userEmail)
        print(userUsername)
        print(userPassword)
        
        
        
        
        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { (result, error) in
            if let error = error {
                print("an error occured \(error)")
                
            }
            guard let uid  = result?.user.uid else { return }
            let data  = [ "email" : userEmail,
                          "userName" : userUsername,
                          "userRole" : userIndexChoice] as [String : Any]
            
            Database.database().reference().child("users").child(uid).updateChildValues(data) { error, ref in
                
                print("Saved Data")
            }
        }
        
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        title = "Sign Up"
        
        
        
        // Do any additional setup after loading the view.
    }


}


