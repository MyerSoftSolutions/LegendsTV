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
    
    @IBOutlet var imgView: UIImageView!

}

class LTVHomeViewController: UITableViewController/*UICollectionViewDataSource, UICollectionViewDelegate*/ {
//    @IBOutlet var savedVidsViewHeightCon: NSLayoutConstraint!

//    @IBOutlet var tableView: UITableView!
    let jsonHandler = JSONHandler.defaultHandler
//    @IBOutlet var savedVidBtnHeightCon: NSLayoutConstraint!
    var moviesArray : [[String : Any]]?
    var picsArray : [UIImage]? = []
    
//    @IBOutlet var savedVidButton: UIButton!
//    @IBOutlet var savedVidCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        
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
        tableView.addSubview(activityView)
        
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
                self.tableView.reloadData()
//                self.savedVidCollectionView.reloadData()
                activityView.stopAnimating()
            }
            
        }

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: UITableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if picsArray!.count > 0 {
            return picsArray!.count + 1
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row != picsArray!.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LTVHomeCell", for: indexPath) as! LTVHomeTableCell
            cell.imgView.image = picsArray?[indexPath.row]
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CopyrightCell", for: indexPath)
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == picsArray?.count {
            return 53
        } else {
            return 180
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    //MARK: PREPAREFORSEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewingSegue" {
            let vc = segue.destination as! LTVViewingViewController
            let cell = sender as! LTVHomeTableCell
            let idxPath = tableView.indexPath(for: cell)
            let dict = moviesArray?[(idxPath?.row)!] as AnyObject
            vc.viewingDict = dict["movie"] as! [String : AnyObject]?
            
            
        }
    }
    
    //MARK: UICollectionView Datasource Methods


//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return picsArray!.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SavedVidCell", for: indexPath) as! LTSavedVidCollectionCell
//        cell.imgView.image = picsArray?[indexPath.row]
//
//        return cell
//    }
    
    

}
