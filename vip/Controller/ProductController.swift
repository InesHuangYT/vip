//
//  ProductController.swift
//  vip
//
//  Created by Ines on 2020/3/16.
//  Copyright © 2020 Ines. All rights reserved.
//

import UIKit
import Firebase


class ProductController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
//    let data = ["first","second","three","three","three","three"]
    var estimatedWidth = 160.0
    var cellMarginSize = 16.0
    var ref: DatabaseReference!




    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self 
        self.collectionView.dataSource = self
//        將ProductCollectionViewCell連進來 
        self.collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCollectionViewCell")
        self.setupGridView()
        
        Database.database().reference().child("Product")
            .queryOrderedByKey()
            .observeSingleEvent(of: .value, with: { snapshot in 
//                let value = snapshot.value as? [String:Any]
//                self.length = (value?.keys.count)!
//                print("length",self.length)
//                self.ref = Database.database().reference().child("Product")
//                var productName = [String]()
//                var productPrice = [String]()
//                
//                for i in value!.keys{
//                    let reference = self.ref.child(i)
//                    reference.observe(.value, with: { (snapshot) in
//                        let value = snapshot.value as? [String: Any] 
//                        let productNameAdd = value?["ProductName"] as? String ?? ""
//                        let productPriceAdd = value?["Price"] as? String ?? ""
//                        productName.append(productNameAdd) 
//                        productPrice.append(productPriceAdd) 
//                        
//                        print("here1 ",productName, productPrice)
//                      
//                        
//                    })
//                }                       
            })


    }

    func setupGridView(){
        let flow = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flow.minimumInteritemSpacing = CGFloat(self.cellMarginSize)
        flow.minimumLineSpacing = CGFloat(self.cellMarginSize)
    }
    
   
    
}

extension ProductController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section:Int) -> Int {
        let productCount = Database.database().reference().child("Product").key?.count
        return (productCount ?? 0)-1 
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
//        cell.setProductLabel(text: self.dataProductName[indexPath.row])
        cell.setProductLabel(index: indexPath.row)

        return cell
        
    }
}

extension ProductController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.calculateWith()
        print(width,width*1.2)
        return CGSize(width: width, height: width*1.2)
    }
    func calculateWith()-> CGFloat{
        let estimateWidth = CGFloat(estimatedWidth)
        let cellCount = floor(CGFloat(self.view.frame.size.width / estimateWidth))
        let margin = CGFloat(cellMarginSize * 2)
        let width = (self.view.frame.size.width - CGFloat(cellMarginSize)*(cellCount-1)-margin)/cellCount
        return width
        
    }
}
