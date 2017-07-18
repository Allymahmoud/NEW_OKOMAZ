//
//  Client.swift
//  NEW_OKOMAZ
//
//  Created by Ally Mahmoud on 7/17/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import Foundation
import Gloss


class Client{
    
    //core varibles
    var name: String?
    var phoneNumber: String?
    var email:String?
    var password: String?
    
    //address variables
    var houseNumber: String?
    var street: String?
    var region: String?
    var country: String?
    
    //access code
    var uniqueDustbinSetCode: String?
    
    //timing infomation
    var dateJoined: String?
    var lastContactTime: String?
    var nextPickupDate: String?
    var pickUpStatus: Bool?
    
    //house hold contact variables
    var phoneNumber_1: String?
    var phoneNumber_2: String?
    var phoneNumber_3: String?
    var phoneNumber_4: String?
    
    //previledge
    var role: String?
    
    
    required init?(json: JSON) {
        
        self.name = "name" <~~ json
        self.phoneNumber = "phoneNumber" <~~ json
        self.password = "password" <~~ json
        
        self.houseNumber = "houseNumber" <~~ json
        self.street = "street" <~~ json
        self.region = "region" <~~ json
        self.country = "country" <~~ json
        
        //access code
        self.uniqueDustbinSetCode = "uniqueDustbinSetCode" <~~ json
        
        //timing infomation
        self.dateJoined = "dateJoined" <~~ json
        self.lastContactTime = "lastContactTime" <~~ json
        self.nextPickupDate = "nextPickupDate" <~~ json
        self.pickUpStatus = "pickUpStatus" <~~ json
        
        //house hold contact variables
        self.phoneNumber_1 = "phoneNumber_1" <~~ json
        self.phoneNumber_2 = "phoneNumber_2" <~~ json
        self.phoneNumber_3 = "phoneNumber_3" <~~ json
        self.phoneNumber_4 = "phoneNumber_4" <~~ json
        
        //previledge
        self.role = "role" <~~ json
        
    }
    
    init(name: String, email: String, password: String) {
        self.name = name
        self.phoneNumber = ""
        self.email = email
        self.password = password
        
        self.houseNumber = ""
        self.street = ""
        self.region = ""
        self.country = "Tanzania"
        
        
        //access code
        self.uniqueDustbinSetCode = ""
        
        //timing infomation
        self.dateJoined = ""
        self.lastContactTime = ""
        self.nextPickupDate = "nil"
        self.pickUpStatus = false
        
        //house hold contact variables
        self.phoneNumber_1 = ""
        self.phoneNumber_2 = ""
        self.phoneNumber_3 = ""
        self.phoneNumber_4 = ""
        
        //previledge
        self.role = "client"
        
    }
    
    
    func toJSON() -> JSON? {
        return jsonify([
            "name" ~~> self.name,
            "phoneNumber" ~~> self.phoneNumber,
            "password" ~~> self.password,
            
            
            "houseNumber" ~~> self.houseNumber,
            "street" ~~> self.street,
            "region" ~~> self.region,
            "country" ~~> self.country,
            "uniqueDustbinSetCode" ~~> self.uniqueDustbinSetCode,
            "dateJoined" ~~> self.dateJoined,
            "lastContactTime" ~~> self.lastContactTime,
            "nextPickupDate" ~~> self.nextPickupDate,
            "pickUpStatus" ~~> self.pickUpStatus,
            
            
            //house hold contact variables
            "phoneNumber_1" ~~> self.phoneNumber_1,
            "phoneNumber_2" ~~> self.phoneNumber_2,
            "phoneNumber_3" ~~> self.phoneNumber_3,
            "phoneNumber_4" ~~> self.phoneNumber_4,
            
            //previledge
            "role" ~~> self.role
            
            
            
            ])
    }
    
    func BoolToString(b: Bool?)->String { return b?.description ?? "<None>"}
    func StringToBool(s: String?)->Bool{
        if s == "true" || s == "True" {
            return true
        }
        else{
            return false
        }
        
    }
    
    
}

