//
//  MovieTableViewCell.swift
//  OZINSHE
//
//  Created by Almat Alibekov on 21.07.2023.
//

import UIKit

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

}
