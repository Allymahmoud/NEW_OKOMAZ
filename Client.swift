//
//  Client.swift
//  NEW_OKOMAZ
//
//  Created by Ally Mahmoud on 7/17/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import Foundation
import Gloss
import FirebaseAuth
import Firebase


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
    var title: String?
    
    //location
    var Longitude: Double?
    var Latitude: Double?
    
    //PhotoUrl
    var PhotoUrl: String?
    
    let ref = Database.database().reference(fromURL: "https://okomaz-b3136.firebaseio.com/")
    
    
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
        self.role = "Household Member"
        self.title = ""
        
        //location
        self.Longitude = 0
        self.Latitude = 0
        
        //url
        self.PhotoUrl = ""
        
        

        
    }
    init(){
        let user = Auth.auth().currentUser
        
        self.name = self.returnClientsAttributesString(childname: "users", userid: (user?.uid)!, attributeName: "name")
        self.phoneNumber = self.returnClientsAttributesString(childname: "users", userid: (user?.uid)!, attributeName: "phoneNumber")
        self.email = self.returnClientsAttributesString(childname: "users", userid: (user?.uid)!, attributeName: "email")
        self.password = self.returnClientsAttributesString(childname: "users", userid: (user?.uid)!, attributeName: "password")
        self.houseNumber = self.returnClientsAttributesString(childname: "users", userid: (user?.uid)!, attributeName: "houseNumber")
        self.street = self.returnClientsAttributesString(childname: "users", userid: (user?.uid)!, attributeName: "street")
        self.region = self.returnClientsAttributesString(childname: "users", userid: (user?.uid)!, attributeName: "region")
        self.country = self.returnClientsAttributesString(childname: "users", userid: (user?.uid)!, attributeName: "country")
        
        
        //access code
        self.uniqueDustbinSetCode = self.returnClientsAttributesString(childname: "users", userid: (user?.uid)!, attributeName: "uniqueDustbinSetCode")
        
        //timing infomation
        self.dateJoined = self.returnClientsAttributesString(childname: "users", userid: (user?.uid)!, attributeName: "datejoined")
        self.lastContactTime = self.returnClientsAttributesString(childname: "users", userid: (user?.uid)!, attributeName: "lastContactTime")
        self.nextPickupDate = self.returnClientsAttributesString(childname: "users", userid: (user?.uid)!, attributeName: "nextPickupDate")
        self.pickUpStatus = self.returnClientsAttributesBool(childname: "users", userid: (user?.uid)!, attributeName: "pickUpStatus")
        
        //house hold contact variables
        self.phoneNumber_1 = self.returnClientsAttributesString(childname: "users", userid: (user?.uid)!, attributeName: "phoneNumber_1")
        self.phoneNumber_2 = self.returnClientsAttributesString(childname: "users", userid: (user?.uid)!, attributeName: "phoneNumber_2")
        self.phoneNumber_3 = self.returnClientsAttributesString(childname: "users", userid: (user?.uid)!, attributeName: "phoneNumber_3")
        self.phoneNumber_4 = self.returnClientsAttributesString(childname: "users", userid: (user?.uid)!, attributeName: "phoneNumber_4")
        
        //previledge
        self.role = self.returnClientsAttributesString(childname: "users", userid: (user?.uid)!, attributeName: "role")
        self.title = self.returnClientsAttributesString(childname: "users", userid: (user?.uid)!, attributeName: "title")
        
        //location
        self.Longitude = self.returnClientsAttributesDouble(childname: "users", userid: (user?.uid)!, attributeName: "Longitude")
        self.Latitude = self.returnClientsAttributesDouble(childname: "users", userid: (user?.uid)!, attributeName: "Latitude")
        
        //url
        self.PhotoUrl = self.returnClientsAttributesString(childname: "users", userid: (user?.uid)!, attributeName: "PhotoUrl")
        

        
        
    }
    
    func returnClientsAttributesString(childname: String, userid: String, attributeName: String)-> String{
        return self.ref.child(childname).child(userid).value(forKey: attributeName) as! String
    
    }
    func returnClientsAttributesBool(childname: String, userid: String, attributeName: String)-> Bool{
        return self.ref.child(childname).child(userid).value(forKey: attributeName) as! Bool
        
    }
    func returnClientsAttributesDouble(childname: String, userid: String, attributeName: String)-> Double{
        return self.ref.child(childname).child(userid).value(forKey: attributeName) as! Double
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

