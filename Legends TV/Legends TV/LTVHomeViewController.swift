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

    let jsonHandler = JSONHandler.defaultHandler
    @IBOutlet var savedVidBtnHeightCon: NSLayoutConstraint!
    var moviesArray : [[String : Any]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesArray = jsonHandler.parseMovieArray()
//        self.savedVidBtnHeightCon.constant = 0
//        self.savedVidsViewHeightCon.constant = 0

                // Do any additional setup after loading the view.
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
        return moviesArray!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LTVHomeCell", for: indexPath) as! LTVHomeTableCell
        
        let dict = moviesArray?[indexPath.row]
        print(dict!)
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
