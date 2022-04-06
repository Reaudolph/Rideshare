//
//  ViewController.swift
//  UwUber
//
//  Created by Hrishikesh Vikram on 4/1/22.
//

import UIKit
import Firebase

class LoginScreenController: UIViewController {
    @IBOutlet weak var LoginButton: UIButton!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func LoginButtonPressed(_ sender: Any) {
        guard let userPassword = passwordTextField.text else {return }
        guard let email  = emailTextField.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: userPassword) { [weak self] authResult, error in
            print("coundnt \(error?.localizedDescription)")
            guard let strongSelf = self else { return }
          // ...
        }
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        title = "Login"
        
        
        
        
        
        // Do any additional setup after loading the view.
    }


}

