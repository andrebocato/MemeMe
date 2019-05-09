//
//  MemeDatabaseLogicControllerState.swift
//  MemeMe
//
//  Created by Andre Sanches Bocato on 07/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

/// Defines the logic controller possible errors to be handled by the LogicController's holder.
///
/// - persistenceError: A persistence error.
/// - business: A business logic error.
enum MemeDatabaseLogicControllerError: Error {
    case persistenceError(PersistenceError)
    case businessError(Error) // @TODO: use if needed and create the error type
}
