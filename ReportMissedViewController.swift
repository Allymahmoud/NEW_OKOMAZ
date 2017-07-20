//
//  ReportMissedViewController.swift
//  NEW_OKOMAZ
//
//  Created by ZhouYiqin on 7/20/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import UIKit

class ReportMissedViewController: UIViewController {

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
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ServiceList")
        self.navigationController?.pushViewController(vc!, animated: true)
        
        
    }
    
    @IBAction func PickerDate(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        strDate = dateFormatter.string(from: PickerDate.date)
        self.PickedDate.text = strDate
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
