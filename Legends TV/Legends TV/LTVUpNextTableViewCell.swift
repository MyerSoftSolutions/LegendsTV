//
//  LTVUpNextTableViewCell.swift
//  Legends TV
//
//  Created by Joel Myers on 5/27/17.
//  Copyright © 2017 Legends Media. All rights reserved.
//

import UIKit

class LTVUpNextTableViewCell: UITableViewCell {

    @IBOutlet var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.reloadData()
    }

    override func prepareForReuse() {
        collectionView.reloadData()
        collectionView.contentOffset.x = 0
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

class LTNowPlayingCollectionCell : UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var durationLabel: UILabel!
    
}
