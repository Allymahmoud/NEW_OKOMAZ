//
//  ServicesTableViewController.swift
//  NEW_OKOMAZ
//
//  Created by Ally Mahmoud on 7/17/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import UIKit
import Firebase

class ServicesTableViewController: UITableViewController {

    var ref: DatabaseReference!
    var pickupdate: String = String()
    
    var listOfServices = ["Schedule a Pickup","Report Missed Pickup","New Products","Need Help?","Talk To Us","About Us"]
    var listofimageServices = ["SchedulePickup.png","MissedPickup.png", "NewProducts.png", "NeedHelp.png", "TalkToUs.png","AboutUs.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference(fromURL: "https://okomaz-b3136.firebaseio.com/")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(self.fetchNextPickupDate())
        
        
        self.tableView.reloadData()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.listofimageServices.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "serviceViewCell", for: indexPath) as! ServicesTableViewCell
        
        // Configure the cell...
        
        //        cell.textLabel?.text = activities[indexPath.row].name
        //        cell.detailTextLabel?.text = activities[indexPath.row].description
        
        
        
        cell.serviceButton.setTitle(listOfServices[indexPath.row], for: UIControlState.normal)
        cell.serviceButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        cell.serviceButton.layer.borderColor = UIColor.black.cgColor
        cell.serviceButton.layer.cornerRadius = 5
        cell.serviceButton.layer.borderWidth = 1
        cell.serviceButton.center.x = self.view.center.x
        cell.serviceButton.titleLabel!.font = UIFont(name: "Avenir", size: 15)
        
        if listOfServices[indexPath.row] == "Schedule a Pickup"{
            cell.datedescription.isHidden = false
            cell.datedescription.isHidden = false
            
            cell.datedescription.text = "Next pick up date"
            cell.date.text = self.pickupdate
            
        }
        else{
            cell.datedescription.isHidden = true
            cell.date.isHidden = true
        }
        
        
        
        cell.servicePicture.image = UIImage(named: listofimageServices[indexPath.row])

        return cell
    }
    
    override  func tableView(_ tableView: UITableView, didSelectRowAt
        indexPath: IndexPath){
        
        if indexPath.row == 0{
            
            self.performSegue(withIdentifier: "navTopickUp", sender: nil)
            /*
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PickUp")
            self.navigationController?.pushViewController(vc!, animated: true)
            */
            
        }
        
        if indexPath.row == 1{
            
         self.performSegue(withIdentifier: "navToReportpickUp", sender: nil)
            /*
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Missed")
            self.navigationController?.pushViewController(vc!, animated: true)
            */
            
        }
        
        
        
    
 
        
        
    }
    /*
    func fetchNextPickupDate()->String {
        
        var returndate: String = ""
        let userID = Auth.auth().currentUser?.uid
        let usernDislplayname = Auth.auth().currentUser?.displayName
        
        self.ref.child("users").child(userID!).observe(.value, with: { snapshot in
            
            print(snapshot.value as Any)
            if let value = snapshot.value as? NSDictionary {
                
                print (value)
                print("Date: " + (value["nextPickupDate"] as! String))
                
                returndate = (value["nextPickupDate"] as! String)
                
            }
            
        })
        return returndate
    }
    */
    
    func fetchNextPickupDate()->String {
        
        var returndate: String = "BILABILA"
        let userID = Auth.auth().currentUser?.uid
        let usernDislplayname = Auth.auth().currentUser?.displayName
        
        let titleRef = self.ref.child("users")
        titleRef.queryOrdered(byChild: userID!).observe(.childAdded, with: { snapshot in
            
            print(snapshot.value as Any)
            if let value = snapshot.value as? NSDictionary {
                
                print (value)
                if usernDislplayname == (value["name"] as! String){
                    print("Date: " + (value["nextPickupDate"] as! String))
                    
                    returndate = (value["nextPickupDate"] as! String)
                    self.pickupdate = (value["nextPickupDate"] as! String)
                    
                }
                
                
            }
            
        })
        return returndate
    }

    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
