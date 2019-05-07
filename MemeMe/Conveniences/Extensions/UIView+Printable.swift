//
//  UIView+Printable.swift
//  MemeMe
//
//  Created by Andre Sanches Bocato on 07/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Protocols

protocol Printable { }

// MARK: - Printable View

extension UIView: Printable {
    
    /// Generates an image data by printing the visible view content.
    ///
    /// - Parameter bounds: GRect that determines the view area to be printed.
    /// - Returns: Image data of the view content.
    func asImageData(bounds: CGRect) -> Data? {
        let image = UIGraphicsImageRenderer(bounds: bounds).image(actions: { (rendererContext) in
            layer.render(in: rendererContext.cgContext)
        })
        return image.jpegData(compressionQuality: 0.7)
    }
    
}
