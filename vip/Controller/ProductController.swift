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
//        self.collectionView.reloadData()
        
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
//        cell.setProductLabel(index: indexPath.row)
        cell.setProductLabel(index: indexPath.row)
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Product", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProductInformationControllerId") as!  ProductInformationController
        vc.index = indexPath.row
        self.navigationController?.pushViewController(vc,animated: true)

    }
}

extension ProductController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.calculateWith()
//        print(width,width*1.2)
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
