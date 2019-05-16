//
//MemeDetailViewController.swift
//  Meme Project_JDH_v2.1
//
//  Created by Do Hyung Joo on 5/5/19.
//  Copyright © 2019 Do Hyung Joo. All rights reserved.
//

import UIKit

// MARK: - MemeDetailViewController: UIViewController

class MemeDetailViewController: UIViewController {
    
    // MARK: Properties
    
    var meme: Memes!
    
    // MARK: Outlets
    
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    
    
    // MARK: Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.detailLabel.text = self.meme.topText
        
        self.tabBarController?.tabBar.isHidden = true
        
        self.detailImageView!.image = self.meme.memedImage
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
}
