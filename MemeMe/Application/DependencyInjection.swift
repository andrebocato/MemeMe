//
//  DependencyInjection.swift
//  MemeMe
//
//  Created by Andre Sanches Bocato on 06/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

/// Constants that are common for all files.
struct DependencyInjection {
    
    // MARK: - Initialization
    
    private init() { }
    
    // MARK: - Public Properties
    
    public static let memeDatabase = MemeDatabase()
}
