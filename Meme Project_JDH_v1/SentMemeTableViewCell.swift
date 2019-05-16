//
//  SentMemeTableViewCell.swift
//  Meme Project_JDH_v2.1
//
//  Created by Do Hyung Joo on 15/5/19.
//  Copyright © 2019 Do Hyung Joo. All rights reserved.
//

import UIKit

class SentMemeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var tableViewCell: UIImageView!
    @IBOutlet weak var tableUILabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
