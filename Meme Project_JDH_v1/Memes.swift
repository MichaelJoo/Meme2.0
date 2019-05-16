//
//  Memes.swift
//  Meme Project_JDH_v2.1
//
//  Created by Do Hyung Joo on 17/2/19.
//  Copyright © 2019 Do Hyung Joo. All rights reserved.
//


import UIKit
import Photos

class Memes {
        var topText: String
        var bottomText: String
        var originalImage: UIImage?
        var memedImage: UIImage?
    
    init(topText: String, bottomText: String, originalImage: UIImage?, memedImage: UIImage?) {
        
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memedImage = memedImage
    }
}



