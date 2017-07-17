//
//  ViewController.swift
//  NEW_OKOMAZ
//
//  Created by Ally Mahmoud on 7/17/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    var returningClientInfo: Client?

    @IBOutlet weak var phoneNumber: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func createAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        //present the alert
        self.present(alert, animated: true, completion: nil)
        
        
        
    }
    
    


    @IBAction func SignUp(_ sender: Any) {
        //self.performSegue(withIdentifier: "navFromLogin", sender: nil)
        
//        let targetStoryboardName = "SignUpViewController"
//        let targetStoryboard = UIStoryboard(name: targetStoryboardName, bundle: nil)
//        if let targetViewController = targetStoryboard.instantiateInitialViewController() {
//            self.navigationController?.pushViewController(targetViewController, animated: true)
//        }

    }

    @IBAction func Login(_ sender: Any) {
        
        if !phoneNumber.hasText{
            //pop a notification alert if phone number field is empty
            createAlert(title: "ERROR!", message: "Phone number field cannot be empty")
            
        }
        else if !password.hasText{
            
            //pop a notification alert if password field is empty
            createAlert(title: "ERROR!", message: "Password field cannot be empty")
            
            
        }
        else if phoneNumber.text!.characters.count < 9{
            
            //pop a notification alert if password field is empty
            createAlert(title: "ERROR!", message: "Invalid phone number")
            
            
        }
            
        else {
            let clienTemp = Client(name: "Ally", phoneNumber: phoneNumber.text!, password: password.text!)
            self.returningClientInfo = clienTemp
            
            self.performSegue(withIdentifier: "navFromLogin", sender: nil)
            
            
            
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "navFromLogin"){
            
            let MyAccountTabViewController = segue.destination as! UITabBarController
            let mainViewController = MyAccountTabViewController.viewControllers?[0] as! UINavigationController
            
//                    let targetStoryboardName = "SignUpViewController"
//                    let targetStoryboard = UIStoryboard(name: targetStoryboardName, bundle: nil)
//                    if let targetViewController = targetStoryboard.instantiateInitialViewController() {
//                        self.navigationController?.pushViewController(targetViewController, animated: true)
//                    }
            
        
            
            
            let myAccountViewController = mainViewController.topViewController as! MyAccountViewController
            
            
            
            
            
            myAccountViewController.clientInfo = self.returningClientInfo
        }
    }

    
}

