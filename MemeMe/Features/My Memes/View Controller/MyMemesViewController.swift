//
//  MyMemesViewController.swift
//  MemeMe
//
//  Created by Andre Sanches Bocato on 02/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

class MyMemesViewController: UIViewController {

    // MARK: - Dependencies
    
    private let logicController: MyMemesLogicController
    private let viewControllersFactory: ViewControllersFactoryProtocol
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
    
    // MARK: - Properties
    
    private let minimumSpacing: CGFloat = 3
    private let imagePicker = UIImagePickerController()
    
    // MARK: - Initialization

    init(nibName nibNameOrNil: String?,
         bundle nibBundleOrNil: Bundle?,
         logicController: MyMemesLogicController) {
        // @TODO: implement dependency injection
        self.logicController = logicController
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self as? (UIImagePickerControllerDelegate & UINavigationControllerDelegate)
        registerCollectionViewCells()
        createBarButtonItem()
    }
    
    // MARK: - UI Configuration
    
    private func registerCollectionViewCells() {
        let bundle = Bundle(for: MemeCell.self)
        let className = MemeCell.className
        let cellNib = UINib(nibName: className, bundle: bundle)
        collectionView.register(cellNib, forCellWithReuseIdentifier: className)
    }
    
    private func createBarButtonItem() {
        let barButtonItem = UIBarButtonItem(image: UIImage(named: "add"), style: .done, target: self, action: #selector(addNewMemeBarButtonItemDidReceiveTouchUpInside(_:)))
        navigationItem.leftBarButtonItem = barButtonItem
    }
    
    private func showActionSheet() {
        let actionSheet = UIAlertController(title: "Select an image source", message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] (action) in
            self?.presentImagePicker(.camera)
        }
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { [weak self] (action) in
            self?.presentImagePicker(.photoLibrary)
        }
        
        let randomAction = UIAlertAction(title: "Random image", style: .default) { (action) in
            // @TODO: GET image from an API
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(photoLibraryAction)
        actionSheet.addAction(randomAction)
        actionSheet.addAction(cancelAction)
        
        DispatchQueue.main.async {
            self.present(actionSheet, animated: true, completion: nil)
        }
    }
    
    private func presentImagePicker(_ sourceType: UIImagePickerController.SourceType) {
        imagePicker.sourceType = sourceType
        
        DispatchQueue.main.async {
            self.present(self.imagePicker, animated: true, completion: nil)
        }
    }
    
    // MARK: - Actions
    
    @objc private func addNewMemeBarButtonItemDidReceiveTouchUpInside(_ sende: UIBarButtonItem) {
        showActionSheet()
    }
    
}

// MARK: - Extensions

extension MyMemesViewController: UICollectionViewDataSource {
    
    // MARK: - Collection View Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfMemes = logicController.numberOfMemes
        if numberOfMemes == 0 {
            collectionView.showEmptyView(message: "You haven't created any memes yet. Create some!")
            return 0
        } else {
            collectionView.hideEmptyView()
            return numberOfMemes
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemeCell.className, for: indexPath) as? MemeCell else { return UICollectionViewCell() }
        
        let modelController = logicController.modelController(for: indexPath.item)
        cell.configure(with: modelController)
        
        return cell
    }
    
}

extension MyMemesViewController: UICollectionViewDelegate {
    
    // MARK: - Collection View Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let selectedMemeModelController = logicController.modelController(for: indexPath.item)
        let detailViewController = viewControllersFactory.createDetailViewController(modelController: selectedMemeModelController)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}

extension MyMemesViewController: UICollectionViewDelegateFlowLayout {
    
    // MARK: - Collection View Delegate Flow Layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.bounds.width/3) - minimumSpacing
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumSpacing
    }

}

extension MyMemesViewController: UIImagePickerControllerDelegate {
    
    // MARK: - Image Picker Controller Delegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let memeCreatorViewController = viewControllersFactory.createMemeCreatorViewController(originalImage: image)
            navigationController?.pushViewController(memeCreatorViewController, animated: true)
        }
        dismiss(animated: true, completion: nil)
    }
    
}
