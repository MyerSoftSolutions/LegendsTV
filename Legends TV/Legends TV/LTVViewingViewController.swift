//
//  LTVViewingViewController.swift
//  Legends TV
//
//  Created by Joel Myers on 5/27/17.
//  Copyright © 2017 Legends Media. All rights reserved.
//

import UIKit

let videoFile = "http://playertest.longtailvideo.com/adaptive/oceans/oceans.m3u8"
//#define posterImage @"http://d3el35u4qe4frz.cloudfront.net/bkaovAYt-480.jpg"

extension UITableViewController {
    func addNavigationIcon(){
        let logo = UIImage(named: "iTunesArtwork")
        let imageView = UIImageView(image:logo)
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 44)
        imageView.contentMode = .scaleAspectFit
        
//        let button =  UIButton(type: .custom)
//        button.setImage(imageView.image, for: .normal)
//        button.frame = CGRect(x: 0, y: 0, width: 50, height: 24)
//        button.addTarget(self, action: #selector(UITableViewController.homeNavigation), for: .touchUpInside)
        self.navigationItem.titleView = imageView
        
    }
    
    func homeNavigation () {
//        let vcArray = self.navigationController
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let mainViewController = storyboard.instantiateInitialViewController()
//        vcArray?.pushViewController(mainViewController!, animated: true)
    }

}

class LTVViewingViewController: UITableViewController, JWPlayerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
   
    @IBOutlet var videoPlayerView: UIView!
    var viewingDict : [String : AnyObject]?
    var videoPlayer : JWPlayerController?
    var jwConfig : JWConfig?
    var urlString : String?
    var thumbnailString : String?
    var durationString : String?
    var backBtn : UIBarButtonItem?
    var descCellBtn : UIButton?
    var descIsExtended = false
    
    var moviesArray : [[String : Any]] = []
    var picsArray : [UIImage]? = []
    
    var upNextCell : LTVUpNextTableViewCell?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        self.createCustomBackButton("< ")
        self.addNavigationIcon()
    }

    func createCustomBackButton(_ btnTitle: String) {
        backBtn = UIBarButtonItem(title: btnTitle, style: UIBarButtonItemStyle.done, target: self, action: #selector(LTVViewingViewController.navigationBackButtonClicked))
        self.navigationItem.leftBarButtonItem = backBtn
    }

    func navigationBackButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let dict = viewingDict?["content"] as! [String : Any]
        durationString = "\(Int(Int((dict["duration"] as? String)!)! / 60)) min "
        let dict2 = dict["videos"] as! [String : Any]
        let dict3 = dict2["video"] as! [String : Any]
        
        
        urlString = dict3["url"] as? String
        tableView.reloadData()
    }

    //MARK: TableViewDelegate Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    @IBAction func descCellToggled(_ sender: UIButton) {
        descIsExtended = !descIsExtended
        tableView.reloadRows(at: [IndexPath(item: 1, section: 0)], with: UITableViewRowAnimation.automatic)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 229
        case 1:
            return descIsExtended ? 330 : 174
        case 2:
            return 168
        case 3:
            return 53
        default:
            return 53
        }

    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideoPlayerCell", for: indexPath) as! LTVVideoPlayerTableViewCell
            
            jwConfig = JWConfig.init(contentURL: urlString)
            jwConfig?.image = thumbnailString
            jwConfig?.size = cell.videoPlayerView.frame.size
            jwConfig?.autostart = true
            jwConfig?.repeat = false
            
            videoPlayer = JWPlayerController.init(config: jwConfig, delegate: self)
            videoPlayer?.forceLandscapeOnFullScreen = true
            videoPlayer?.forceFullScreenOnLandscape = true
            videoPlayer?.view.center = cell.videoPlayerView.center
            cell.videoPlayerView.addSubview((videoPlayer?.view)!)

            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath) as! LTVDescriptionTableViewCell
            
            cell.titleLabel.text = viewingDict?["title"] as? String
            cell.durationLabel.text = durationString
            cell.descriptionTextView.text = viewingDict?["longDescription"] as? String
            if descIsExtended {
                cell.cellBtn?.transform = CGAffineTransform(rotationAngle: CGFloat((180.0 * Double.pi) / 180.0))
            }
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UpNextCell", for: indexPath) as! LTVUpNextTableViewCell
            cell.collectionView.reloadData()
            
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CopyrightCell", for: indexPath)
            
            return cell

        default:
            let cell = UITableViewCell()
            
            return cell
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(moviesArray)
        let dict = moviesArray[(indexPath.row)] as AnyObject
        viewingDict = dict["movie"] as? [String : AnyObject]
        
        let contentDict = viewingDict?["content"] as! [String : Any]
        durationString = "\(Int(Int((contentDict["duration"] as? String)!)! / 60)) min "
        let dict2 = contentDict["videos"] as! [String : Any]
        let dict3 = dict2["video"] as! [String : Any]
        
        
        urlString = dict3["url"] as? String

        tableView.reloadData()
    }

}


