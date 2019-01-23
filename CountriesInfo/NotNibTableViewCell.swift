//
//  NotNibTableViewCell.swift
//  CountriesInfo
//
//  Created by Sridevi Panyam on 11/2/18.
//  Copyright © 2018 SP. All rights reserved.
//

import UIKit

class NotNibTableViewCell: UITableViewCell {
    //The identifier used to register and requeue cells of this class with a table view
    static let reuseIdentifier = "NotNibTableViewCell"
    
    @IBOutlet weak var countryNameLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    


}
