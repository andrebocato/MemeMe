//
//  ViewControllersFactory.swift
//  MemeMe
//
//  Created by Andre Sanches Bocato on 02/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation
import UIKit

/// This is an abstract factory for view controllers.
protocol ViewControllersFactoryProtocol {
    
    /// Creates a configured instance of a MyMemesViewController.
    ///
    /// - Parameter modelController: A MemeModelController to be use on the view controller.
    /// - Returns: A configured MyMemesViewController.
    func createMyMemesViewController(modelController: MemeModelController) -> MyMemesViewController
    
    /// Creates a configured instance of a MemeCreatorViewController.
    ///
    /// - Parameter originalImageData: Image data from the image picker to be worked on.
    /// - Parameter modelController: A MemeModelController to be use on the view controller.
    /// - Returns: A configured MemeCreatorViewController.
    func createMemeCreatorViewController(originalImageData: Data, modelController: MemeModelController) -> MemeCreatorViewController
        
    /// Creates a configured instance of a DetailViewController.
    ///
    /// - Parameter memedImageData: Image data from the created meme to be worked on.
    /// - Returns: A configured DetailViewController.
    func createDetailViewController(memedImageData: Data) -> DetailViewController
}
