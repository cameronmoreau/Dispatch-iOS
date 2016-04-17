//
//  User.swift
//  hackdfw
//
//  Created by Cameron Moreau on 4/17/16.
//  Copyright © 2016 Mobi. All rights reserved.
//

import Foundation

public enum UserType: String {
    case Police = "police"
    case Medic = "medic"
    case Fire = "fire"
}

class User {
    var id: String?
    var type: String?
    var name: String?
    
    init() {
        
    }
    
    init(type: UserType, name: String) {
        self.type = type.rawValue
        self.name = name
    }
    
    func isAuthenticated() -> Bool {
        if let id = self.id {
            if id != "" {
                return true
            }
        }
        return false
    }
    
    func loadStoredData() {
        let prefs = NSUserDefaults.standardUserDefaults()
        self.id = prefs.valueForKey("user_id") as? String
        self.type = prefs.valueForKey("user_type") as? String
        self.name = prefs.valueForKey("user_name") as? String
    }
    
    func clearStoredData() {
        let prefs = NSUserDefaults.standardUserDefaults()
        prefs.removeObjectForKey("user_id")
        prefs.removeObjectForKey("user_type")
        prefs.removeObjectForKey("user_name")
        prefs.synchronize()
    }
    
    func storeData() {
        let prefs = NSUserDefaults.standardUserDefaults()
        prefs.setValue(id, forKeyPath: "user_id")
        prefs.setValue(type, forKeyPath: "user_type")
        prefs.setValue(name, forKeyPath: "user_name")
        prefs.synchronize()
    }
}
