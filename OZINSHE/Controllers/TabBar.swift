//
//  TabBar.swift
//  OZINSHE
//
//  Created by Almat Alibekov on 21.07.2023.
//

import UIKit

class TabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabImages()
        // Do any additional setup after loading the view.
    }

    func setTabImages() {
        let homeSelectedImage = UIImage(named: "HomeSelected")?.withRenderingMode(.alwaysOriginal)
        let searchSelectedImage = UIImage(named: "SearchSelected")?.withRenderingMode(.alwaysOriginal)
        let favoriteSelectedImage = UIImage(named: "favoriteSelected")?.withRenderingMode(.alwaysOriginal)
        let profileSelectedImage = UIImage(named: "ProfileSelected")?.withRenderingMode(.alwaysOriginal)
        
        tabBar.items?[0].selectedImage = homeSelectedImage
        tabBar.items?[1].selectedImage = searchSelectedImage
        tabBar.items?[2].selectedImage = favoriteSelectedImage
        tabBar.items?[3].selectedImage = profileSelectedImage
    }
    
    
}
