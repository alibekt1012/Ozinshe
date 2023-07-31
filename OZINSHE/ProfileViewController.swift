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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureViews()
    }
    
    func configureViews() {
        
        myProfileLabel.text = "MY_PROFILE".localized()
        languageButton.setTitle("LANGUAGE".localized(), for: .normal)
        
        if Localize.currentLanguage() == "ru" {
            languageLabel.text = "Русский"
        }
        if Localize.currentLanguage() == "kk" {
            languageLabel.text = "Қазақша"
        }
        if Localize.currentLanguage() == "en" {
            languageLabel.text = "English"
        }
        
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
