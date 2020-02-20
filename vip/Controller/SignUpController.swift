//
//  SignUpViewController.swift
//  vip
//
//  Created by Ines on 2020/2/17.
//  Copyright © 2020 Ines. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpController: UIViewController {
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func validateField() -> String? {
        
        //check that all fields are filled in  
        if accountTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordConfirmTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || phoneTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "請輸入全部！"
        }
        
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if isPasswordValid(cleanedPassword) == false{
            return "密碼長度至少為8"
        }
        if passwordTextField.text != passwordConfirmTextField.text{
            
            return "密碼不一致"
        }
        return nil
    }
    

    @IBAction func signUpConfirmTap(_ sender: Any) {
        
//        validate the fields
        let error = validateField()
        if error != nil{
            //something wrong with text fields, show error message
            showError(error!)
            print("error:",error!)
        }else{
            let account = accountTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let name = nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let phone = phoneTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
//        create the user 
            Auth.auth().createUser(withEmail: account, password: password) {(result,err) in 
                if err != nil{
                    
                    self.showError("Error creating user")
                }else{
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["name" : name, "phone": phone, "uid":result!.user.uid ]) { (error) in
                        
                        if error != nil{
                            self.showError("saving User data error")
                        }
                    }
                    
//        transisiton to the home screens
                    if #available(iOS 13.0, *) {
                        self.transitionToHome()
                    } else {
                        // Fallback on earlier versions
                    }
                      
                }
                
            }
        }

    }
    
    
    
    
    
//   if password is secured
    func isPasswordValid(_ password : String) -> Bool{
//       at least more that eight charaters && at least one alphabet https://stackoverflow.com/questions/39284607/how-to-implement-a-regex-for-password-validation-in-swift
//        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$")
         let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*\\d)(?=.*\\d)[A-Za-z\\d]{8,}$")
        return passwordTest.evaluate(with: password)
    }
    
//   error message
    func showError(_ message : String){
        errorLabel.text = message
//        errorLabel.alpha = 1
    }
    
//  signUp successfully
    @available(iOS 13.0, *)
    func transitionToHome(){
        navigationController?.popViewController(animated: true)
    }
}
 
