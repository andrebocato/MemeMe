//
//  MemeModelController.swift
//  MemeMe
//
//  Created by Andre Sanches Bocato on 06/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

/// Class specialized in controlling the model's CRUD.
class MemeModelController {
    
    // MARK: - Dependencies
    
    private let memeDatabase: MemeDatabaseProtocol
    
    // MARK: - Public Properties
    
    var memes: [Meme]
    weak var delegate: MemeModelControllerDelegate?
    
    // MARK: - Initializatio
    
    init(memeDatabase: MemeDatabaseProtocol,
         memes: [Meme]) {
        self.memeDatabase = memeDatabase
        self.memes = memes
    }
    
    // MARK: - Public Functions
    
    /// Fetches a Meme from the database with a selected ID.
    ///
    /// - Parameter searchID: ID of the Meme being looked for.
    /// - Returns: The Meme resulting from the search.
    func fetchMeme(withID searchID: String) -> Meme? {
        do {
            return try memeDatabase.fetchMeme(withID: searchID)
        } catch {
            debugPrint(error)
            delegate?.stateDidChange(.persistenceError(.failedToFind))
            return nil
        }
    }
    
    func fetchAllMemes() {
        do {
            memes = try memeDatabase.fetchAllMemes()
        } catch {
            debugPrint(error)
            delegate?.stateDidChange(.persistenceError(.failedToFetchData))
        }
    }

    /// Creates a new 'Meme' object and persists it.
    ///
    /// - Parameter meme: Meme to be saved.
    func createNew(_ meme: Meme) {
        do {
            try memeDatabase.createOrUpdateMeme(meme: meme)
        } catch {
            debugPrint(error)
            delegate?.stateDidChange(.persistenceError(.failedToPersist))
        }
    }
    
    /// Searched a Meme using a given ID and deletes it from the database.
    ///
    /// - Parameter targetID: ID of the meme to be deleted.
    func deleteMeme(withID targetID: String) {
        do {
            try memeDatabase.deleteMeme(withID: targetID)
        } catch {
            debugPrint(error)
            delegate?.stateDidChange(.persistenceError(.failedToDelete))
        }
    }
    
    /// Deletes all memes from persistence.
    func deleteAllMemes() {
        do {
            try memeDatabase.deleteAllMemes()
        } catch {
            debugPrint(error)
            delegate?.stateDidChange(.persistenceError(.nothingToDelete))
        }
    }

}
