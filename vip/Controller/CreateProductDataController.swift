//
//  CreateProductDataController.swift
//  vip
//
//  Created by rourou on 04/03/2020.
//  Copyright © 2020 Ines. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class CreateProductDataController: UIViewController {
    
    @IBOutlet weak var ProductName: UITextField!
    @IBOutlet weak var Price: UITextField!
    @IBOutlet weak var Description: UITextField!
    @IBOutlet weak var ProductEvaluation: UITextField!
    @IBOutlet weak var SellerEvaluation: UITextField!
    @IBOutlet weak var Notice: UITextField!
    @IBOutlet weak var ManuDate: UITextField!
    @IBOutlet weak var ExpDate: UITextField!
    @IBOutlet weak var Method: UITextField!
    @IBOutlet weak var OtherInfo: UITextField!
    var ref: DatabaseReference!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
    }
    
    @IBAction func CreatBtn(_ sender: Any) {
        
        let id = UUID()
        print(ProductName.text)
//        self.ref.child("Product/\(id)").setValue(["ProductName": ProductName.text ?? "Null", "Price": Price.text ?? "Null", "Description": Description.text ?? "Null", "ProductEvaluation": ProductEvaluation.text ?? "Null", "SellerEvaluation": SellerEvaluation.text ?? "Null", "Notice": Notice.text ?? "Null", "ManuDate": ManuDate.text ?? "Null", "ExpDate": ExpDate.text ?? "Null", "Method": Method.text ?? "Null", "OtherInfo": OtherInfo.text ?? "Null"])
        
    }
    
    
}
