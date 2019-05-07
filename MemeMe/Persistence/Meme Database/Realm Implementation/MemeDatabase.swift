//
//  MemeDatabase.swift
//  MemeMe
//
//  Created by Andre Sanches Bocato on 07/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation
import RealmSwift

class MemeDatabase: MemeDatabaseProtocol {
    
    func createOrUpdateMeme(meme: Meme) throws {
        let realm = try Realm()
        
        let objectToPersist = RealmMeme(meme: meme)
        objectToPersist.id = "\(meme.id)"
        
        try realm.write {
            realm.add(objectToPersist, update: true)
        }
    }
    
    func fetchMeme(withID id: String) throws -> Meme? {
        let results = try fetchAllMemes()
        return results.filter { $0.id == id }.first
    }
    
    func fetchAllMemes() throws -> [Meme] {
        let realm = try Realm()
        
        return try realm.objects(RealmMeme.self)
            .compactMap({ (realmMeme) -> Meme? in
                guard let memeData = realmMeme.memeData else { return nil }
                return try JSONDecoder().decode(Meme.self, from: memeData)
            })
    }
    
    func deleteMeme(withID id: String) throws {
        let realm = try Realm()
        
        let primaryKey = "\(id)"
        let object = realm.object(ofType: RealmMeme.self, forPrimaryKey: primaryKey)
        if let object = object {
            try realm.write {
                realm.delete(object)
            }
        }
    }
    
    func deleteAllMemes() throws {
        let realm = try Realm()
        
        try realm.write {
            realm.deleteAll()
        }
    }
    
}

