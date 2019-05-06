//
//  Meme.swift
//  MemeMe
//
//  Created by Andre Sanches Bocato on 30/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

struct Meme: Codable {
    
    /// Text shown on the top.
    var topText: String
    
    /// Text shown on the bottom.
    var bottomText: String
    
    /// Image data used to create the meme, with no text over it.
    var originalImageData: Data
    
    /// Image data created from the original image with text over it.
    var memedImageData: Data
    
    /// Object identifier.
    var id: String
}

extension Meme: Equatable {
    
    static func == (lhs: Meme, rhs: Meme) -> Bool {
        return lhs.id == rhs.id
    }
    
    public static func != (lhs: Meme, rhs: Meme) -> Bool {
        return lhs.id != rhs.id
    }
    
}
