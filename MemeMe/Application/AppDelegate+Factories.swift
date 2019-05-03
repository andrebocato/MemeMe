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
        return MemeModelController(/*  */)
    }
    
}

extension AppDelegate: ViewControllersFactoryProtocol { 

    // MARK: - View Controllers Factory
    
    func createMemeCreatorViewController(originalImage: UIImage) -> MemeCreatorViewController {
        return MemeCreatorViewController(nibName: MemeCreatorViewController.className,
                                         bundle: Bundle(for: MemeCreatorViewController.self),
                                         originalImage: originalImage)
    }
    
    func createMyMemesViewController() -> MyMemesViewController {
        let logicController = MyMemesLogicController(modelControllerFactory: self)
        return MyMemesViewController(nibName: MyMemesViewController.className,
                                     bundle: Bundle(for: MyMemesViewController.self),
                                     logicController: logicController,
                                     viewControllersFactory: self)
    }
    
    func createDetailViewController(modelController: MemeModelController) -> DetailViewController {
        let logicController = DetailLogicController(modelController: modelController)
        
        return DetailViewController(nibName: DetailViewController.className,
                                    bundle: Bundle(for: DetailViewController.self),
                                    logicController: logicController)
    }
    
}
