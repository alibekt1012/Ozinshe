//
//  ChangePasswordViewController.swift
//  OZINSHE
//
//  Created by Almat Alibekov on 03.08.2023.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class ChangePasswordViewController: UIViewController {
    
    
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmPasswordTextField: UITextField!
    @IBOutlet var saveChangesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func saveChanges(_ sender: Any) {
     
        SVProgressHUD.show()
        
        let password = passwordTextField.text!
        let confirmPassword = confirmPasswordTextField.text!
        
        let parameters = ["password" : password]
                
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        
        if password != confirmPassword {
            SVProgressHUD.dismiss()
            SVProgressHUD.showError(withStatus: "Password's is not matching")
            return
        }
        
        AF.request("http://api.ozinshe.com/core/V1/user/profile/changePassword", method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData { response in
            
            SVProgressHUD.dismiss()
            
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
            }
            
            if response.response?.statusCode == 200 {
                SVProgressHUD.showSuccess(withStatus: "Password changed")
                SVProgressHUD.dismiss(withDelay: 1.5)
            } else {
                var ErrorString = "CONNECTION_ERROR".localized()
                if let sCode = response.response?.statusCode {
                    ErrorString = ErrorString + " \(sCode)"
                }
                ErrorString = ErrorString + " \(resultString)"
                SVProgressHUD.showError(withStatus: "\(ErrorString)")
                SVProgressHUD.dismiss(withDelay: 1.5)
            }
        }
        
    }
    
    func configureViews() {
        saveChangesButton.layer.cornerRadius = 12
        configureTextField(textField: passwordTextField)
        configureTextField(textField: confirmPasswordTextField)
    }
    
    func configureTextField(textField: UITextField) {
        
        // Configure the left image
        let leftImageView = UIImageView(image: UIImage(named: "Password"))
        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let leftView = UIView()
        leftView.translatesAutoresizingMaskIntoConstraints = false
        leftView.addSubview(leftImageView)
        
        textField.leftView = leftView
        textField.leftViewMode = .always
        
        NSLayoutConstraint.activate([
            leftView.widthAnchor.constraint(equalToConstant: 44),
            leftView.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        NSLayoutConstraint.activate([
            leftImageView.widthAnchor.constraint(equalToConstant: 20),
            leftImageView.heightAnchor.constraint(equalToConstant: 20),
            leftImageView.leadingAnchor.constraint(equalTo: leftView.leadingAnchor, constant: 16),
            leftImageView.topAnchor.constraint(equalTo: leftView.topAnchor, constant: 18)
        ])
        
        // Configure the right image
        let rightImageView = UIImageView(image: UIImage(named: "Show"))
        rightImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let rightView = UIView()
        rightView.translatesAutoresizingMaskIntoConstraints = false
        rightView.addSubview(rightImageView)

        textField.rightView = rightView
        textField.rightViewMode = .always
       
        
        NSLayoutConstraint.activate([
            rightView.widthAnchor.constraint(equalToConstant: 44),
            rightView.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        NSLayoutConstraint.activate([
            rightImageView.widthAnchor.constraint(equalToConstant: 20),
            rightImageView.heightAnchor.constraint(equalToConstant: 20),
            rightImageView.trailingAnchor.constraint(equalTo: rightView.trailingAnchor, constant: -16),
            rightImageView.topAnchor.constraint(equalTo: rightView.topAnchor, constant: 18)
        ])
    }
}
