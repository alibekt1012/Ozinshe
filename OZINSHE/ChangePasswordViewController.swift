//
//  ChangePasswordViewController.swift
//  OZINSHE
//
//  Created by Almat Alibekov on 03.08.2023.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    
    
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        // Do any additional setup after loading the view.
    }
    
    
    func configureViews() {
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
    
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
