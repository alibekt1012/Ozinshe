//
//  HistoryCollectionViewCell.swift
//  OZINSHE
//
//  Created by Almat Alibekov on 21.09.2023.
//

import UIKit
import SDWebImage

class HistoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    func setData(movie: Movie) {
        posterImageView.layer.cornerRadius = 8
        
        posterImageView.sd_setImage(with: URL(string: movie.poster_link))
        
        nameLabel.text = movie.name
        
        if let genre = movie.genres.first {
            categoryLabel.text = genre.name
        } else {
            categoryLabel.text = ""
        }
    }
}
