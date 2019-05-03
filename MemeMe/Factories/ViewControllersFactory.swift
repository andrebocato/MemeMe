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
    /// - Returns: A configured MyMemesViewController.
    func createMyMemesViewController() -> MyMemesViewController
    
    /// Creates a configured instance of a MemeCreatorViewController.
    ///
    /// - Parameter originalImage: Image from the image picker to be worked on.
    /// - Returns: A configured MemeCreatorViewController.
    func createMemeCreatorViewController(originalImage: UIImage) -> MemeCreatorViewController
    
    /// Creates a configured instance of a MemeEditorViewController.
    ///
    /// - Returns: A configured MemeEditorViewController.
    func createMemeEditorViewController() -> MemeEditorViewController
    
    /// Creates a configured instance of a DetailViewController.
    ///
    /// - Parameter modelController: A model controller for a Meme object.
    /// - Returns: A configured DetailViewController.
    func createDetailViewController(modelController: MemeModelController) -> DetailViewController
}
