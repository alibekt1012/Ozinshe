//
//  GenreAgeCollectionViewCell.swift
//  OZINSHE
//
//  Created by Almat Alibekov on 11.09.2023.
//

import UIKit
import SDWebImage

class GenreAgeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func setData(name: String, link: String) {
        posterImageView.layer.cornerRadius = 8
        posterImageView.sd_setImage(with: URL(string: link))
        
        nameLabel.text = name
    }
}
