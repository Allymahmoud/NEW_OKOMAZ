//
//  memberConfigureAccountViewController.swift
//  NEW_OKOMAZ
//
//  Created by Ally Mahmoud on 7/18/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class memberConfigureAccountViewController: UIViewController, UITextFieldDelegate {
    
    var ref: DatabaseReference!
    var clientInfo: Client?


    @IBOutlet weak var clientName: UITextField!
    @IBOutlet weak var clientPhone: UITextField!
    @IBOutlet weak var clientMainPhone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ref = Database.database().reference(fromURL: "https://okomaz-b3136.firebaseio.com/")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.displayClientInfo()
        
    }
    
    func displayClientInfo(){
        self.clientName.text = clientInfo?.name
        
        
        self.clientPhone.text = clientInfo?.email
        self.clientMainPhone.text = clientInfo?.phoneNumber_1
        
    }
    
    func updateClientInfo(){
        clientInfo?.name = self.clientName.text
        
        clientInfo?.phoneNumber = self.clientPhone.text
        clientInfo?.phoneNumber_1 = self.clientMainPhone.text
        
        
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
        self.setUserValueString(key: "phoneNumber_1" , value: (self.clientInfo?.phoneNumber_1)!)
        self.setUserValueString(key: "role" , value: "Household Member")
        
        if  self.clientInfo?.role != "Household Member"  {
            print("YES")
            self.setUserValueString(key: "role" , value: "Household Member")
            
        }
        else{
            print("NO" + "********" + (self.clientInfo?.role)! )
        }
        //self.setUserValueString(key: "name" , value: (self.clientInfo?.name)!)
        //self.setUserValueString(key: "email" , value: (self.clientInfo?.email)!)
    }
    
    func setUserValueString(key:String, value: String){
        let user = Auth.auth().currentUser
        self.ref.child("users").child((user?.uid)!).child(key).setValue(value)
        
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

    

}
