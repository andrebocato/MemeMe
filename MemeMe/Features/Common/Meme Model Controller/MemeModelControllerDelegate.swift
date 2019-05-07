//
//  MemeModelControllerDelegate.swift
//  MemeMe
//
//  Created by Andre Sanches Bocato on 07/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

/// Defines a communiation strategy between the model holder and its logic.
protocol MemeModelControllerDelegate: AnyObject {
    
    /// Informs that the logic had a change of state.
    ///
    /// - Parameter newState: A new state to be rendered.
    func stateDidChange(_ newState: MemeModelControllerState)
}
