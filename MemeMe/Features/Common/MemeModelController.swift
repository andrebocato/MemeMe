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
    
    // MARK: - Private Properties
    
    var memes = MemeDatabase.shared.memes // @TODO: remove singleton
    
    // MARK: - Public Properties
    
    var memesCount: Int {
        return memes.count
    }
    
    // MARK: - Public Functions
    
    /// Fetches a Meme from the database with a selected ID.
    ///
    /// - Parameter searchID: ID of the Meme being looked for.
    /// - Returns: The Meme resulting from the search.
    func meme(withID searchID: String) -> Meme? {
        return memes.filter { $0.id == searchID }.first
    }
    
    /// Creates a new 'Meme' object and persists it.
    ///
    /// - Parameter meme: Meme to be saved.
    func createNew(_ meme: Meme) {
        // @TODO: save to database
    }
    
    /// Searched a Meme using a given ID and deletes it from the database.
    ///
    /// - Parameter targetID: ID of the meme to be deleted.
    func deleteMeme(withID targetID: String) {
        let memeToDelete = meme(withID: targetID)
        // @TODO: delete from database
    }
    
}