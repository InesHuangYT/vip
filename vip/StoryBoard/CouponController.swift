//
//  CouponController.swift
//  vip
//
//  Created by Chun on 2020/3/17.
//  Copyright © 2020 Ines. All rights reserved.
//

import UIKit
import Firebase

class CouponController: UIViewController {

    let ref =  Database.database().reference()
    
    @IBOutlet weak var head: UILabel!
    @IBOutlet weak var body: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Database.database().reference().child("coupon")
        .queryOrderedByKey()
        .observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value as? [String:Any]
                else {
                    print("Error")
                    return
            }
            print(value)
            self.setLabel(value: value)
        })
    }
    
    func setLabel(value:[String:Any]){

        let h = value["head"] as? String
        let b = value["body"] as? String
        
        head.text = (h!)
        body.text = (b!)
    }
}
