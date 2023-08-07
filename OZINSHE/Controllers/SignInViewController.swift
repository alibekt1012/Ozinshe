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

class SignInViewController: UIViewController {
    @IBOutlet var emailTextField: TextFieldWithPadding!
    
    @IBOutlet var passwordTextField: TextFieldWithPadding!
    
    @IBOutlet var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
        
        keyboardWhenTappedAround()
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
        
        if email.isEmpty || password.isEmpty {
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
