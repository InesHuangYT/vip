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
    var ref: DatabaseReference!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
   
    func loadData(){
       ref = Database.database().reference()
        ref.child("ShoppingCart").observe(.childAdded, with: {(DataSnapshot) in
            print("LoadData: ", DataSnapshot)
        }, withCancel: nil)
    }
    
    func numberOfSectionInTableView(tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        //Count Products
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
        return cell
    }
    
//    @IBAction func ListBtnTapped(_ sender: Any) {
//    }
//
//    @IBAction func OrderBtn(_ sender: Any) {
//    }
//
//    @IBAction func DeleteBtn(_ sender: Any) {
//    }
//
    
}
