//
//  ProfileController.swift
//  vip
//
//  Created by Ines on 2020/3/8.
//  Copyright © 2020 Ines. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase


class ProfileController: UIViewController {
    
//    var ref : DatabaseReference!
    let ref = Database.database().reference()
    
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var passwordChangeButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var deliverWaysLabel: UILabel!
    @IBOutlet weak var pamentWaysLabel: UILabel!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        Database
        .database()
        .reference()
        .child("users")
        .child(Auth.auth().currentUser!.uid)
        .child("Profile")
        .queryOrderedByKey()
        .observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value as? [String:Any] else {
                print("Error")
                return
            }
            let account = value["account"] as? String
            print("account : ",account!)
            let name = value["name"] as? String
            print("name : ",name!)
        })
        
    
    }

   
}
