//
//  HistoryTableViewCell.swift
//  OZINSHE
//
//  Created by Almat Alibekov on 21.09.2023.
//

import UIKit

class HistoryTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var historyLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var mainMovie = MainMovie()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = TopAlignedCollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24.0, bottom: 0, right: 24.0)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.estimatedItemSize.width = 184
        layout.estimatedItemSize.height = 156
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(mainMovie: MainMovie) {
   
        self.mainMovie = mainMovie
        
        collectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainMovie.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HistoryCollectionViewCell
        
        cell.setData(movie: mainMovie.movies[indexPath.row])
        
        return cell
    }


}
