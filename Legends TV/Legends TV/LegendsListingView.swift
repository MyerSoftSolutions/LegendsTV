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
//        if case let self = super.init(coder: aDecoder)
//        super.init(coder: aDecoder)
        
        super.init(coder: aDecoder)
        xibSetup()
//        Bundle.main.loadNibNamed("LegendsListingView", owner: self, options: nil)
//        addSubview(self.topView)
        
        
    }
//    init() {
//        if self.subviews.count == 0 {
//            let bundle = Bundle(for: type(of: self))
//            let nib = UINib(nibName: "LegendsListingView", bundle: bundle)
//            let gcDateViewView : UIView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
//            gcDateViewView.frame = self.bounds
//            gcDateViewView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            addSubview(gcDateViewView)
//        }
//    }
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
