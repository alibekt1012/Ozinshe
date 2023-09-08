//
//  MovieCollectionViewCell.swift
//  OZINSHE
//
//  Created by Almat Alibekov on 08.09.2023.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    func setData(movie: Movie) {
        posterImageView.sd_setImage(with: URL(string: movie.poster_link))
        
        nameLabel.text = movie.name
        
        if let category = movie.categories.first {
            categoryLabel.text = category.name
        } else {
            categoryLabel.text = ""
        }
        
    }
}
