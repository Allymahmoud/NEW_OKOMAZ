//
//  MyAccountViewController.swift
//  NEW_OKOMAZ
//
//  Created by Ally Mahmoud on 7/17/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class MyAccountViewController: UIViewController {
    
    var clientInfo: Client = Client(name: "Ally", email: "@okomaz.co.tz", password: "okomaz1")
    
    
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var clientName: UILabel!
    @IBOutlet weak var Phone: UILabel!
    @IBOutlet weak var House: UILabel!
    @IBOutlet weak var Street: UILabel!
    @IBOutlet weak var Region: UILabel!
    @IBOutlet weak var Country: UILabel!
    @IBOutlet weak var nextPickupInfo: UILabel!
    @IBOutlet weak var Role: UILabel!

    @IBOutlet weak var clientProfilePicture: UIImageView!
    @IBOutlet weak var addressTextField: UILabel!
    @IBOutlet weak var PickupInfoTextField: UILabel!
    
    
    @IBOutlet weak var StaticPhoneField: UILabel!
    @IBOutlet weak var StaticHouseField: UILabel!
    @IBOutlet weak var StaticStreetField: UILabel!
    @IBOutlet weak var StaticRegionField: UILabel!
    @IBOutlet weak var StaticCountryField: UILabel!
    @IBOutlet weak var StaticNextPickupField: UILabel!
    @IBOutlet weak var StaticRole: UILabel!
    
    @IBOutlet weak var configureAccountMain: UIButton!
    
    @IBOutlet weak var configureAccountMember: UIButton!
    
    @IBOutlet weak var imageEditButton: UIButton!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference(fromURL: "https://okomaz-b3136.firebaseio.com/")
        
        configureUI()
        
        let accountEditButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.compose, target: self, action: #selector(editAccountinfoButton))
        self.navigationController?.navigationBar.topItem?.title = "My Account"
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = accountEditButton
        
                
        
        self.modifyButtonUI(Button: self.configureAccountMain)
        self.modifyButtonUI(Button: self.configureAccountMember)

       
        
        
       

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
         self.updateClientInfo()
        
    }
    

    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if clientInfo.role == "Main Household Contact" {
            if segue.identifier == "navToAccountConfiguration" {
                let AccountNavigationViewController = segue.destination as! UINavigationController
                let configureAccountViewController = AccountNavigationViewController.topViewController as! mainConfigureAccountViewController
                
                
                configureAccountViewController.clientInfo = self.clientInfo
            }
            
        }
        else{
            if segue.identifier == "navToAccountConfigurationMember" {
                let AccountNavigationViewController = segue.destination as! UINavigationController
                let configureAccountViewController = AccountNavigationViewController.topViewController as! memberConfigureAccountViewController
                
                
                configureAccountViewController.clientInfo = self.clientInfo
                
                
            }
            
        }
    }
    
    
    
    
    @IBAction func editAccountinfoButton(_ sender: Any) {
        var segueIdentifier: String?
        
        if clientInfo.role == "Household Member"{
            segueIdentifier = "navToAccountConfigurationMember"
        }
        else{
            segueIdentifier = "navToAccountConfiguration"
            
        }
        
        self.performSegue(withIdentifier: segueIdentifier!, sender: sender)
        
        
    }
    
    
    
    func configureUI(){
        self.clientProfilePicture.layer.cornerRadius = clientProfilePicture.frame.size.width/2
        self.clientProfilePicture.clipsToBounds = true
        
        
        self.addressTextField.layer.cornerRadius = self.addressTextField.frame.size.width/21
        self.addressTextField.clipsToBounds = true
        
        self.PickupInfoTextField.layer.cornerRadius = self.PickupInfoTextField.frame.size.width/21
        self.PickupInfoTextField.clipsToBounds = true
        
        
        self.clientName.layer.cornerRadius = self.clientName.frame.size.width/12
        self.clientName.clipsToBounds = true
        
        self.Phone.layer.cornerRadius = self.Phone.frame.size.width/12
        self.Phone.clipsToBounds = true
        
        self.House.layer.cornerRadius = self.House.frame.size.width/12
        self.House.clipsToBounds = true
        
        self.Street.layer.cornerRadius = self.Street.frame.size.width/12
        self.Street.clipsToBounds = true
        
        self.Region.layer.cornerRadius = self.Region.frame.size.width/12
        self.Region.clipsToBounds = true
        
        self.Country.layer.cornerRadius = self.Country.frame.size.width/12
        self.Country.clipsToBounds = true
        
        self.nextPickupInfo.layer.cornerRadius = self.nextPickupInfo.frame.size.width/12
        self.nextPickupInfo.clipsToBounds = true
        
        self.Role.layer.cornerRadius = self.Role.frame.size.width/12
        self.Role.clipsToBounds = true
        
        
        self.StaticPhoneField.layer.cornerRadius = self.StaticPhoneField.frame.size.width/6
        self.StaticPhoneField.clipsToBounds = true
        
        self.StaticStreetField.layer.cornerRadius = self.StaticStreetField.frame.size.width/6
        self.StaticStreetField.clipsToBounds = true
        
        self.StaticHouseField.layer.cornerRadius = self.StaticHouseField.frame.size.width/6
        self.StaticHouseField.clipsToBounds = true
        
        self.StaticCountryField.layer.cornerRadius = self.StaticCountryField.frame.size.width/6
        self.StaticCountryField.clipsToBounds = true
        
        self.StaticRegionField.layer.cornerRadius = self.StaticRegionField.frame.size.width/6
        self.StaticRegionField.clipsToBounds = true
        
        self.StaticNextPickupField.layer.cornerRadius = self.StaticNextPickupField.frame.size.width/6
        self.StaticNextPickupField.clipsToBounds = true
        
        self.StaticRole.layer.cornerRadius = self.StaticRole.frame.size.width/6
        self.StaticRole.clipsToBounds = true
    }
    
    func updateClientInfo(){
        print("User displayname :" + (Auth.auth().currentUser?.displayName!)! )
        let userID = Auth.auth().currentUser?.uid
        let titleRef = self.ref.child("users")
        titleRef.queryOrdered(byChild: userID!).observe(.childAdded, with: { snapshot in
            
            if let value = snapshot.value as? NSDictionary {
                
                print(value)
                print(value["role"] as! String)
                
                self.clientInfo.name = (value["name"] as! String)
                self.clientInfo.password = value["password"] as? String ?? ""
                self.clientInfo.email = value["email"] as? String ?? ""
                self.clientInfo.phoneNumber = value["phoneNumber"] as? String ?? ""
                
                self.clientInfo.houseNumber = value["houseNumber"] as? String ?? ""
                self.clientInfo.street = value["street"] as? String ?? ""
                self.clientInfo.region = value["region"] as? String ?? ""
                self.clientInfo.country = value["country"] as? String ?? ""
                
                self.clientInfo.uniqueDustbinSetCode = value["uniqueDustbinSetCode"] as? String ?? ""
                self.clientInfo.dateJoined = value["dateJoined"] as? String ?? ""
                self.clientInfo.lastContactTime = value["lastContactTime"] as? String ?? ""
                self.clientInfo.nextPickupDate = value["nextPickupDate"] as? String ?? ""
                self.clientInfo.pickUpStatus = value["pickUpStatus"] as? Bool
                
                self.clientInfo.phoneNumber_1 = value["phoneNumber_1"] as? String ?? ""
                self.clientInfo.phoneNumber_2 = value["phoneNumber_2"] as? String ?? ""
                self.clientInfo.phoneNumber_3 = value["phoneNumber_3"] as? String ?? ""
                self.clientInfo.phoneNumber_4 = value["phoneNumber_4"] as? String ?? ""
                
                self.clientInfo.role = value["role"] as? String ?? ""
                self.clientInfo.title = value["title"] as? String ?? ""
                self.clientInfo.Latitude = value["Latitude"] as? Double
                self.clientInfo.Longitude = value["Longitude"] as? Double
                self.clientInfo.PhotoUrl = value["PhotoUrl"] as? String ?? ""
                
                
                if self.clientInfo.houseNumber == "" {
                    self.disableUI(disable: true)
                    
                }
                else{
                    self.disableUI(disable: false)
                    
                }
                
                
                //display the updated info
                self.displayClientInfo()
                
            }
            else{
                print("ERROR__MYACCOUNTVIEWCONTROLLER- found the dictonary empty")
            }
        })
        
    }
    
    func displayClientInfo(){
        
 
            self.clientName.text = self.clientInfo.name
            self.Phone.text = self.clientInfo.email
            self.Country.text = self.clientInfo.country
            self.Role.text = self.clientInfo.role
            self.House.text = self.clientInfo.houseNumber
            self.Street.text = self.clientInfo.street
            self.Region.text = self.clientInfo.region
            
            self.nextPickupInfo.text = self.clientInfo.nextPickupDate
            
            
   
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func modifyButtonUI(Button: UIButton){
        Button.setTitleColor(UIColor.black, for: UIControlState.normal)
        Button.layer.borderColor = UIColor.black.cgColor
        Button.layer.cornerRadius = 5
        Button.layer.borderWidth = 1
        Button.titleLabel!.font = UIFont(name: "Avenir", size: 13)
        
        
    }

    @IBAction func configureAccountMainAction(_ sender: Any) {
        self.clientInfo.role = "Household Main Contact"
        
        self.performSegue(withIdentifier: "navToAccountConfiguration", sender: sender)
        
        
    }
    
    
    @IBAction func configureAccountMemberAction(_ sender: Any) {
        self.clientInfo.role = "Household Member"
        
        self.performSegue(withIdentifier: "navToAccountConfigurationMember", sender: sender)
        
    }
    
    func disableUI(disable: Bool){
        var alpha:CGFloat = 1.0; // if enabled alpha is 1
        if (disable) {
            alpha = 0.5; //add alpha to get disabled look
            
            self.imageEditButton.isEnabled = false;
            //self.accountEditButton.isEnabled = false;
            
            
            self.Phone.alpha = alpha
            self.StaticPhoneField.alpha = alpha
            
            self.clientName.alpha = alpha
            self.clientProfilePicture.alpha = alpha
            self.addressTextField.alpha = alpha
            self.PickupInfoTextField.alpha = alpha
            
            self.StaticNextPickupField.alpha = alpha
            self.nextPickupInfo.alpha = alpha
            
            self.StaticRole.alpha = alpha
            self.Role.alpha = alpha
            
            self.configureAccountMain.isHidden = false
            self.configureAccountMain.isEnabled = true
            self.configureAccountMember.isHidden = false
            self.configureAccountMember.isEnabled = true
            
            
            //self.StaticRole.isHidden = disable
            self.StaticStreetField.isHidden = disable
            self.StaticHouseField.isHidden = disable
            self.StaticRegionField.isHidden = disable
            //self.StaticNextPickupField.isHidden = disable
            self.StaticCountryField.isHidden = disable
            
            self.Country.isHidden = disable
            self.House.isHidden = disable
            self.Street.isHidden = disable
            self.Region.isHidden = disable
            
            
            
            
        }
        else{
            alpha = 1;
            
            self.Phone.alpha = alpha
            self.StaticPhoneField.alpha = alpha
            
            self.clientName.alpha = alpha
            self.clientProfilePicture.alpha = alpha
            self.addressTextField.alpha = alpha
            self.PickupInfoTextField.alpha = alpha
            
            self.StaticNextPickupField.alpha = alpha
            self.nextPickupInfo.alpha = alpha
            
            self.StaticRole.alpha = alpha
            self.Role.alpha = alpha
            
            
            self.imageEditButton.isEnabled = true;
            //self.accountEditButton.isEnabled = true;
            
            self.configureAccountMain.isHidden = true
            self.configureAccountMain.isEnabled = false
            self.configureAccountMember.isHidden = true
            self.configureAccountMember.isEnabled = false
            
            
            //self.StaticRole.isHidden = disable
            self.StaticStreetField.isHidden = disable
            self.StaticHouseField.isHidden = disable
            self.StaticRegionField.isHidden = disable
            //self.StaticNextPickupField.isHidden = disable
            self.StaticCountryField.isHidden = disable
            
            
            self.Country.isHidden = disable
            self.House.isHidden = disable
            self.Street.isHidden = disable
            self.Region.isHidden = disable
            
        }
        
        
        
    }


   

}
