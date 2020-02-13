//
//  ViewController.swift
//  vip
//
//  Created by Ines on 2020/2/13.
//  Copyright © 2020 Ines. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
    @IBOutlet weak var label: UILabel!
    let message = "Bonjour"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(message)
        let reversed = reverse(text: "stressed")
        label.text = reversed
  
    }
    
    func reverse(text: String) -> String {
        return String(text.reversed())
    }

    





}

