//
//  ActivityTableViewController.swift
//  Dispatch
//
//  Created by Cameron Moreau on 4/16/16.
//  Copyright © 2016 Mobi. All rights reserved.
//

import UIKit
import PusherSwift

class ActivityTableViewController: UITableViewController {
    
    var incidents = [Incident]()
    let api = ApiManager()
    
    let pusher = Pusher(key: "7c698f5c95d6b5063a7c")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logo = UIImage(named: "logo_dispatch")
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .ScaleAspectFit;
        imageView.frame = CGRectMake(0, 0, imageView.frame.width, 35)
        self.navigationItem.titleView = imageView
        
        self.view.backgroundColor = UIColor(netHex: 0xfafafa)
        self.tableView.backgroundColor = UIColor(netHex: 0xfafafa)
        
        let channel = pusher.subscribe("dispatch")
        channel.bind("location", callback: { (data: AnyObject?) -> Void in
            self.loadData()
        })
        
        pusher.connect()
        
        self.loadData()
    }
    
    func loadData() {
        api.getReports { (incidents) in
            if let incidents = incidents {
                self.incidents = incidents.reverse()
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return incidents.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ActivityTableViewCell

        cell.setIncident(incidents[indexPath.row])

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}
