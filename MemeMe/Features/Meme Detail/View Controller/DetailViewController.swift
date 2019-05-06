//
//  DetailViewController.swift
//  MemeMe
//
//  Created by Andre Sanches Bocato on 02/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//
// @TODO: implement export quality options

import UIKit

class DetailViewController: UIViewController {

    // MARK: - Dependencies
    
    private let memedImageData: Data
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var imageView: UIImageView! {
        didSet {
            imageView.image = UIImage(data: memedImageData)
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createBarButtonItem()
    }
    
    // MARK: - Initialization
    
    init(nibName nibNameOrNil: String?,
         bundle nibBundleOrNil: Bundle?,
         memedImageData: Data) {
        self.memedImageData = memedImageData
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Configuration
    
    private func createBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "share"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(shareBarButtonItemDidReceiveTouchUpInside(_:)))
    }
    
    private func showActivityView() {
        let imageToShare = UIImage(data: memedImageData)
        let activityViewController = UIActivityViewController(activityItems: [imageToShare!],
                                                              applicationActivities: [])
        
        DispatchQueue.main.async {
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    // MARK: - Actions
    
    @objc private func shareBarButtonItemDidReceiveTouchUpInside(_ sender: UIBarButtonItem) {
        showActivityView()
    }
    
}
