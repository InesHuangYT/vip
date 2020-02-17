//
//  SignUpController.swift
//  vip
//
//  Created by Ines on 2020/2/17.
//  Copyright © 2020 Ines. All rights reserved.
//

import UIKit

class LogInController: UIViewController {

    //outlets
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    //properties
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
      
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
    
    @IBAction func logInButtonWasPressed(_ sender: UIButton) {
    }
    
    
} 
extension LogInController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true 
    }
}
