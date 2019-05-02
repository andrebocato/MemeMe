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
        registerCollectionViewCells()
    }
    
    // MARK: - UI Configuration
    
    private func registerCollectionViewCells() {
        let bundle = Bundle(for: MemeCell.self)
        let className = MemeCell.className
        let cellNib = UINib(nibName: className, bundle: bundle)
        collectionView.register(cellNib, forCellWithReuseIdentifier: className)
    }
    
}

// MARK: - Extensions

extension MyMemesViewController: UICollectionViewDataSource {
    
    // MARK: - Collection View Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return logicController.numberOfMemes
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
        let detailViewController = viewControllersFactory.createDetailViewController(memeModelController: selectedMemeModelController)
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
