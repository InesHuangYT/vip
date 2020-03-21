//
//  ProductCollectionViewCell.swift
//  VIP
//
//  Created by Ines on 2020/3/18.
//  Copyright © 2020 Ines. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class ProductCollectionViewCell: UICollectionViewCell {
    var ref: DatabaseReference!

    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let myColor : UIColor = UIColor( red: 137/255, green: 137/255, blue:128/255, alpha: 1.0 )
        layer.borderWidth = 5
        layer.borderColor = myColor.cgColor
        layer.cornerRadius = 45        

    }
    
    func setProductLabel(index:Int){
        Database.database().reference().child("Product")
            .queryOrderedByKey()
            .observeSingleEvent(of: .value, with: { snapshot in 
                let value = snapshot.value as? [String:Any]
//              let valueKey = value?.keys as? [Any]
                let valueKey = value.map { Array($0.keys) }
                print("valueKey",valueKey ?? 0)
                print("valueKey[0]",valueKey?[0] as Any) 
                var toString : String?
                toString = valueKey?[index]
                print("[index]",index)
                print("toString",toString ?? 0)
                self.ref = Database.database().reference().child("Product")
                let reference = self.ref.child(toString!)
                reference.observe(.value, with: { (snapshot) in
                    let value = snapshot.value as? [String: Any]
                    self.productLabel.text = value?["ProductName"] as? String ?? ""
                    self.priceLabel.text = value?["Price"] as? String ?? ""
                })
                
            })
    }
    
    
   
}
