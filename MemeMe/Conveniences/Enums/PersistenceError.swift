//
//  PersistenceError.swift
//  MemeMe
//
//  Created by Andre Sanches Bocato on 07/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

enum PersistenceError: Error {
    case unknown
    case unexpected
    case failedToFind
    case failedToPersist
    case failedToFetchData
    case failedToDelete
    case nothingToDelete
    
    var code: Int {
        switch self {
        case .unknown:
            return 100
        case .unexpected:
            return 101
        case .failedToFind:
            return 102
        case .failedToPersist:
            return 103
        case .failedToFetchData:
            return 104
        case .failedToDelete:
            return 105
        case .nothingToDelete:
            return 106
        }
    }
    
    /// String that describes the error.
    var localizedDescription: String {
        switch self {
        case .unknown:
            return "An unknown error has occurred while persisting data."
        case .unexpected:
            return "An unexpected error has occurred while persisting data."
        case .failedToFind:
            return "Could not find persisted object."
        case .failedToPersist:
            return "Could not persist object."
        case .failedToFetchData:
            return "Could not fetch persisted data."
        case .failedToDelete:
            return "Could not delete object from local database."
        case .nothingToDelete:
            return "No objects to delete."
        }
    }
}
