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
        // Initialization code
        self.collectionView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class LTNowPlayingCollectionCell : UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var durationLabel: UILabel!
    
}
