//
//  AppDelegate+Factories.swift
//  MemeMe
//
//  Created by Andre Sanches Bocato on 02/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation
import UIKit

extension AppDelegate: ViewControllersFactoryProtocol {

    // MARK: - View Controllers Factory
    
    func createMemeCreatorViewController(originalImageData: Data, logicController: MemeDatabaseLogicController) -> MemeCreatorViewController {
        return MemeCreatorViewController(nibName: MemeCreatorViewController.className,
                                         bundle: Bundle(for: MemeCreatorViewController.self),
                                         originalImageData: originalImageData,
                                         logicController: logicController)
    }
    
    func createMyMemesViewController(logicController: MemeDatabaseLogicController) -> MyMemesViewController {
        return MyMemesViewController(nibName: MyMemesViewController.className,
                                     bundle: Bundle(for: MyMemesViewController.self),
                                     viewControllersFactory: self,
                                     logicController: logicController)
    }
    
    func createDetailViewController(memedImageData: Data) -> DetailViewController {
        return DetailViewController(nibName: DetailViewController.className,  
                                    bundle: Bundle(for: DetailViewController.self),
                                    memedImageData: memedImageData)
    }
    
}
