//
//  RealmMeme.swift
//  MemeMe
//
//  Created by Andre Sanches Bocato on 06/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation
import RealmSwift

class RealmMeme: Object {
    
    // MARK: - Properties
    
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var memeData: Data? = nil
    
    // MARK - Initialization
    
    /// Initializes a Meme persisted object from a Meme.
    ///
    /// - Parameter meme: A Meme.
    convenience init(meme: Meme) {
        self.init()
        self.id = "\(meme.id)"
        self.memeData = try? JSONEncoder().encode(meme)
    }
    
    // MARK: - Functions
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
