//
//  Incident.swift
//  hackdfw
//
//  Created by Cameron Moreau on 4/17/16.
//  Copyright © 2016 Mobi. All rights reserved.
//

import MapKit
import SwiftyJSON

class Incident {
    
    var id: String?
    var location: CLLocationCoordinate2D?
    var status: String?
    var type: String?
    
    init() {
    
    }
    
    init(json: JSON) {
        self.id = json["_id"].stringValue
        self.status = json["status"].stringValue
        self.type = json["type"].stringValue
        
        let coords = json["loc"]["coordinates"]
        if let lat = coords[1].string, lng = coords[0].string {
            self.location = CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(lng)!)
        }
    }

}