//
//  ApiManager.swift
//  hackdfw
//
//  Created by Cameron Moreau on 4/17/16.
//  Copyright © 2016 Mobi. All rights reserved.
//

import Alamofire
import SwiftyJSON

class ApiManager {
    
    private let baseUrl = "https://mobihackdfw.herokuapp.com/"

    func register(user: User, completion: ((user: User?) -> ())) {
        let params = [
            "name": user.name!,
            "type": user.type!,
            "status": "active"
        ]
        
        Alamofire.request(.POST, "\(baseUrl)vehicle", parameters: params)
            .responseJSON { response in
                
                if let data = response.result.value {
                    let json = JSON(data)
                    let id = json["request_body"]["_id"].stringValue
                    
                    user.id = id
                    
                    completion(user: user)
                } else {
                    completion(user: nil)
                }
        }
    }
    
    func getVehicles(completion: ((vehicles: [Vehicle]?) -> ())) {
        Alamofire.request(.GET, "\(baseUrl)vehicle")
            .responseJSON { response in
                
                if let data = response.result.value {
                    var veh = [Vehicle]()
                    let json = JSON(data)
                    for obj in json.arrayValue {
                        veh.append(Vehicle(json: obj))
                    }
                    
                    completion(vehicles: veh)
                } else {
                    completion(vehicles: nil)
                }
        }
    }
    
    func getReports(completion: ((incidents: [Incident]?) -> ())) {
        Alamofire.request(.GET, "\(baseUrl)vehicle")
            .responseJSON { response in
                
                if let data = response.result.value {
                    var inc = [Incident]()
                    let json = JSON(data)
                    print(json)
                    for obj in json.arrayValue {
                        inc.append(Incident(json: obj))
                    }
                    
                    completion(incidents: inc)
                } else {
                    completion(incidents: nil)
                }
        }
    }
}
