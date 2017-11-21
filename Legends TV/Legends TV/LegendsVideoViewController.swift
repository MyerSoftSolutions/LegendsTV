//
//  LegendsVideoViewController.swift
//  Legends TV
//
//  Created by Joel Myers on 11/7/17.
//  Copyright © 2017 Legends Media. All rights reserved.
//

import UIKit

class LegendsVideoViewController: UIViewController, JWPlayerDelegate {

    @IBOutlet weak var videoPlayerView: UIView!
    var jwConfig : JWConfig?
    var urlString : String?
    var viewingDict : [String : AnyObject]?
    var videoPlayer : JWPlayerController?
    var backBtn : UIBarButtonItem?
    var thumbnailString : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        createCustomBackButton("<-")
    }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeRight
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let dict = viewingDict?["content"] as! [String : Any]
        let dict2 = dict["videos"] as! [String : Any]
        let dict3 = dict2["video"] as! [String : Any]
        
        urlString = dict3["url"] as? String
        
        jwConfig = JWConfig.init(contentURL: urlString)
        jwConfig?.image = thumbnailString
        jwConfig?.size = videoPlayerView.frame.size
        jwConfig?.autostart = true
        jwConfig?.repeat = false
        
        videoPlayer = JWPlayerController.init(config: jwConfig, delegate: self)
        videoPlayer?.forceLandscapeOnFullScreen = true
        videoPlayer?.forceFullScreenOnLandscape = true
        videoPlayer?.view.center = videoPlayerView.center
        videoPlayerView.addSubview((videoPlayer?.view)!)
    }
    
    func createCustomBackButton(_ btnTitle: String) {
        backBtn = UIBarButtonItem(title: btnTitle, style: UIBarButtonItemStyle.done, target: self, action: #selector(LegendsVideoViewController.navigationBackButtonClicked))
//        backBtn = UIBarButtonItem(image: <#T##UIImage?#>, landscapeImagePhone: <#T##UIImage?#>, style: <#T##UIBarButtonItemStyle#>, target: <#T##Any?#>, action: <#T##Selector?#>)
        self.navigationItem.leftBarButtonItem = backBtn
    }
    
    func navigationBackButtonClicked() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
