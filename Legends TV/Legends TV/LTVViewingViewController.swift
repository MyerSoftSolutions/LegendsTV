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

class LTVViewingViewController: UITableViewController, JWPlayerDelegate {
    
   
    @IBOutlet var videoPlayerView: UIView!
    var viewingDict : [String : AnyObject]?
    var videoPlayer : JWPlayerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(viewingDict!)
    }
    //MARK: TableViewDelegate Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 229
        case 1:
            return 158
        case 2:
            return 168
        case 3:
            return 44
        default:
            return 44
        }

    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideoPlayerCell", for: indexPath) as! LTVVideoPlayerTableViewCell
            
//            let config = JWConfig.init(contentURL: <#T##String!#>)
//            config.image = posterImage;
//            config.size = CGSizeMake(self.view.frame.size.width, self.view.frame.size.width);
//            config.autostart = YES;
//            config.repeat = YES;
//            
//            self.player = [[JWPlayerController alloc]initWithConfig:config];
//            self.player.forceLandscapeOnFullScreen = YES;
//            self.player.forceFullScreenOnLandscape = YES;
//            self.player.view.center = self.view.center;
//            self.player.delegate = self;

            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath) as! LTVDescriptionTableViewCell
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UpNextCell", for: indexPath) as! LTVUpNextTableViewCell
            
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
        // Dispose of any resources that can be recreated.
    }

}


