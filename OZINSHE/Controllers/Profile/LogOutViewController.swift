//
//  LogOutViewController.swift
//  OZINSHE
//
//  Created by Almat Alibekov on 02.08.2023.
//

import UIKit

class LogOutViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet var lineView: UIView!
    @IBOutlet var logOutLabel: UILabel!
    @IBOutlet var yesButton: UIButton!
    @IBOutlet var noButton: UIButton!
    @IBOutlet var backgroundView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        backgroundView.layer.cornerRadius = 32
        backgroundView.clipsToBounds = true
        backgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        yesButton.layer.cornerRadius = 12
        lineView.layer.cornerRadius = 2.5
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissView() {
        dismiss(animated: true)
        
    }

    @IBAction func logOut(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "accessToken")
        //SignInNavigationViewController
        
        let rootVC = storyboard?.instantiateViewController(identifier: "SignInNavigationViewController")
        
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVC
        appDelegate.window?.makeKeyAndVisible()
        
        
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
