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
    
    /// Creates a configured TabBarController.
    ///
    /// - Returns: A configured UITabBarController.
    func createTabBarController() -> UITabBarController
    
    /// Creates a configured instance of a MemeEditorViewController.
    ///
    /// - Returns: A configured MemeEditorViewController.
    func createMemeEditorViewController() -> MemeEditorViewController
    
    /// Creates a configured instance of a MyMemesViewController.
    ///
    /// - Returns: A configured MyMemesViewController.
    func createMyMemesViewController() -> MyMemesViewController
    
    /// Creates a configured instance of a DetailViewController.
    ///
    /// - Returns: A configured DetailViewController.
    func createDetailViewController() -> DetailViewController
}
