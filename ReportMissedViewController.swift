//
//  ReportMissedViewController.swift
//  NEW_OKOMAZ
//
//  Created by ZhouYiqin on 7/20/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import UIKit

class ReportMissedViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var PickedDate: UILabel!
    @IBOutlet weak var Details: UITextView!
    @IBOutlet weak var PickerDate: UIDatePicker!
    
    var strDate: String!
    var strDetails: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func Submit(_ sender: Any) {
        strDetails = ""
        strDetails = Details.text
        
        self.dismiss(animated: true, completion: nil)
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ServiceList")
//        self.navigationController?.pushViewController(vc!, animated: true)
        
        
    }
    
    @IBAction func PickerDate(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        strDate = dateFormatter.string(from: PickerDate.date)
        self.PickedDate.text = strDate
    }
    
    
    
    @IBAction func Cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //function to dismiss the keyboard when done editing
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        Details.resignFirstResponder()
        
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
