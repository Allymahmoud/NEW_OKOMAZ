//
//  mainConfigureAccountViewController.swift
//  NEW_OKOMAZ
//
//  Created by Ally Mahmoud on 7/18/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import UIKit
import Firebase

class mainConfigureAccountViewController: UIViewController, UITextFieldDelegate {
    
    var clientInfo: Client?
    var ref: DatabaseReference!
    
    @IBOutlet weak var clientName: UITextField!
    @IBOutlet weak var clientHouse: UITextField!
    @IBOutlet weak var clientStreet: UITextField!
    @IBOutlet weak var clientRegion: UITextField!
    @IBOutlet weak var clientCountry: UITextField!
    
    @IBOutlet weak var clientPhone: UITextField!
    @IBOutlet weak var clientPhone1: UITextField!
    @IBOutlet weak var clientPhone2: UITextField!
    @IBOutlet weak var clientPhone3: UITextField!
    @IBOutlet weak var clientPhone4: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ref = Database.database().reference(fromURL: "https://okomaz-b3136.firebaseio.com/")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        displayClientInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func createAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        //present the alert
        self.present(alert, animated: true, completion: nil)
        
        
        
    }
    
    func displayClientInfo(){
        self.clientName.text = clientInfo?.name
        self.clientHouse.text = clientInfo?.houseNumber
        self.clientStreet.text = clientInfo?.street
        self.clientRegion.text = clientInfo?.region
        self.clientCountry.text = clientInfo?.country
        
        self.clientPhone.text = clientInfo?.email
        self.clientPhone1.text = clientInfo?.phoneNumber_1
        self.clientPhone2.text = clientInfo?.phoneNumber_2
        self.clientPhone3.text = clientInfo?.phoneNumber_3
        self.clientPhone4.text = clientInfo?.phoneNumber_4
    }
    
    
    
    //function to dismiss the keyboard when done editing
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        clientName.resignFirstResponder()
        
        
        return true
    }
    
    //function to dissmiss the keyboard when a part of the screen is touched
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        
        self.uploadClientInfoToDatabase()
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    private func uploadClientInfoToDatabase(){
        if self.clientName.text != self.clientInfo?.name && self.clientName.hasText  {
            
            //change the display name
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = self.clientName.text
            
            changeRequest?.commitChanges { (error) in
                
                if error != nil {
                    print("ERROR__MainConfigureAccountVIEWCONTROLLER_CHANGE_REQUEST" + (error?.localizedDescription)!)
                    
                }
                else{
                    //update name
                    self.setUserValueString(key: "name" , value: (self.clientName.text)!)
                }
                
                
            }
            
            
        }
        if self.clientHouse.text != self.clientInfo?.houseNumber && self.clientHouse.hasText  {
            self.setUserValueString(key: "houseNumber" , value: (self.clientHouse.text)!)
            
        }
        if self.clientPhone.text != self.clientInfo?.email  && clientPhone.hasText {
            
            Auth.auth().currentUser?.updateEmail(to: (self.clientPhone.text)!) { (error) in
                if error != nil {
                    print("ERROR__MainConfigureAccountVIEWCONTROLLER__CHANGE_REQUEST" + (error?.localizedDescription)!)
                    
                }
                else{
                    //update name
                    self.setUserValueString(key: "email", value: (self.clientPhone.text)!)
                    
                    
                }
            }
            
            //send verification email
            Auth.auth().currentUser?.sendEmailVerification { (error) in
                // ...
            }
            
            
            
        }
        
        if self.clientStreet.text != self.clientInfo?.street && self.clientStreet.hasText {
            self.setUserValueString(key: "street" , value: (self.clientStreet.text)!)
            
        }
        
        
        if self.clientRegion.text != self.clientInfo?.region && self.clientRegion.hasText  {
            self.setUserValueString(key: "region" , value: (self.clientRegion.text)!)
            
        }
        
        if self.clientCountry.text != self.clientInfo?.country && self.clientCountry.hasText  {
            self.setUserValueString(key: "country" , value: (self.clientCountry.text)!)
            
        }
        
        if self.clientPhone1.text != self.clientInfo?.phoneNumber_1 && self.clientPhone1.hasText  {
            self.setUserValueString(key: "phoneNumber_1" , value: (self.clientPhone1.text)!)
            
        }
        if self.clientPhone2.text != self.clientInfo?.phoneNumber_2 && self.clientPhone2.hasText  {
            self.setUserValueString(key: "phoneNumber_2" , value: (self.clientPhone2.text)!)
            
        }
        if self.clientPhone3.text != self.clientInfo?.phoneNumber_3 && self.clientPhone3.hasText  {
            self.setUserValueString(key: "phoneNumber_3" , value: (self.clientPhone3.text)!)
            
        }
        if self.clientPhone4.text != self.clientInfo?.phoneNumber_4 && self.clientPhone4.hasText  {
            self.setUserValueString(key: "phoneNumber_4" , value: (self.clientPhone4.text)!)
            
        }
        
        if  self.clientInfo?.role != "Main Household Contact"  {
            self.setUserValueString(key: "role" , value: "Main Household Contact")
            
        }
        
        
        //self.setUserValueString(key: "name" , value: (self.clientInfo?.name)!)
        //self.setUserValueString(key: "email" , value: (self.clientInfo?.email)!)
    }
    
    //helper function to modify Bool data in the database
    func setUserValueString(key:String, value: String){
        let user = Auth.auth().currentUser
        self.ref.child("users").child((user?.uid)!).child(key).setValue(value)
        
    }
    
     //helper function to modify Bool data in the database
    func setUserValueBool(key:String, value: Bool){
        let user = Auth.auth().currentUser
        self.ref.child("users").child((user?.uid)!).child(key).setValue(value)
        
    }
    
     //helper function to modify Double data in the database
    func setUserValueDouble(key:String, value: Double){
        let user = Auth.auth().currentUser
        self.ref.child("users").child((user?.uid)!).child(key).setValue(value)
        
    }
    

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
