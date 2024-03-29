//
//  PersonalDataViewController.swift
//  OZINSHE
//
//  Created by Almat Alibekov on 02.08.2023.
//
 
import UIKit
import SVProgressHUD
import SwiftyJSON
import Alamofire

protocol PersonalDataDelegate: AnyObject {
    func personalDataChanged(updatedData: Profile)
}

class PersonalDataViewController: UIViewController {

    var userData: Profile?
    var delegate: PersonalDataDelegate?
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var phoneNumberTextField: UITextField!
    @IBOutlet var birthdayTextField: UITextField!
    @IBOutlet var saveChangesButton: UIButton!
    @IBOutlet var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        // Do any additional setup after loading the view.
        setupData()
        self.birthdayTextField.setInputViewDatePicker(target: self, selector: #selector(tapDone))
    }

    
    @IBAction func saveChanges(_ sender: Any) {
        
        SVProgressHUD.show()
        
        let email = nameTextField.text!
        let birthDate = birthdayTextField.text!
        let phoneNumber = phoneNumberTextField.text!
        let language = userData?.language
        
        let parameters = ["name" : email, "birthDate" : birthDate, "phoneNumber" : phoneNumber, "language" : language]
        
        print(parameters)
        
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        
        AF.request("http://api.ozinshe.com/core/V1/user/profile/", method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData { response in
            
            SVProgressHUD.dismiss()
            
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
            }
            
            if response.response?.statusCode == 200 {
                self.userData?.name = self.nameTextField.text!
                self.userData?.birthDate = self.birthdayTextField.text!
                self.userData?.phoneNumber = self.phoneNumberTextField.text!
                self.delegate?.personalDataChanged(updatedData: self.userData!)
                SVProgressHUD.showSuccess(withStatus: "Changes applied")
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
        navigationItem.title = "PERSONAL_DATA".localized()
        
    }
    
    func setupData() {
        
        guard let userData = userData else {
            return //
        }
        nameTextField.text = userData.name
        phoneNumberTextField.text = userData.phoneNumber
        birthdayTextField.text = userData.birthDate
        emailLabel.text = userData.user_email
    }
    
    @objc func tapDone() {
            if let datePicker = self.birthdayTextField.inputView as? UIDatePicker { // 2-1
                let dateformatter = DateFormatter() // 2-2
                dateformatter.dateFormat = "yyyy-MM-dd" // 2-3
                self.birthdayTextField.text = dateformatter.string(from: datePicker.date) //2-4
            }
            self.birthdayTextField.resignFirstResponder() // 2-5
        }
}
