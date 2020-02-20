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
    
    var uid = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        if let user = Auth.auth().currentUser{
                   uid = user.uid
               }
    }
    
    // To hideKeyboard
    private func setupTextField(){
        accountTextField.delegate = self
        passwordTextField.delegate = self
        passwordConfirmTextField.delegate = self
        nameTextField.delegate = self
        phoneTextField.delegate = self
         
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
   }
    
    @objc private func hideKeyboard(){
        accountTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        passwordConfirmTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
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
                    
                    if let user = Auth.auth().currentUser{
                        self.uid = user.uid
                        print("self.uid: ",self.uid)
                    }
                    print("You have successfully signed up")
                    Database.database().reference(withPath: "users/\(self.uid)/Profile/account").setValue(account)
                    Database.database().reference(withPath: "users/\(self.uid)/Profile/password").setValue(password)
                    Database.database().reference(withPath: "users/\(self.uid)/Profile/name").setValue(name)
                    Database.database().reference(withPath: "users/\(self.uid)/Profile/phone").setValue(phone)


                    if #available(iOS 13.0, *) {
                        self.transitionToHome()      //transisiton to home screens
                    } else {
                        // Fallback on earlier versions
                    }
                        
                        
                        //                    let db = Firestore.firestore()
                        //                    db.collection("users").addDocument(data: ["account": account,"password":password ,"name" : name, "phone": phone, "uid":result!.user.uid ]) { (error) in
                        //                        
                        //                        if error != nil{
                        //                            self.showError("saving User data error")
                        //                        }
                        //                    }
                      
                }
                
            }
        }

    }
    
    
// check if signUp all fit the format
    func validateField() -> String? {
        
        //check that all fields are filled in  
        if accountTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordConfirmTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || phoneTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "請輸入全部空格！"
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
        errorLabel.textColor = UIColor.red
//        errorLabel.alpha = 1
    }
    
//  signUp successfully
    @available(iOS 13.0, *)
    func transitionToHome(){
        navigationController?.popViewController(animated: true)
    }
    
    
    
}

extension SignUpController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true 
 }
}
