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
    @IBOutlet weak var productImage: UIImageView!
    let imagePicker = UIImagePickerController()
    
    var ref: DatabaseReference!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(CreateProductDataController.openGallery(tapGesture:)))
        productImage.isUserInteractionEnabled = true
        productImage.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func openGallery(tapGesture: UITapGestureRecognizer){
        print("test")
        self.setImagePicker()
    }
    
//    static func storyboardInstance() -> CreateProductDataController? {
//               let storyboard = UIStoryboard(name:
//                "CreateProductDataController", bundle: nil)
//        return storyboard.instantiateInitialViewController() as? CreateProductDataController
//               
//         }
    
    @IBAction func CreatBtn(_ sender: Any) {
        
        
//         self.ref.child("Product/\(randomid)").setValue(["ProductName": ProductName.text ?? "Null", "Price": Price.text ?? "Null"])
        var newData = ["ProductName": ProductName.text ?? "Null", "Price": Price.text ?? "Null", "Description": Description.text ?? "Null", "ProductEvaluation": ProductEvaluation.text ?? "Null", "SellerEvaluation": SellerEvaluation.text ?? "Null"]
        
        newData["Notice"] = Notice.text ?? "Null"
        newData["ManuDate"] = ManuDate.text ?? "Null"
        newData["ExpDate"] = ExpDate.text ?? "Null"
        newData["Method"] = Method.text ?? "Null"
        newData["OtherInfo"] = OtherInfo.text ?? "Null"
        
        self.ref.child("Product").childByAutoId().setValue(newData)
        
        print(newData)
        print("creat product data successfully")
        
    
        
    }
}

extension CreateProductDataController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
       func setImagePicker(){
           if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.delegate = self
            imagePicker.isEditing = true
            
            self.present(imagePicker, animated: true, completion: nil)
               
           }
       }
    
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]){
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        productImage.image = image
        self.dismiss(animated: true, completion: nil)
        
    }
   }
