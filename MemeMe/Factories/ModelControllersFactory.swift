//
//  ModelControllersFactory.swift
//  MemeMe
//
//  Created by Andre Sanches Bocato on 02/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

/// This is an abstract factory for model controllers.
protocol ModelControllersFactoryProtocol {
    
    /// Creates a model controller from a Meme object.
    ///
    /// - Parameter meme: A Meme object.
    /// - Returns: A configured model controller.
    func createMemeModelController(meme: Meme) -> MemeModelController
    
}
