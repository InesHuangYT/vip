//
//  HomeController.swift
//  vip
//
//  Created by Ines on 2020/2/19.
//  Copyright © 2020 Ines. All rights reserved.
//

import UIKit
import GoogleSignIn
class HomeController: UIViewController {

    @IBOutlet weak var signOutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

     }
    
    @IBAction func signOutButtonWasPressed(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        navigationController?.popViewController(animated: true)
    }
    
  

}
