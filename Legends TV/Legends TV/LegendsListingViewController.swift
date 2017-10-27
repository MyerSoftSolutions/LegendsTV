//
//  LegendsListingViewController.swift
//  Legends TV
//
//  Created by Joel Myers on 10/27/17.
//  Copyright © 2017 Legends Media. All rights reserved.
//

import UIKit

protocol ListingViewDelegate {
    func playTapped()
}

class LegendsListingViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    var delegate : ListingViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func playTapped(_ sender: Any) {
        delegate?.playTapped()
    }

}
