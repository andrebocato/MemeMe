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
    
    // MARK: - Alerts
    
    /// Presents an alert with 'cancel' and 'destructive' actions.
    ///
    /// - Parameters:
    ///   - controller: View Controller where the alert will be presented.
    ///   - title: Title to be displayed in the alert.
    ///   - message: Optional message to be displayed in the alert.
    ///   - rightAction: Main action of the alert.
    ///   - completionHandler: Closure to be executed right after presenting the alert.
    static func presentAlert(inController controller: UIViewController?,
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
    
    /// Presents an alert with an alert message and an 'ok' button.
    ///
    /// - Parameters:
    ///   - controller: View Controller where the alert will be presented.
    ///   - title: Title to be displayed in the alert.
    ///   - message: Optional message to be displayed in the alert.
    ///   - completionHandler: Closure to be executed right after presenting the alert.
    static func presentAlert(inController controller: UIViewController?,
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
    
    // MARK: - Action Sheets
    
    /// Presents an action sheet with a set of custom actions.
    ///
    /// - Parameters:
    ///   - controller: View Controller where the action sheet will be presented.
    ///   - title: Optional title to be displayer in the action sheet.
    ///   - message: Optional message to be displayed in the action sheet.
    ///   - actions: An array of UIAlertActions to be added to the action sheet.
    static func presentActionSheet(inController controller: UIViewController?,
                                   title: String?,
                                   message: String?,
                                   actions: [UIAlertAction]) {
        
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        for action in actions {
            actionSheet.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            actionSheet.dismiss(animated: true, completion: nil)
        }
        actionSheet.addAction(cancelAction)
        
        DispatchQueue.main.async {
            controller?.present(actionSheet, animated: true, completion: nil)
        }
        
    }
}
