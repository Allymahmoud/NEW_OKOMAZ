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


class SignUpViewController: UIViewController {
    
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
            
            //send a verifictaion email
            Auth.auth().createUser(withEmail: self.clientEmail.text!, password: clientPassword.text!)
            { (user, error) in
                
                if error == nil {
                    print("You have successfully signed up")
                    //Goes to the Setup page which lets the user take a photo for their profile picture and also chose a username
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
