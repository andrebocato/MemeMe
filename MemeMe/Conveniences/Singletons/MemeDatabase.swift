//
//  MemeDatabase.swift
//  MemeMe
//
//  Created by Andre Sanches Bocato on 03/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation
import UIKit

class MemeDatabase {
    
    // MARK: - Shared Instance
    
    static let shared = MemeDatabase()
    
    // MARK: - Properties
    
    var memes = [Meme]()
    
}
