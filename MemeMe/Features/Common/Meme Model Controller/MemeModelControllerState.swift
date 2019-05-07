//
//  MemeModelControllerState.swift
//  MemeMe
//
//  Created by Andre Sanches Bocato on 07/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

/// Defines the model controller states to be reflected on the model holder.
///
/// - persistenceError: A persistence error has occurred.
enum MemeModelControllerState {
    case persistenceError(PersistenceError)
}
