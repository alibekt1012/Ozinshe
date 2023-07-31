//
//  LanguageViewController.swift
//  OZINSHE
//
//  Created by Almat Alibekov on 28.07.2023.
//

import UIKit
import Localize_Swift

protocol LanguageProtocol {
    func languageDidChange()
}

class LanguageViewController: UIViewController, UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet var languageLabel: UILabel!
    @IBOutlet var lineView: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var backgroundView: UIView!
    
    var delegate: LanguageProtocol?
    
    let languageArray = [["English", "en"], ["Қазақша","kk"], ["Русский", "ru"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        backgroundView.layer.cornerRadius = 32
        backgroundView.clipsToBounds = true
        backgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        lineView.layer.cornerRadius = 2.5
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    @objc func dismissView() {
        dismiss(animated: true)
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: backgroundView))! {
            return false
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = languageArray[indexPath.row][0]
        let imageView = cell.viewWithTag(1001) as! UIImageView
        
        if Localize.currentLanguage() == languageArray[indexPath.row][1] {
            imageView.image = UIImage(named: "Check")
        } else {
            imageView.image = nil
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Localize.setCurrentLanguage(languageArray[indexPath.row][1])
        delegate?.languageDidChange()
        dismissView()
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
