//
//  SignUpController.swift
//  vip
//
//  Created by Ines on 2020/2/17.
//  Copyright © 2020 Ines. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class LogInController: UIViewController {
 
    

//    UITextField
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
//    UILabel
    @IBOutlet weak var errorLabel: UILabel!
//    UIButton
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var forgetPasswordButtin: UIButton!
    @IBOutlet weak var googleConnectionButton: GIDSignInButton!
    
    //properties
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        
    }
    
    //private function
    private func setupTextField(){
        accountTextField.delegate = self
        passwordTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    //actions
    @objc private func hideKeyboard(){
        accountTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }

    @IBAction func signUpButtonWasPressed(_ sender: UIButton) {
    }
    
    @available(iOS 13.0, *)
    @IBAction func logInButtonWasPressed(_ sender: UIButton) {
        let account = accountTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        Auth.auth().signIn(withEmail: account, password: password) { (result, error) in
            
            if error != nil{
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.textColor = UIColor.red
            }else{

                if let controller = self.storyboard?.instantiateViewController(withIdentifier: "HomeControllerId") as? HomeController{
                    self.navigationController?.pushViewController(controller, animated: true)
                }
               
            }
        }
    }
    
    @IBAction func googleConnectionButtonWasPressed(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    @IBAction func forgetPasswordWasPressed(_ sender: Any) {
            
    }
    
} 

extension LogInController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true 
    }
}


