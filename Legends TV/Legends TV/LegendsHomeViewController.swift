//
//  LegendsHomeViewController.swift
//  Legends TV
//
//  Created by Joel Myers on 10/24/17.
//  Copyright © 2017 Legends Media. All rights reserved.
//

import UIKit

class LegendsHomeViewController: UIViewController, UIScrollViewDelegate, ListingViewDelegate {

    @IBOutlet weak var homeScrollView: UIScrollView!
    @IBOutlet weak var homePageControl: UIPageControl!
    @IBOutlet weak var slideUpBtn: UIButton!
    
    let jsonHandler = JSONHandler.defaultHandler

    var moviesArray : [[String : Any]]?
    var picsArray : [UIImage]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slideUpBtn.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        
        moviesArray = jsonHandler.parseMovieArray()
        getData()
    }

    func getData() {
        
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityView.center = self.view.center
        activityView.startAnimating()
        view.addSubview(activityView)
        
        DispatchQueue.global().async {
            for viewing in self.moviesArray!{
                let dict = viewing["movie"] as AnyObject
                
                //get "thumbnail key string"
                let url = URL(string: "\(dict["thumbnail"] as! String)")
                if let data = try? Data(contentsOf: url!) {
                    self.picsArray?.append(UIImage(data: data)!)
                }
                
            }
            DispatchQueue.main.sync {
                //Create ScrollView of all Movie Pics
                activityView.stopAnimating()
            }
        }
    }
    
    //MARK: ListingViewDelegate for when Play button tapped
    func playTapped() {
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func swipeUp() {
        performSegue(withIdentifier: "DetailSegue", sender: self)
    }

}
