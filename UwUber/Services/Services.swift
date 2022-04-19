//
//  Services.swift
//  UwUber
//
//  Created by Hrishikesh Vikram on 4/18/22.
//

import Foundation
import Firebase
import GeoFire


let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
let REF_DRIVER_LOCATIONS = DB_REF.child("driver-locations")



struct Service {
    static let shared = Service()
    
    
    
    
    func fetchDrivers(location: CLLocation, completion: @escaping(User) -> Void) {
        let geofire = GeoFire(firebaseRef: REF_DRIVER_LOCATIONS)
        
        REF_DRIVER_LOCATIONS.observe(.value) { (snapshot) in
            geofire.query(at: location, withRadius: 50).observe(.keyEntered, with: { (uid, location) in
                Service.shared.fetchUserData(uid: uid, completion: { (user) in
                    var driver = user
                    driver.location = location
                    completion(driver)
                })
            })
        }
    }
        
    
    func fetchUserData(uid: String,completion: @escaping(User) -> Void) {
        REF_USERS.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            let uid = snapshot.key
            let user = User(uid: uid, dictionary: dictionary)
            print("Debug user  is \(user.userName)")
            print("Debug user  is \(user.email)")
            print("Debug user  is \(user.userRole)")
            
            
            completion(user)

            
        }
    }
   
    
    
}

