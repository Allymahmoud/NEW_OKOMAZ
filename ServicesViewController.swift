//
//  ServicesViewController.swift
//  NEW_OKOMAZ
//
//  Created by Ally Mahmoud on 7/17/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import UIKit
import Firebase

class ServicesViewController: UIViewController {
    
    @IBOutlet weak var selectedDate: UILabel!
    @IBOutlet weak var myDatePicker: UIDatePicker!
    
    var ref: DatabaseReference!
    var strDate: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        ref = Database.database().reference(fromURL: "https://okomaz-b3136.firebaseio.com/")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func datePickerAction(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        strDate = dateFormatter.string(from: myDatePicker.date)
        self.selectedDate.text = strDate
    }

    @IBAction func AddingDate(_ sender: Any) {
        if strDate != nil{
            self.setUserValueString(key: "nextPickupDate", value: self.strDate)
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ServiceList")
            self.navigationController?.pushViewController(vc!, animated: true)
            //self.dismiss(animated: true, completion: nil)
            

            
        }
        
        
        
        
    }
    
    func setUserValueString(key:String, value: String){
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
