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
    
    private let logicController: DetailLogicController
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var imageView: UIImageView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createBarButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Initialization
    
    init(nibName nibNameOrNil: String?,
         bundle nibBundleOrNil: Bundle?,
         logicController: DetailLogicController) {
        self.logicController = logicController
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Configuration
    
    private func setupUI() {
        // @TODO: implement
    }
    
    private func createBarButtonItem() {
        let barButtonItem = UIBarButtonItem(image: UIImage(named: "edit"), style: .done, target: self, action: #selector(editBarButtonItemDidReceiveTouchUpInside(_:)))
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    private func showActionSheet() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let editAction = UIAlertAction(title: "Edit", style: .default) { (action) in
            // @TODO: send user to MemeEditorViewController
        }
        
        let shareAction = UIAlertAction(title: "Share...", style: .default) { (action) in
            // @TODO: implement
        }
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            // @TODO: implement
        }
        
        actionSheet.addAction(editAction)
        actionSheet.addAction(shareAction)
        actionSheet.addAction(deleteAction)
        
        DispatchQueue.main.async {
            self.present(actionSheet, animated: true, completion: nil)
        }
    }
    
    private func showActivityView() {
        let imageToShare: UIImage = generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [imageToShare], applicationActivities: [])
        activityViewController.completionWithItemsHandler = { [weak self] (activityType, completed, returnedItems, error) in
            if !completed { return }
            self?.saveImage()
        }
        
        DispatchQueue.main.async {
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    // MARK: - Actions
    
    @objc private func editBarButtonItemDidReceiveTouchUpInside(_ sender: UIBarButtonItem) {
        showActionSheet()
    }
    
}
