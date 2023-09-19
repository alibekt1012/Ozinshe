//
//  MovieTableViewCell.swift
//  OZINSHE
//
//  Created by Almat Alibekov on 21.07.2023.
//

import UIKit
import SDWebImage

class MovieTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var playView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        posterImageView.layer.cornerRadius = 8
        playView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(movie: Movie) {
        nameLabel.text = movie.name
        yearLabel.text = "\(movie.year)"
        
        for item in movie.genres {
            yearLabel.text = yearLabel.text! + " • " + item.name
        }
        
        posterImageView.sd_setImage(with: URL(string: movie.poster_link))
        
    }

}
