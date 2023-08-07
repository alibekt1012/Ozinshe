//
//  SignInViewController.swift
//  OZINSHE
//
//  Created by Almat Alibekov on 04.08.2023.
//

import UIKit

class SignInViewController: UIViewController {
    @IBOutlet var emailTextField: TextFieldWithPadding!
    
    @IBOutlet var passwordTextField: TextFieldWithPadding!
    
    @IBOutlet var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
        
    }
    
    func configureViews() {
        emailTextField.layer.cornerRadius = 12
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        
        passwordTextField.layer.cornerRadius = 12
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        
        signInButton.layer.cornerRadius = 12
    }
    
    
    
    @IBAction func textFieldEditingDidBegin(_ sender: TextFieldWithPadding) {
        sender.layer.borderColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1.00).cgColor
       
    }
    
    @IBAction func textFieldEditingDidEnd(_ sender: TextFieldWithPadding) {
        sender.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
       
    }
    
    

}
