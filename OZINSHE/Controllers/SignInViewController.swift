//
//  SignInViewController.swift
//  OZINSHE
//
//  Created by Almat Alibekov on 04.08.2023.
//

import UIKit
import Alamofire
import SVProgressHUD
import SDWebImage
import SwiftyJSON
import Localize_Swift

class SignInViewController: UIViewController, LanguageProtocol {
    
    var validation = Validation()
    
    @IBOutlet var greetingsLabel: UILabel!
    @IBOutlet var logInLabel: UILabel!
    @IBOutlet var emailTextField: TextFieldWithPadding!
    @IBOutlet var passwordTextField: TextFieldWithPadding!
    @IBOutlet var signInButton: UIButton!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var validationLabel: UILabel!
    @IBOutlet var passwordLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet var wrongEmailLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet var forgotPasswordButton: UIButton!
    @IBOutlet var noAccountLabel: UILabel!
    @IBOutlet var registrationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
        
        keyboardWhenTappedAround()
    }
    
    func configureViews() {
        
        greetingsLabel.text = "HELLO".localized()
        logInLabel.text = "LOG_IN".localized()
        
        emailTextField.placeholder = "EMAIL_PLACEHOLDER".localized()
        emailTextField.layer.cornerRadius = 12
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        
        passwordLabel.text = "PASSWORD".localized()
        
        passwordTextField.placeholder = "PASSWORD_PLACEHOLDER".localized()
        passwordTextField.layer.cornerRadius = 12
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        
        forgotPasswordButton.setTitle("FORGOT_PASSWORD".localized(), for: .normal)
        
        
        signInButton.layer.cornerRadius = 12
        signInButton.setTitle("SIGN_IN".localized(), for: .normal)
        
        noAccountLabel.text = "DO_NOT_HAVE_AN_ACCOUNT".localized()
        registrationButton.setTitle("REGISTRATION".localized(), for: .normal)
        
        validationLabel.isHidden = true
    }
    
    func languageDidChange() {
        configureViews()
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
    
    @IBAction func signIn(_ sender: Any) {
        SVProgressHUD.show()
        
        let email = emailTextField.text!
        let password = passwordTextField.text!
        let isValidateEmail = self.validation.validateEmailId(emailID: email)
        
        if email.isEmpty || password.isEmpty {
            SVProgressHUD.dismiss()
            validationLabel.text = "Please fill all required fields"
            passwordLabelTopConstraint.constant = 46
            validationLabel.isHidden = false
            return
        }
        if isValidateEmail == false {
            SVProgressHUD.dismiss()
            emailTextField.layer.borderColor = UIColor(red: 1.00, green: 0.25, blue: 0.17, alpha: 1.00).cgColor
            passwordLabelTopConstraint.constant = 46
            validationLabel.text = "Қате формат"
            validationLabel.isHidden = false
            return
        }
        let parameters = ["email": email, "password": password]
        AF.request("http://api.ozinshe.com/auth/V1/signin", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData { response in
            
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
            }
        }
    }
    
    
    func startApp() {
        let tabBarController = storyboard?.instantiateViewController(withIdentifier: "TabBar")
        
        tabBarController?.modalPresentationStyle = .fullScreen
        
        present(tabBarController!, animated: true)
    }
    
}
