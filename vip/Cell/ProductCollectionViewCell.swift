//
//  ProductCollectionViewCell.swift
//  VIP
//
//  Created by Ines on 2020/3/18.
//  Copyright © 2020 Ines. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let myColor : UIColor = UIColor( red: 137/255, green: 137/255, blue:128/255, alpha: 1.0 )
        layer.borderWidth = 5
        layer.borderColor = myColor.cgColor
        layer.cornerRadius = 45



    }
    
    func setProductLabel(text : String){
        self.productLabel.text = text
    }
    

}
