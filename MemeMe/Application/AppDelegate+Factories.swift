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
    
    func createMemeCreatorViewController(originalImage: UIImage, modelController: MemeModelController) -> MemeCreatorViewController {
        return MemeCreatorViewController(nibName: MemeCreatorViewController.className,
                                         bundle: Bundle(for: MemeCreatorViewController.self),
                                         originalImage: originalImage,
                                         modelController: modelController)
    }
    
    func createMyMemesViewController(modelController: MemeModelController) -> MyMemesViewController {
        return MyMemesViewController(nibName: MyMemesViewController.className,
                                     bundle: Bundle(for: MyMemesViewController.self),
                                     viewControllersFactory: self,
                                     modelController: modelController)
    }
    
    func createDetailViewController(memedImage: UIImage) -> DetailViewController {
        return DetailViewController(nibName: DetailViewController.className,
                                    bundle: Bundle(for: DetailViewController.self),
                                    memedImage: memedImage)
    }
    
}
