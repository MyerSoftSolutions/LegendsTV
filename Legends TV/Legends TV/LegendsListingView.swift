//
//  LegendsListingView.swift
//  Legends TV
//
//  Created by Joel Myers on 10/29/17.
//  Copyright © 2017 Legends Media. All rights reserved.
//

import UIKit

protocol ListingViewDelegate {
    func playPressed()
}

class LegendsListingView: UIView {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    var delegate : ListingViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        xibSetup()

    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func playTapped(_ sender: Any) {
        delegate?.playPressed()
    }
    
}
