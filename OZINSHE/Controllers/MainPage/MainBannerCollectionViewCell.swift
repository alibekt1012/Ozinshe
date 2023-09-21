//
//  MainBannerCollectionViewCell.swift
//  OZINSHE
//
//  Created by Almat Alibekov on 20.09.2023.
//

import UIKit
import SDWebImage

class MainBannerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var bannerCategoryView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bannerCategoryView.layer.cornerRadius = 8
        bannerImageView.layer.cornerRadius = 12
    }
    
    func setData(bannerMovie: BannerMovie) {
        
        bannerImageView.sd_setImage(with: URL(string: bannerMovie.link))
        
        if let category = bannerMovie.movie.categories.first {
            categoryLabel.text = category.name
        }
        
        titleLabel.text = bannerMovie.movie.name
        descriptionLabel.text = bannerMovie.movie.description
    }
    
}
