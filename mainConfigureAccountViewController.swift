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
    
    func configureClientInfo(){
        self.clientName.text = clientInfo?.name
        self.clientHouse.text = clientInfo?.houseNumber
        self.clientStreet.text = clientInfo?.street
        self.clientRegion.text = clientInfo?.region
        self.clientCountry.text = clientInfo?.country
        
        self.clientPhone.text = clientInfo?.phoneNumber
        self.clientPhone1.text = clientInfo?.phoneNumber_1
        self.clientPhone2.text = clientInfo?.phoneNumber_2
        self.clientPhone3.text = clientInfo?.phoneNumber_3
        self.clientPhone4.text = clientInfo?.phoneNumber_4
    }
    
    func updateClientInfo(){
        clientInfo?.name = self.clientName.text
        clientInfo?.houseNumber = self.clientHouse.text
        clientInfo?.street = self.clientStreet.text
        clientInfo?.region = self.clientRegion.text
        clientInfo?.country = self.clientCountry.text
        clientInfo?.phoneNumber = self.clientPhone.text
        clientInfo?.phoneNumber_1 = self.clientPhone1.text
        clientInfo?.phoneNumber_2 = self.clientPhone2.text
        clientInfo?.phoneNumber_3 = self.clientPhone3.text
        clientInfo?.phoneNumber_4 = self.clientPhone4.text
        clientInfo?.role = "Main Household Contact"
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
        updateClientInfo()
        
        uploadClientInfoToDatabase()
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    private func uploadClientInfoToDatabase(){
        if self.clientName.text != clientInfo?.name && clientName.hasText  {
            self.setUserValueString(key: "name" , value: (self.clientName.text)!)
            
        }
        if self.clientHouse.text != clientInfo?.houseNumber && clientHouse.hasText  {
            self.setUserValueString(key: "houseNumber" , value: (self.clientHouse.text)!)
            
        }
        if self.clientPhone1.text != clientInfo?.phoneNumber_1{
            self.setUserValueString(key: "phoneNumber_1" , value: (self.clientInfo?.phoneNumber_1)!)
            
        }
        if self.clientPhone1.text != clientInfo?.phoneNumber_1{
            self.setUserValueString(key: "phoneNumber_1" , value: (self.clientInfo?.phoneNumber_1)!)
            
        }
        if self.clientPhone1.text != clientInfo?.phoneNumber_1{
            self.setUserValueString(key: "phoneNumber_1" , value: (self.clientInfo?.phoneNumber_1)!)
            
        }
        if self.clientPhone1.text != clientInfo?.phoneNumber_1{
            self.setUserValueString(key: "phoneNumber_1" , value: (self.clientInfo?.phoneNumber_1)!)
            
        }
        if self.clientPhone1.text != clientInfo?.phoneNumber_1 && clientPhone1.hasText{
            self.setUserValueString(key: "phoneNumber_1" , value: (self.clientInfo?.phoneNumber_1)!)
            
        }
        if self.clientPhone1.text != clientInfo?.phoneNumber_1{
            self.setUserValueString(key: "phoneNumber_1" , value: (self.clientInfo?.phoneNumber_1)!)
            
        }
        if self.clientPhone1.text != clientInfo?.phoneNumber_1{
            self.setUserValueString(key: "phoneNumber_1" , value: (self.clientInfo?.phoneNumber_1)!)
            
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
