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
    /// - Parameter imageData: The image data to populate the image view.
    func configure(with imageData: Data) {
        imageView.image = UIImage(data: imageData)
    }
    
}
