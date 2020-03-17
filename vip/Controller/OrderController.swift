//
//  OrderController.swift
//  vip
//
//  Created by Chun on 2020/3/16.
//  Copyright © 2020 Ines. All rights reserved.
//

import UIKit

class OrderController: UIViewController {

     @IBOutlet weak var btnMenuButton: UIBarButtonItem!
       
       override func viewDidLoad() {
           super.viewDidLoad()
           btnMenuButton.target = revealViewController()
           btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))

           self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
       }
       override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
       }

   
}
