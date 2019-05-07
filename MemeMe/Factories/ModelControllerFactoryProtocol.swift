//
//  MModelControllerFactoryProtocol.swift
//  MemeMe
//
//  Created by Andre Sanches Bocato on 07/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

/// This is an abstract factory for model controllers.
protocol ModelControllersFactoryProtocol {
    
    /// Creates a model controller for memes.
    ///
    /// - Parameter memes: An array of memes
    /// - Returns: A configured instance of a MemeModelController.
    func createMemeModelController(memes: [Meme]) -> MemeModelController
}
