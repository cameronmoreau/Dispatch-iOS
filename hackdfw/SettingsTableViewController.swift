//
//  SettingsTableViewController.swift
//  hackdfw
//
//  Created by Cameron Moreau on 4/17/16.
//  Copyright © 2016 Mobi. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let logo = UIImage(named: "logo_dispatch")
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .ScaleAspectFit;
        imageView.frame = CGRectMake(0, 0, imageView.frame.width, 35)
        self.navigationItem.titleView = imageView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "LogoutSegue" {
            let user = User()
            user.clearStoredData()
        }
    }

}
