//
//  MemeDatabaseLogicController.swift
//  MemeMe
//
//  Created by Andre Sanches Bocato on 06/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

/// Class specialized in controlling the memes database logic.
class MemeDatabaseLogicController {
    
    // MARK: - Aliases
    typealias MemeInfo = (topText: String?, bottomText: String?, originalImageData: Data, memedImageData: Data)
    
    // MARK: - Dependencies
    
    private let memeDatabase: MemeDatabaseProtocol
    
    // MARK: - Public Properties
    
    private(set) var memes: [Meme] = [] // this guy needs to be private, 'cause it's shouldn't be externally modified, just read.
    
    // MARK: - Initializatio
    
    init(memeDatabase: MemeDatabaseProtocol) {
        self.memeDatabase = memeDatabase
    }
    
    // MARK: - Public Functions
    
    /// Fetches a Meme from the database with a selected ID.
    ///
    /// - Parameter searchID: ID of the Meme being looked for.
    /// - Returns: The Meme resulting from the search.
    func fetchMeme(withID searchID: String) throws -> Meme? {
        do {
            return try memeDatabase.fetchMeme(withID: searchID)
        } catch {
            debugPrint(error)
            throw MemeDatabaseLogicControllerError.persistenceError(.failedToFind)
        }
    }
    
    func fetchAllMemes() throws {
        do {
            memes = try memeDatabase.fetchAllMemes()
        } catch {
            debugPrint(error)
            throw MemeDatabaseLogicControllerError.persistenceError(.failedToFetchData)
        }
    }

    /// Creates a new 'Meme' object and persists it.
    ///
    /// - Parameter meme: Meme to be saved.
    func createNewMeme(from info: MemeInfo) throws {
        do {
            let newMeme = Meme(topText: info.topText ?? "",
                               bottomText: info.bottomText ?? "",
                               originalImageData: info.originalImageData,
                               memedImageData: info.memedImageData,
                               id: UUID().uuidString)
            try memeDatabase.createOrUpdateMeme(meme: newMeme)
        } catch {
            debugPrint(error)
            throw MemeDatabaseLogicControllerError.persistenceError(.failedToPersist)
        }
    }
    
    /// Searched a Meme using a given ID and deletes it from the database.
    ///
    /// - Parameter targetID: ID of the meme to be deleted.
    func deleteMeme(withID targetID: String) throws {
        do {
            try memeDatabase.deleteMeme(withID: targetID)
        } catch {
            debugPrint(error)
            throw MemeDatabaseLogicControllerError.persistenceError(.failedToDelete)
        }
    }
    
    /// Deletes all memes from persistence.
    func deleteAllMemes() throws {
        do {
            try memeDatabase.deleteAllMemes()
        } catch {
            debugPrint(error)
            throw MemeDatabaseLogicControllerError.persistenceError(.nothingToDelete)
        }
    }

}
