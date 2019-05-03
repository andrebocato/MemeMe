//
//  AppDelegate.swift
//  MemeMe
//
//  Created by Andre Sanches Bocato on 30/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let myMemesViewController = createMyMemesViewController()
        let rootViewController = UINavigationController(rootViewController: myMemesViewController)
        
        window = UIWindow()
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        
        return true
    }
    
}

