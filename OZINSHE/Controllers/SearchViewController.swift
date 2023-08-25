//
//  SearchViewController.swift
//  OZINSHE
//
//  Created by Almat Alibekov on 21.08.2023.
//

import UIKit
import SwiftyJSON
import Alamofire
import SVProgressHUD

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)

        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }

            layoutAttribute.frame.origin.x = leftMargin

            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }

        return attributes
    }
}

class SearchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var SearchTextfield: TextFieldWithPadding!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableViewToLableConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableViewToCollectionViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var clearButton: UIButton!
    
    var categories: [Category] = []
    
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureViews()
        keyboardWhenTappedAround()
        downloadCategories()
    }
    
    func configureViews() {
        
        
        // Search
        SearchTextfield.padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        SearchTextfield.layer.cornerRadius = 12
        SearchTextfield.layer.borderWidth = 1
        SearchTextfield.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        
        searchButton.setBackgroundImage(UIImage(named: "SearchButtonHighlighted"), for: .highlighted)
        
        // Collection view
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16.0, left: 24.0, bottom: 16.0, right: 24.0)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 8
        layout.estimatedItemSize.width = 100
        collectionView.collectionViewLayout = layout
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let movieCellNib = UINib(nibName: "MovieCell", bundle: nil)
        tableView.register(movieCellNib, forCellReuseIdentifier: "MovieCell")
    }
    
    func keyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func TextFieldEditingDidBegin(_ sender: TextFieldWithPadding) {
        sender.layer.borderColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1.00).cgColor
    }
    
    
    @IBAction func TextFieldEditingDidEd(_ sender: TextFieldWithPadding) {
        sender.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
    }
    
    
    @IBAction func clearSearch(_ sender: Any) {
        SearchTextfield.text = ""
        textFieldVaueChanged(sender)
    }
    
    // MARK: - Download caregories
    func downloadCategories() {
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        
        AF.request(Urls.CATEGORIES_URL, method: .get, headers: headers).responseData { response in
                   
                   SVProgressHUD.dismiss()
                   var resultString = ""
                   if let data = response.data {
                       resultString = String(data: data, encoding: .utf8)!
                       print(resultString)
                   }
                   
                   if response.response?.statusCode == 200 {
                       let json = JSON(response.data!)
                       print("JSON: \(json)")
                       
                       if let array = json.array {
                           for item in array {
                               let category = Category(json: item)
                               self.categories.append(category)
                           }
                           self.collectionView.reloadData()
                       } else {
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
    
    //MARK: - CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let label = cell.viewWithTag(1001) as! UILabel
        label.text = categories[indexPath.row].name
        
        let backgroundview = cell.viewWithTag(1000)
        backgroundview!.layer.cornerRadius = 8
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let categoryMoviesVC = storyboard?.instantiateViewController(withIdentifier: "CategoryTableViewController") as! CategoryTableViewController
        
        categoryMoviesVC.categoryId = categories[indexPath.row].id
        
        navigationController?.pushViewController(categoryMoviesVC, animated: true)
    }
    
    
    // MARK: - TableView
    @IBAction func textFieldVaueChanged(_ sender: Any) {
        let searchText = SearchTextfield.text!
        
        if searchText.isEmpty {
            // Hide tableView
            tableViewToLableConstraint.priority = .defaultLow
            tableViewToCollectionViewConstraint.priority = .defaultHigh
            
            movies.removeAll()
            tableView.reloadData()
            
            titleLabel.text = "Санаттар"
            
            clearButton.isHidden = true
            
            return
        }
        
        // Показать tableview
        
        tableViewToLableConstraint.priority = .defaultHigh
        tableViewToCollectionViewConstraint.priority = .defaultLow
        titleLabel.text = "Іздеу нәтижелері"
        clearButton.isHidden = false
        
        // TODO: Search Movies
        
        movies = Array(repeating: Movie(), count: 5)
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieTableViewCell
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 152
    }
    
}
