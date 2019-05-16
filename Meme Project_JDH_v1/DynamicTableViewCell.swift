//
//  DynamicTableViewCell.swift
//  Meme Project_JDH_v2.1
//
//  Created by Do Hyung Joo on 12/5/19.
//  Copyright © 2019 Do Hyung Joo. All rights reserved.
//

import UIKit

class DynamicTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var dynamicTableImage: UIImageView!
    @IBOutlet weak var dynamicTableTextLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
