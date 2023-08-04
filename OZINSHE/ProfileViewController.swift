//
//  ProfileViewController.swift
//  OZINSHE
//
//  Created by Almat Alibekov on 28.07.2023.
//

import UIKit
import Localize_Swift

class ProfileViewController: UIViewController, LanguageProtocol {
   
    @IBOutlet var myProfileLabel: UILabel!
    @IBOutlet var languageButton: UIButton!
    @IBOutlet var languageLabel: UILabel!
    @IBOutlet var personalDataButton: UIButton!
    @IBOutlet var personalDataLabel: UILabel!
    @IBOutlet var termsAndConditionsButton: UIButton!
    @IBOutlet var changePasswordButton: UIButton!
    @IBOutlet var notificationsButton: UIButton!
    @IBOutlet var darkModeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureViews()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? PersonalDataViewController {
            destinationVC.hidesBottomBarWhenPushed = true
        }
        if let destinationVC = segue.destination as? ChangePasswordViewController {
            destinationVC.hidesBottomBarWhenPushed = true
        }
    }
    
    func configureViews() {
        
        myProfileLabel.text = "MY_PROFILE".localized()
        languageButton.setTitle("LANGUAGE".localized(), for: .normal)
        personalDataButton.setTitle("PERSONAL_DATA".localized(), for: .normal)
        changePasswordButton.setTitle("CHANGE_PASSWORD".localized(), for: .normal)
        termsAndConditionsButton.setTitle("TERMS_AND_CONDITIONS".localized(), for: .normal)
        notificationsButton.setTitle("NOTIFICATIONS".localized(), for: .normal)
        darkModeButton.setTitle("DARK_MODE".localized(), for: .normal)
        
        
        
        if Localize.currentLanguage() == "ru" {
            languageLabel.text = "Русский"
            personalDataLabel.text = "Править"
            navigationItem.title = "Профиль"
        }
        if Localize.currentLanguage() == "kk" {
            languageLabel.text = "Қазақша"
            personalDataLabel.text = "Өңдеу"
            navigationItem.title = "Профиль"
        }
        if Localize.currentLanguage() == "en" {
            languageLabel.text = "English"
            personalDataLabel.text = "Edit"
            navigationItem.title = "Profile"
        }
        
    }
    
    @IBAction func logOut(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "LogOutViewController") as! LogOutViewController
        
        vc.modalPresentationStyle = .overFullScreen
        
        present(vc, animated: true)
        
    }
    @IBAction func showLanguage(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LanguageViewController") as! LanguageViewController
        
        vc.modalPresentationStyle = .overFullScreen
        
        vc.delegate = self
        
        present(vc, animated: true)
    }
    
    func languageDidChange() {
        configureViews() 
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
