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

class LTVHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource/* UICollectionViewDataSource, UICollectionViewDelegate*/ {
    @IBOutlet var savedVidsViewHeightCon: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LTVHomeCell", for: indexPath) as! LTVHomeTableCell
        
        return cell
    }


}
