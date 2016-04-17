//
//  ActivityTableViewCell.swift
//  hackdfw
//
//  Created by Cameron Moreau on 4/17/16.
//  Copyright © 2016 Mobi. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var status: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setIncident(incident: Incident) {
        self.title.text = "Incident Reported"
        
        //icon
        switch incident.type! {
        case "medic":
            self.icon.image = UIImage(named: "ic_ambulance")
            break
        case "fire":
            self.icon.image = UIImage(named: "ic_fire_truck")
            break
        default:
            self.icon.image = UIImage(named: "ic_police")
            break
        }
        
        //status
        switch incident.status! {
        case "reported":
            self.status.text = "Reported"
            self.status.backgroundColor = UIColor(netHex: 0xd0021b)
            break
            
        case "dispatched":
            self.status.text = "Dispatched"
            self.status.backgroundColor = UIColor(netHex: 0xf8cf1c)
            break
            
        default:
            self.status.text = "Completed"
            self.status.backgroundColor = UIColor(netHex: 0x7ed321)
            break
        }
    }
    
}
