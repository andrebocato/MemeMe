//
//  AlertHelper.swift
//  MemeMe
//
//  Created by Andre Sanches Bocato on 02/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

class AlertHelper {
    
    // MARK: - Initialization
    
    private init() {}
    
    // MARK: - Functions
    
    /// Presents an Alert Controller with cancel and destructive actions.
    ///
    /// - Parameters:
    ///   - controller: View Controller where the alert will be presented.
    ///   - title: Title to be displayed in the alert.
    ///   - message: Optional message to be displayed in the alert.
    ///   - rightAction: Main action of the alert.
    ///   - completionHandler: Closure to be executed right after presenting the alert.
    static func showAlert(inController controller: UIViewController?,
                          title: String,
                          message: String?,
                          rightAction: UIAlertAction,
                          completionHandler: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        })
        
        alert.addAction(cancelAction)
        alert.addAction(rightAction)
        
        DispatchQueue.main.async {
            controller?.present(alert, animated: true, completion: completionHandler)
        }
        
    }
    
    /// Presents an Alert Controller with an alert message.
    ///
    /// - Parameters:
    ///   - controller: View Controller where the alert will be presented.
    ///   - title: Title to be displayed in the alert.
    ///   - message: Optional message to be displayed in the alert.
    ///   - completionHandler: Closure to be executed right after presenting the alert.
    static func showAlert(inController controller: UIViewController?,
                          title: String,
                          message: String?,
                          completionHandler: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(okAction)
        
        DispatchQueue.main.async {
            controller?.present(alert, animated: true, completion: completionHandler)
        }
    }
}
