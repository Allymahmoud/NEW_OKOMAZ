//
//  ServicesTableViewCell.swift
//  NEW_OKOMAZ
//
//  Created by Ally Mahmoud on 7/19/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import UIKit

class ServicesTableViewCell: UITableViewCell {

    @IBOutlet weak var servicePicture: UIImageView!
    
    @IBOutlet weak var serviceButton: UIButton!
    
    @IBOutlet weak var datedescription: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
