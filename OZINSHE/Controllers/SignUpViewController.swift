//
//  SignUpViewController.swift
//  OZINSHE
//
//  Created by Almat Alibekov on 07.08.2023.
//

import UIKit
import Alamofire
import SVProgressHUD
import SDWebImage
import SwiftyJSON

class SignUpViewController: UIViewController {
    
    let validation = Validation()

    @IBOutlet var emailTextField: TextFieldWithPadding!
    @IBOutlet var passwordTextField: TextFieldWithPadding!
    @IBOutlet var repeatPasswordTextField: TextFieldWithPadding!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var signUpButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet var validationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        emailTextField.layer.cornerRadius = 12
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        
        passwordTextField.layer.cornerRadius = 12
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        
        repeatPasswordTextField.layer.cornerRadius = 12
        repeatPasswordTextField.layer.borderWidth = 1
        repeatPasswordTextField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        
        signUpButton.layer.cornerRadius = 12
        
        validationLabel.isHidden = true
    }
    
    func keyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @IBAction func textFieldEditingDidBegin(_ sender: TextFieldWithPadding) {
        sender.layer.borderColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1.00).cgColor
       
    }
    
    @IBAction func textFieldEditingDidEnd(_ sender: TextFieldWithPadding) {
        sender.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
       
    }

    
    @IBAction func showPassword(_ sender: Any) {
        passwordTextField.isSecureTextEntry.toggle()
        
    }
    
    @IBAction func showRepeatedPassword(_ sender: Any) {
        repeatPasswordTextField.isSecureTextEntry.toggle()
    }
    
    @IBAction func signUp(_ sender: Any) {
        signUpButtonTopConstraint.constant = 40
        validationLabel.isHidden = true
        SVProgressHUD.show()
        
        let email = emailTextField.text!
        let password = passwordTextField.text!
        let repeatedPassword = repeatPasswordTextField.text!
        let isValidateEmail = self.validation.validateEmailId(emailID: email)
       
        if email.isEmpty || password.isEmpty {
            SVProgressHUD.dismiss()
            validationLabel.text = "Please fill all required fields"
            signUpButtonTopConstraint.constant = 94
            validationLabel.isHidden = false
            return
        }
        if isValidateEmail == false {
            SVProgressHUD.dismiss()
            emailTextField.layer.borderColor = UIColor(red: 1.00, green: 0.25, blue: 0.17, alpha: 1.00).cgColor
            signUpButtonTopConstraint.constant = 94
            validationLabel.text = "Қате формат"
            validationLabel.isHidden = false
            return
        }
        if password != repeatedPassword {
            SVProgressHUD.dismiss()
            passwordTextField.layer.borderColor = UIColor(red: 1.00, green: 0.25, blue: 0.17, alpha: 1.00).cgColor
            repeatPasswordTextField.layer.borderColor = UIColor(red: 1.00, green: 0.25, blue: 0.17, alpha: 1.00).cgColor
            validationLabel.text = "Пароли не совпадают"
            signUpButtonTopConstraint.constant = 94
            validationLabel.isHidden = false
            return
        }
        
        let parameters = ["email": email, "password": password]
        AF.request("http://api.ozinshe.com/auth/V1/signup", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData { response in
            
            SVProgressHUD.dismiss()
            
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                
                if let accessToken = json["accessToken"].string {
                    UserDefaults.standard.set(accessToken, forKey: "accessToken")
                    
                    self.startApp()
                }
                else {
                    SVProgressHUD.showError(withStatus: "CONNECTION_ERROR".localized())
                }
            } else {
                var ErrorString = "CONNECTION_ERROR".localized()
                if let sCode = response.response?.statusCode {
                    ErrorString = ErrorString + " \(sCode)"
                }
                ErrorString = ErrorString + " \(resultString)"
                SVProgressHUD.showError(withStatus: "\(ErrorString)")
                self.validationLabel.text = resultString
                self.validationLabel.isHidden = false
                self.signUpButtonTopConstraint.constant = 94
            }
        }
    }
    
    
    func startApp() {
        let tabBarController = storyboard?.instantiateViewController(withIdentifier: "TabBar")
        
        tabBarController?.modalPresentationStyle = .fullScreen
        
        present(tabBarController!, animated: true)
    }
}


