//
//  MyAccountViewController.swift
//  NEW_OKOMAZ
//
//  Created by Ally Mahmoud on 7/17/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import UIKit

class MyAccountViewController: UIViewController {
    
    var clientInfo: Client!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("name: " + clientInfo.name!)
        print("phone: " + clientInfo.phoneNumber!)
        print("password: " + clientInfo.password!)
        print("country: " + clientInfo.country!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
