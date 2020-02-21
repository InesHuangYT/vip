//
//  HomeController.swift
//  vip
//
//  Created by Ines on 2020/2/19.
//  Copyright © 2020 Ines. All rights reserved.
//

import UIKit
import GoogleSignIn
import FirebaseAuth

class HomeController: UIViewController {
   
    @IBOutlet weak var currentUserlabel: UILabel!
    @IBOutlet weak var signOutButton: UIButton!
    
    var uid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("current user uidd : " , currentUserName())
     }
    
    @IBAction func signOutButtonWasPressed(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        navigationController?.popViewController(animated: true)
    }
    
    func currentUserName()->(String){
        if let user = Auth.auth().currentUser{
            uid = user.uid
            print("uid : ",uid)
            currentUserlabel.text = " login uid is : " + (uid)
        }
        return(uid)

    }
    

}




