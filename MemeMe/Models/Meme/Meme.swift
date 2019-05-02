//
//  Meme.swift
//  MemeMe
//
//  Created by Andre Sanches Bocato on 30/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

struct Meme {
    /// Text shown on the top.
    var topText: String
    /// Text shown on the bottom.
    var bottomText: String
    /// Image used to create the meme, with no text over it.
    var originalImage: UIImage
    /// Image created from the original image with text over it.
    var memedImage: UIImage
}
