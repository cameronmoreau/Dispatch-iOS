//
//  Vehicle.swift
//  hackdfw
//
//  Created by Cameron Moreau on 4/17/16.
//  Copyright © 2016 Mobi. All rights reserved.
//

import MapKit
import SwiftyJSON

class Vehicle {

    var id: String?
    var name: String?
    var type: String?
    var location: CLLocationCoordinate2D?
    var speed: CLLocationSpeed?
    
    init() {
    
    }
    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.name = json["name"].stringValue
        self.type = json["type"].stringValue
        
        if let speed = json["speed"].int {
            self.speed = CLLocationSpeed(speed)
        }
        
        let coords = json["loc"]["coordinates"]
        if let lat = coords[1].string, lng = coords[0].string {
            self.location = CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(lng)!)
        }
    }

}
