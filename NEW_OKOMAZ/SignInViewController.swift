//
//  ViewController.swift
//  NEW_OKOMAZ
//
//  Created by Ally Mahmoud on 7/17/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    var returningClientInfo: Client?
    
   
    var ref: DatabaseReference!


    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ref = Database.database().reference(fromURL: "https://okomaz-b3136.firebaseio.com/")
        
    }
    
    func createAlert(title: String, message: String, actionTitle: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        //present the alert
        self.present(alert, animated: true, completion: nil)
        
        
        
    }
    
    
    //function to dismiss the keyboard when done editing
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        email.resignFirstResponder()
        password.resignFirstResponder()
        return true
    }
    
    //function to dissmiss the keyboard when a part of the screen is touched
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    


    @IBAction func SignUp(_ sender: Any) {
        self.performSegue(withIdentifier: "navToSignUp", sender: nil)
        
//        let targetStoryboardName = "SignUpViewController"
//        let targetStoryboard = UIStoryboard(name: targetStoryboardName, bundle: nil)
//        if let targetViewController = targetStoryboard.instantiateInitialViewController() {
//            self.navigationController?.pushViewController(targetViewController, animated: true)
//        }

    }

    @IBAction func Login(_ sender: Any) {
        
        if !email.hasText{
            //pop a notification alert if phone number field is empty
            createAlert(title: "ERROR!", message: "Phone number field cannot be empty", actionTitle: "Cancel")
            
        }
        else if !password.hasText{
            
            //pop a notification alert if password field is empty
            createAlert(title: "ERROR!", message: "Password field cannot be empty", actionTitle: "Cancel")
            
        }
        else if email.text!.characters.count < 9{
            
            //pop a notification alert if password field is empty
            createAlert(title: "ERROR!", message: "Invalid phone number", actionTitle: "Cancel")
            
            
        }
            
        else {
            let clienTemp = Client(name: "Ally", email: email.text!, password: password.text!)
            self.returningClientInfo = clienTemp
            
            
            
            
            
            if self.email.text == "" || self.password.text == "" {
                
                //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
                self.createAlert(title: "Error!", message: "Please enter an email and password", actionTitle: "OK")
                
            
                
            } else {
                
                Auth.auth().signIn(withEmail: self.email.text!, password: self.password.text!) { (user, error) in
                    
                    if error == nil {
                        
                        if let user = Auth.auth().currentUser {
                            if !user.isEmailVerified{
                                let alertVC = UIAlertController(title: "Error", message: "Sorry. Your email address has not yet been verified. Do you want us to send another verification email to \(String(describing: self.email.text)).", preferredStyle: .alert)
                                let alertActionOkay = UIAlertAction(title: "Okay", style: .default) {
                                    (_) in
                                    user.sendEmailVerification(completion: nil)
                                }
                                let alertActionCancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
                                
                                alertVC.addAction(alertActionOkay)
                                alertVC.addAction(alertActionCancel)
                                self.present(alertVC, animated: true, completion: nil)
                                
                            } else {
                                
                                //Print into the console if successfully logged in
                                print ("Email verified. Signing in...")
                                
                                //Go to the HomeViewController if the login is sucessful
                                self.performSegue(withIdentifier: "navFromLogin", sender: nil)
                            }
                        }
                        
                        
                        
                        
                        
                        
                        
                    } else {
                        
                        //Tells the user that there is an error and then gets firebase to tell them the error
                        self.createAlert(title: "Error!", message: (error?.localizedDescription)!, actionTitle: "OK")
                        
                        
                    }
                }
            }
            
            
            
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "navFromLogin"){
            
            /*
            let MyAccountTabViewController = segue.destination as! UITabBarController
            let mainViewController = MyAccountTabViewController.viewControllers?[0] as! UINavigationController
            
//                    let targetStoryboardName = "SignUpViewController"
//                    let targetStoryboard = UIStoryboard(name: targetStoryboardName, bundle: nil)
//                    if let targetViewController = targetStoryboard.instantiateInitialViewController() {
//                        self.navigationController?.pushViewController(targetViewController, animated: true)
//                    }
            
        
            
            
            let myAccountViewController = mainViewController.topViewController as! MyAccountViewController
            
            
            
            
            
            myAccountViewController.clientInfo = self.returningClientInfo
            */
        }
    }

    
}

