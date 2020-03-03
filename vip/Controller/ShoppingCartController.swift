//
//  ShoppingCartController.swift
//  vip
//
//  Created by rourou on 03/03/2020.
//  Copyright © 2020 Ines. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ShoppingCartController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
   
    func loadData(){
        
    }
    
    func numberOfSectionInTableView(tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
        return cell
    }
    
    
    
    @IBAction func checkBoxTapped(_ sender: UIButton){
        if sender.isSelected{
            print("Selected!")
            sender.isSelected = false
        }else{
            sender.isSelected = true
        }
    }
    
}
