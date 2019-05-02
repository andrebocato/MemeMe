//
//  MyMemesLogicController.swift
//  MemeMe
//
//  Created by Andre Sanches Bocato on 02/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

class MyMemesLogicController {
    
    // MARK: - Dependencies
    
    private let modelControllerFactory: ModelControllersFactoryProtocol
    
    // MARK: - Public Propeties
    
    var numberOfMemes: Int {
        return memes.count
    }
    
    // MARK: - Private Properties
    
    private var memes: [Meme] = []
    
    // MARK - Initialization
    
    init(modelControllerFactory: ModelControllersFactoryProtocol) {
        self.modelControllerFactory = modelControllerFactory
    }
    
    // MARK: - Public Functions
    
    /// Defines a model controller for an item.
    ///
    /// - Parameter item: The item to be worked on.
    /// - Returns: The controller to the model on the specified item.
    func modelController(for item: Int) -> MemeModelController {
        return modelControllerFactory.createMemeModelController(meme: memes[item])
    }
    
}
