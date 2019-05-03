//
//  MemeModelController.swift
//  MemeMe
//
//  Created by Andre Sanches Bocato on 02/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

class MemeModelController {
        
    // MARK: - Private Properties
    
    var memes = [Meme]()
    var meme: Meme!
    
    // MARK: - Public Functions
    
    func createNew(_ meme: Meme) {
        memes.append(meme)
    }
    
}
