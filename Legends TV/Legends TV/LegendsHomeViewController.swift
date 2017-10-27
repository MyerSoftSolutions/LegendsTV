//
//  LegendsHomeViewController.swift
//  Legends TV
//
//  Created by Joel Myers on 10/24/17.
//  Copyright © 2017 Legends Media. All rights reserved.
//

import UIKit

class LegendsHomeViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var homeScrollView: UIScrollView!
    @IBOutlet weak var homePageControl: UIPageControl!
    @IBOutlet weak var slideUpBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slideUpBtn.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func swipeUp() {
        performSegue(withIdentifier: "DetailSegue", sender: self)
        
    }

}
