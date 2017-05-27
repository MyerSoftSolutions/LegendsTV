//
//  LTVHomeViewController.swift
//  Legends TV
//
//  Created by Joel Myers on 5/20/17.
//  Copyright © 2017 Legends Media. All rights reserved.
//

import UIKit

class LTVHomeTableCell : UITableViewCell {

    @IBOutlet var imgView: UIImageView!
    @IBOutlet var imgBottomCon: NSLayoutConstraint!
}

class LTSavedVidCollectionCell : UICollectionViewCell {

}

class LTVHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet var savedVidsViewHeightCon: NSLayoutConstraint!

    @IBOutlet var tableView: UITableView!
    let jsonHandler = JSONHandler.defaultHandler
    @IBOutlet var savedVidBtnHeightCon: NSLayoutConstraint!
    var moviesArray : [[String : Any]]?
    var picsArray : [UIImage]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesArray = jsonHandler.parseMovieArray()
        getData()
//        self.savedVidBtnHeightCon.constant = 0
//        self.savedVidsViewHeightCon.constant = 0

                // Do any additional setup after loading the view.
    }
    
    func getData() {
        
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityView.center = self.view.center
        activityView.startAnimating()
        self.view.addSubview(activityView)
        
        DispatchQueue.global().async {
            for viewing in self.moviesArray!{
                let dict = viewing["movie"] as! AnyObject
               
                //get "thumbnail key string"
                let url = URL(string: "\(dict["thumbnail"] as! String)")
                if let data = try? Data(contentsOf: url!) {
                    self.picsArray?.append(UIImage(data: data)!)
                }
//                for (_, element) in arr.enumerated() {
//                    let mem = element
//                    if mem.picFileString == nil {
//                        continue
//                    } else {
//                        let url = URL(string: "\(DataHandler.kPhotoURL)\(mem.picFileString!)")
//                        if let data = try? Data(contentsOf: url!) {
//                            mem.img = UIImage(data: data)
//                        }
//                    }
//                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                activityView.stopAnimating()
            }
        }

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITableView Datasource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return picsArray!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LTVHomeCell", for: indexPath) as! LTVHomeTableCell
        
        cell.imgView.image = picsArray?[indexPath.row]

        return cell
    }
    
    //MARK: UICollectionView Datasource Methods


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SavedVidCell", for: indexPath) as! LTSavedVidCollectionCell
        
        return cell
    }

}
