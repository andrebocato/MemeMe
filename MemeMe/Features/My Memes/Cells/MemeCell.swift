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

    // MARK: - Private Properties
    
    private var modelController: MemeModelController!
    
    // MARK: - Functions
    
    /// Configures the cell with data.
    ///
    /// - Parameter modelController: The model controller to get the data from.
    func configure(with modelController: MemeModelController) {
        self.modelController = modelController
        setupUI()
    }

    // MARK: - Private Functions
    
    private func setupUI() {
        imageView.image = modelController.meme.memedImage 
    }
    
}
