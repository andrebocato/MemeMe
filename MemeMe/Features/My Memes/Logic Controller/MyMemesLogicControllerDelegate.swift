//
//  MyMemesLogicControllerDelegate.swift
//  MemeMe
//
//  Created by Andre Sanches Bocato on 03/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

/// Defines a communication strategy between the View Controller and its logic.
protocol MyMemesLogicControllerDelegate: AnyObject {
    
    /// Informs us that the memes list has updated.
    func memesListDidUpdate()
    
}
