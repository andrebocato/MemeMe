//
//  MemeDatabaseProtocol.swift
//  MemeMe
//
//  Created by Andre Sanches Bocato on 07/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

protocol MemeDatabaseProtocol {
    
    /// Creates a new meme persisted object or updates its data on the database.
    ///
    /// - Parameter meme: A Meme.
    /// - Returns: Void.
    /// - Throws: A persistence error.
    func createOrUpdateMeme(meme: Meme) throws
    
    /// Fetches a meme oject from the database.
    ///
    /// - Parameter id: The id from the meme to be retrieved.
    /// - Returns: A Meme.
    /// - Throws: A persistence error.
    func fetchMeme(withID id: String) throws -> Meme?
    
    /// Fetches all object from the meme database.
    ///
    /// - Returns: An array of Memes.
    /// - Throws: A persistence error.
    func fetchAllMemes() throws -> [Meme]
    
    /// Deletes a specified object from the meme database.
    ///
    /// - Parameter id: The id from the meme to be deleted.
    /// - Returns: Void.
    /// - Throws: A persistence error.
    func deleteMeme(withID id: String) throws
    
    /// Deletes all memes in the database.
    ///
    /// - Returns: Void.
    /// - Throws: A persistence error.
    func deleteAllMemes() throws
    
}
