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
        
        Auth.auth().signIn(withEmail: email, password: userPassword, completion: { (auth, error) in
            if let x = error {
                let err = x as NSError
                switch err.code {
                case AuthErrorCode.wrongPassword.rawValue:
                    print("wrong password")
                case AuthErrorCode.invalidEmail.rawValue:
                    print("invalued email")
                case AuthErrorCode.accountExistsWithDifferentCredential.rawValue:
                    print("accountExistsWithDifferentCredential")
                default:
                    print("unknown error: \(err.localizedDescription)")
                }
            } else {
                if let _ = auth?.user {
                    print("authd") //user is auth'd proceed to next step
                    self.dismiss(animated: false, completion: nil)
                } else {
                    print("authentication failed - no auth'd user")
                }
            }
        })
    }
    
    func dismissVC(){
        

    }
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        //        title = "Login"
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
}




