//
//  MemeCell.swift
//  MemeMe
//
//  Created by Andre Sanches Bocato on 02/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

class MemeCell: UICollectionViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet private weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = 8.0
        }
    }
    
    // MARK: - Functions
    
    /// Configures the selected cell with an image.
    ///
    /// - Parameter image: The UIImage to be shown.
    func configure(with image: UIImage) {
        imageView.image = image
    }
    
}
