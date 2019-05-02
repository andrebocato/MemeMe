//
//  AppDelegate+Factories.swift
//  MemeMe
//
//  Created by Andre Sanches Bocato on 02/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation
import UIKit

extension AppDelegate: ModelControllersFactoryProtocol {
    
    // MARK: - Model Controllers Factory
    
    func createMemeModelController(meme: Meme) -> MemeModelController {
        return MemeModelController(meme: meme)
    }
    
}

extension AppDelegate: ViewControllersFactoryProtocol {    
    
    // MARK: - View Controllers Factory
    
    func createTabBarController() -> UITabBarController {
        // Meme Editor
        let memeEditorViewController = createMemeEditorViewController()
        memeEditorViewController.title = "Meme Editor"
        memeEditorViewController.tabBarItem = UITabBarItem(title: "Meme Editor", image: UIImage(named: "editor"), tag: 0)
        let memeEditorNavigationController = UINavigationController(rootViewController: memeEditorViewController)

        // My Memes
        let myMemesViewController = createMyMemesViewController()
        myMemesViewController.title = "My Memes"
        myMemesViewController.tabBarItem = UITabBarItem(title: "My Memes", image: UIImage(named: "memes"), tag: 1)
        let myMemesNavigationController = UINavigationController(rootViewController: myMemesViewController)
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([memeEditorNavigationController, myMemesNavigationController], animated: false)
        
        return tabBarController
    }
    
    func createMemeEditorViewController() -> MemeEditorViewController {
        return MemeEditorViewController(nibName: MemeEditorViewController.className,
                                        bundle: Bundle(for: MemeEditorViewController.self))
    }
    
    func createMyMemesViewController() -> MyMemesViewController {
        let logicController = MyMemesLogicController(modelControllerFactory: self)
        
        return MyMemesViewController(nibName: MyMemesViewController.className,
                                     bundle: Bundle(for: MyMemesViewController.self),
                                     logicController: logicController)
    }
    
    func createDetailViewController(modelController: MemeModelController) -> DetailViewController {
        let logicController = DetailLogicController(modelController: modelController)
        
        return DetailViewController(nibName: DetailViewController.className,
                                    bundle: Bundle(for: DetailViewController.self),
                                    logicController: logicController)
    }
    
}
