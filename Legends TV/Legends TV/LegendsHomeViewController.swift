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
                self.setupHomeScroll()
                activityView.stopAnimating()
            }
        }
    }
    
    //MARK: Method that loads LegendsListingVCs in the proper amount of moviearray.count and adds them to the homeScrollView contentView width by SCREEN_WIDTH * count for paging
    func setupHomeScroll() {
        
        if let arr = picsArray {
            homeScrollView.contentSize = CGSize(width: ScreenSize.SCREEN_WIDTH * CGFloat((moviesArray?.count)!), height: ScreenSize.SCREEN_HEIGHT)
            
            var count = 0
            
            for pic in picsArray! {
//                let listingView = LegendsListingView(frame: CGRect(x: ScreenSize.SCREEN_WIDTH * CGFloat(count), y: 0, width: ScreenSize.SCREEN_WIDTH, height: ScreenSize.SCREEN_HEIGHT))
                let listingView = LegendsListingView(frame: CGRect(x: ScreenSize.SCREEN_WIDTH * CGFloat(count), y: 0, width: ScreenSize.SCREEN_WIDTH, height: ScreenSize.SCREEN_HEIGHT))
                let img = arr[count]
                listingView.imageView.image = img
                homeScrollView.addSubview(listingView)
                count += 1
            }
            print(homeScrollView.contentSize)
            
        }
        

        
    }
    
    //MARK: ListingViewDelegate for when Play button tapped
    func playPressed() {
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func swipeUp() {
        performSegue(withIdentifier: "DetailSegue", sender: self)
    }

}
