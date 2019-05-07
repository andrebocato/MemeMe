//
//  NSObject+Extension.swift
//  MemeMe
//
//  Created by Andre Sanches Bocato on 02/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

extension NSObject {
    
    /// String describing the class name.
    static var className: String {
        return String(describing: self)
    }
    
}
