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
    
    private let viewControllersFactory: ViewControllersFactoryProtocol
    private let logicController: MemeDatabaseLogicController
    
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
         viewControllersFactory: ViewControllersFactoryProtocol,
         logicController: MemeDatabaseLogicController) {
        self.viewControllersFactory = viewControllersFactory
        self.logicController = logicController
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        registerCollectionViewCells()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
        try? logicController.fetchAllMemes() // @TODO: handle errors?
    }
    
    // MARK: - UI Configuration
    
    private func setupUI() {
        setupNavigationBar()
    }
    
    private func registerCollectionViewCells() {
        let bundle = Bundle(for: MemeCell.self)
        let className = MemeCell.className
        let cellNib = UINib(nibName: className, bundle: bundle)
        collectionView.register(cellNib, forCellWithReuseIdentifier: className)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Meme Me"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "add"),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(addNewMemeBarButtonItemDidReceiveTouchUpInside(_:)))
    }
    
    // MARK: - UI Helper Functions
    
    /// Presents an image picker.
    ///
    /// - Parameter sourceType: Source type of the image picker to be presented.
    private func presentImagePicker(_ sourceType: UIImagePickerController.SourceType) {
        imagePicker.sourceType = sourceType
        
        DispatchQueue.main.async {
            self.present(self.imagePicker, animated: true, completion: nil)
        }
    }
    
    // MARK: - Actions
    
    @objc private func addNewMemeBarButtonItemDidReceiveTouchUpInside(_ sender: UIBarButtonItem) {
        AlertHelper.presentActionSheet(inController: self,
                                       title: "Choose an image source",
                                       message: nil,
                                       actions: [
                                        UIAlertAction(title: "Camera", style: .default) { [weak self] (action) in
                                            UIImagePickerController.isSourceTypeAvailable(.camera) ? self?.presentImagePicker(.camera) : AlertHelper.presentAlert(inController: self, title: "Could not complete action", message: "No available camera on your device.")
                                        },
                                        
                                        UIAlertAction(title: "Photo Library", style: .default) { [weak self] (action) in
                                            self?.presentImagePicker(.photoLibrary)
                                        }])
    }
    
}

// MARK: - Extensions

extension MyMemesViewController: UICollectionViewDataSource {
    
    // MARK: - Collection View Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfMemes = logicController.memes.count
        if numberOfMemes == 0 {
            view.showEmptyView(message: "You haven't created any memes yet. Create some!")
            return 0
        } else {
            view.hideEmptyView()
            return numberOfMemes
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemeCell.className, for: indexPath) as? MemeCell else { return UICollectionViewCell() }
        cell.configure(with: logicController.memes[indexPath.row].memedImageData)
        return cell
    }
    
}

extension MyMemesViewController: UICollectionViewDelegate {
    
    // MARK: - Collection View Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let memedImageData = logicController.memes[indexPath.item].memedImageData
        let detailViewController = viewControllersFactory.createDetailViewController(memedImageData: memedImageData)
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

extension MyMemesViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Image Picker Controller Delegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
            let imageData = image.jpegData(compressionQuality: 0.7) else {
                
            AlertHelper.presentAlert(inController: self,
                                     title: "Oops!",
                                     message: "Something went wrong. Try again.")
            dismiss(animated: true, completion: nil)
            return
        }
        
        let memeCreatorViewController = viewControllersFactory.createMemeCreatorViewController(originalImageData: imageData, logicController:logicController)
        dismiss(animated: true, completion: nil)
        navigationController?.pushViewController(memeCreatorViewController, animated: true)
    }
    
}
