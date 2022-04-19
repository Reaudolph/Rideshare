//
//  User.swift
//  UwUber
//
//  Created by Hrishikesh Vikram on 4/18/22.
//

import CoreLocation

struct User {
    let userName: String
    let email: String
    let userRole: Int
    var location: CLLocation?
    var uid: String
    
    init (uid: String, dictionary : [String: Any]){
        self.userName = dictionary["userName"] as? String ?? ""
        self.email   = dictionary["email"] as? String ?? ""
        self.uid = uid

        self.userRole = dictionary["userRole"] as? Int ?? 0

    }
}
