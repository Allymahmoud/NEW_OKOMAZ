//
//  SignInViewController.swift
//  NEW_OKOMAZ
//
//  Created by Ally Mahmoud on 7/17/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    var clientInfo: Client!
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var clientEmail: UITextField!
    
    @IBOutlet weak var clientName: UITextField!
    
    @IBOutlet weak var clientPassword: UITextField!
    
    @IBOutlet weak var clientVerifyPassword: UITextField!
    
    
    
    
  
    func clickButton(){
        print("button click")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let goBackButton = UIBarButtonItem(title: "Log in", style: .plain, target: self, action: #selector(goBackToLoginPage(sender:)))
        
        //sign up page
        self.navigationController?.navigationBar.topItem?.title = "Sign Up"
        self.navigationController?.navigationBar.topItem?.leftBarButtonItem = goBackButton
        
        ref = Database.database().reference(fromURL: "https://okomaz-b3136.firebaseio.com/")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createAlert(title: String, message: String, actionTitle: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        //present the alert
        self.present(alert, animated: true, completion: nil)
        
        
        
    }
    
    func goBackToLoginPage(sender: UIBarButtonItem){
        self.performSegue(withIdentifier: "navFromSignUp", sender: nil)
        
    }
    
    

    
    
    @IBAction func Signup(_ sender: Any) {
        
        if self.clientEmail.text == "" {
            self.createAlert(title: "Error!", message: "Please enter your email and password", actionTitle: "OK")
            
            
        } else {
            
            let newClient = Client(name: self.clientName.text!, email: self.clientEmail.text!, password: self.clientPassword.text!)
            
            self.clientInfo = newClient
            
            
            
            //send a verifictaion email
            Auth.auth().createUser(withEmail: self.clientEmail.text!, password: clientPassword.text!)
            { (user, error) in
                
                if error == nil {
                    
                    print("You have successfully signed up")
                    //Goes to the Setup page which lets the user take a photo for their profile picture and also chose a username
                    
                    //change the display name
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = self.clientInfo.name
                    
                    changeRequest?.commitChanges { (error) in
                        
                        if error != nil {
                            print("ERROR_CHANGE_REQUEST__SIGNUPVIEWCONTROLLER" + (error?.localizedDescription)!)
                            
                        }
                        
                        
                    }
                    
                    //upload the client info to the database
                    self.uploadClientInfoToDatabase()
                    
                    
                    //send a verification email
                    Auth.auth().currentUser!.sendEmailVerification(completion: { (error) in
                        if error == nil{
                            
                            
                            self.performSegue(withIdentifier: "navFromSignUp", sender: nil)
                        }
                        else{
                            self.createAlert(title: "Error!", message: (error?.localizedDescription)!, actionTitle: "OK")
                            
                        }
                    
                    })
                    
                    
                    
                } else {
                    
                    self.createAlert(title: "Error!", message: (error?.localizedDescription)!, actionTitle: "OK")
                    
                }
            }
        }
        
        
        
        
    }
    
    private func uploadClientInfoToDatabase(){
        let user = Auth.auth().currentUser
        
        
        self.ref.child("users").child((user?.uid)!).child("name").setValue(self.clientInfo.name)
        self.ref.child("users").child((user?.uid)!).child("email").setValue(self.clientInfo.email)
        self.ref.child("users").child((user?.uid)!).child("password").setValue(self.clientInfo.password)
        self.ref.child("users").child((user?.uid)!).child("phoneNumber").setValue(self.clientInfo.phoneNumber)
        self.ref.child("users").child((user?.uid)!).child("houseNumber").setValue(self.clientInfo.houseNumber)
        self.ref.child("users").child((user?.uid)!).child("street").setValue(self.clientInfo.street)
        self.ref.child("users").child((user?.uid)!).child("region").setValue(self.clientInfo.region)
        self.ref.child("users").child((user?.uid)!).child("country").setValue(self.clientInfo.country)
        self.ref.child("users").child((user?.uid)!).child("uniqueDustbinSetCode").setValue(self.clientInfo.uniqueDustbinSetCode)
        self.ref.child("users").child((user?.uid)!).child("dateJoined").setValue(self.clientInfo.dateJoined)
        self.ref.child("users").child((user?.uid)!).child("lastContactTime").setValue(self.clientInfo.lastContactTime)
        self.ref.child("users").child((user?.uid)!).child("nextPickupDate").setValue(self.clientInfo.nextPickupDate)
        self.ref.child("users").child((user?.uid)!).child("pickUpStatus").setValue(self.clientInfo.pickUpStatus)
        self.ref.child("users").child((user?.uid)!).child("phoneNumber_1").setValue(self.clientInfo.phoneNumber_1)
        self.ref.child("users").child((user?.uid)!).child("phoneNumber_2").setValue(self.clientInfo.phoneNumber_2)
        self.ref.child("users").child((user?.uid)!).child("phoneNumber_3").setValue(self.clientInfo.phoneNumber_3)
        self.ref.child("users").child((user?.uid)!).child("phoneNumber_4").setValue(self.clientInfo.phoneNumber_4)
        self.ref.child("users").child((user?.uid)!).child("role").setValue(self.clientInfo.role)
        self.ref.child("users").child((user?.uid)!).child("title").setValue(self.clientInfo.title)
        self.ref.child("users").child((user?.uid)!).child("Latitude").setValue(self.clientInfo.Latitude)
       self.ref.child("users").child((user?.uid)!).child("Longitude").setValue(self.clientInfo.Longitude)
        self.ref.child("users").child((user?.uid)!).child("PhotoUrl").setValue(self.clientInfo.PhotoUrl)
    }
    
    
    //function to dismiss the keyboard when done editing
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        clientName.resignFirstResponder()
        clientPassword.resignFirstResponder()
        
        return true
    }
    
    //function to dissmiss the keyboard when a part of the screen is touched
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
