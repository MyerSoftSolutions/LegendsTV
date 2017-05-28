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

class LTVHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet var savedVidsViewHeightCon: NSLayoutConstraint!

    @IBOutlet var tableView: UITableView!
    let jsonHandler = JSONHandler.defaultHandler
    @IBOutlet var savedVidBtnHeightCon: NSLayoutConstraint!
    var moviesArray : [[String : Any]]?
    var picsArray : [UIImage]? = []
    
    @IBOutlet var savedVidButton: UIButton!
    @IBOutlet var savedVidCollectionView: UICollectionView!
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
        self.tableView.addSubview(activityView)
        
        DispatchQueue.global().async {
            for viewing in self.moviesArray!{
                print(viewing)
                let dict = viewing["movie"] as AnyObject
                print(dict)
               
                //get "thumbnail key string"
                let url = URL(string: "\(dict["thumbnail"] as! String)")
                if let data = try? Data(contentsOf: url!) {
                    self.picsArray?.append(UIImage(data: data)!)
                }

            }
            DispatchQueue.main.sync {
                self.tableView.reloadData()
                self.savedVidCollectionView.reloadData()
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


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picsArray!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SavedVidCell", for: indexPath) as! LTSavedVidCollectionCell
        cell.imgView.image = picsArray?[indexPath.row]

        return cell
    }
    
    

}
