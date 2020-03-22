//
//  ProductInformationController.swift
//  vip
//
//  Created by Ines on 2020/3/16.
//  Copyright © 2020 Ines. All rights reserved.
//

import UIKit
import Firebase

class ProductInformationController: UIViewController {
    var ref: DatabaseReference!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var evaluationLabel: UILabel!
    @IBOutlet weak var sellerEvaluationLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    var index  = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("index",index)
        setLabel(index: index)
     
    }
    
    
    func setLabel(index:Int){
        Database.database().reference().child("Product")
            .queryOrderedByKey()
            .observeSingleEvent(of: .value, with: { snapshot in 
                let value = snapshot.value as? [String:Any]
                let valueKey = value.map { Array($0.keys) }
                var toString : String?
                toString = valueKey?[index]
                self.ref = Database.database().reference().child("Product")
                let reference = self.ref.child(toString!)
                reference.observe(.value, with: { (snapshot) in
                    let value = snapshot.value as? [String: Any]
                    self.nameLabel.text = value?["ProductName"] as? String ?? ""
                    self.priceLabel.text = value?["Price"] as? String ?? ""
                    self.descriptionLabel.text = value?["Description"] as? String ?? ""
                    self.evaluationLabel.text = value?["ProductEvaluation"] as? String ?? ""
                    self.sellerEvaluationLabel.text = value?["SellerEvaluation"] as? String ?? ""
                       
                   })
           })
    }
        
    @IBAction func back(_ sender: Any) {        self.navigationController?.popViewController(animated: true)

    }
    
    

}
