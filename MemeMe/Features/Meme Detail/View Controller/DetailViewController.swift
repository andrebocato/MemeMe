//
//  DetailViewController.swift
//  MemeMe
//
//  Created by Andre Sanches Bocato on 02/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - Dependencies
    
    private let memeModelController: MemeModelController
    
    // MARK: - Initialization
    
    init(nibName nibNameOrNil: String?,
                  bundle nibBundleOrNil: Bundle?,
                  memeModelController: MemeModelController) {
        self.memeModelController = memeModelController
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
