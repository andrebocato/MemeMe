//
//  MemeCreatorViewController.swift
//  MemeMe
//
//  Created by Andre Sanches Bocato on 03/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

class MemeCreatorViewController: UIViewController {
    
    // MARK: - Dependencies
    
    private let originalImageData: Data
    private let logicController: MemeDatabaseLogicController
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var topTextField: UITextField!
    @IBOutlet private weak var bottomTextField: UITextField!
    @IBOutlet private weak var printScreenView: UIView!
    
    // MARK: - Initialization
    
    init(nibName nibNameOrNil: String?,
         bundle nibBundleOrNil: Bundle?,
         originalImageData: Data,
         logicController: MemeDatabaseLogicController) {
        self.originalImageData = originalImageData
        self.logicController = logicController
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: - UI
    
    private func setupUI() {
        createBarButtonItems()
        configureImageView()
        configureTextFields([topTextField, bottomTextField])
    }
    
    private func configureImageView() {
        imageView.image = UIImage(data: originalImageData)
    }
    
    
    /// Configures text fields text attributes, settings and delegates.
    ///
    /// - Parameter textFields: An array of UITextFields to be configured.
    private func configureTextFields(_ textFields: [UITextField]) {
        for textField in textFields {
            textField.delegate = self
            textField.defaultTextAttributes = [
                .strokeColor: UIColor.black,
                .foregroundColor: UIColor.white,
                .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
                .strokeWidth: -5.0 // magic number. a negative float value corrected a previous bug and i don't know why
            ]
        }
    }
    
    private func createBarButtonItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "done"),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(finishBarButtonItemDidReceiveTouchUpInside(_:)))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "discard"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(discardBarButtonItemDidReceiveTouchUpInside(_:)))
    }
    
    // MARK: - Actions
    
    @objc private func finishBarButtonItemDidReceiveTouchUpInside(_ sender: UIBarButtonItem) {
        guard let printScreenData = printScreenView.asImageData(bounds: printScreenView.bounds) else { return }
        
        // this should be inside the logic controller
//        let newMeme = Meme,
//                           id: UUID().uuidString)
        let memeInfo: MemeDatabaseLogicController.MemeInfo = (
            topText: topTextField.text,
            bottomText: bottomTextField.text,
            originalImageData: originalImageData,
            memedImageData: printScreenData)
        
        do {
            try logicController.createNewMeme(from: memeInfo)
            navigationController?.popViewController(animated: true)
        } catch {
            presentError(error)
        }
        
    }
    
    @objc private func discardBarButtonItemDidReceiveTouchUpInside(_ sender: UIBarButtonItem) {
        AlertHelper.presentAlert(inController: self,
                              title: "Are you sure?",
                              message: "This action cannot be undone.",
                              rightAction: UIAlertAction(title: "Discard", style: .destructive, handler: { [weak self] (action) in
                                self?.navigationController?.popViewController(animated: true)
                              }))
    }
    
    // MARK: - Helpers
    private func presentError(_ error: Error) {
        AlertHelper.presentAlert(inController: self, title: "Error!", message: error.localizedDescription)
    }
    
    // MARK: - Attributed Text Attributes
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        .strokeColor: UIColor.black,
        .foregroundColor: UIColor.white,
        .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        .strokeWidth: -5.0
    ]
    
    // MARK: - Keyboard Hiding Functions
    
    // legacy code
    @objc func keyboardWillShow(_ notification: Notification) {
        if bottomTextField.isEditing {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    // legacy code
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    // legacy code
    private func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    // legacy code
    private func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // legacy code
    private func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}

extension MemeCreatorViewController: UITextFieldDelegate {
    
    // MARK: - UITextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty {
            return true
        }
        if textField.text!.count <= 30 {
            return true
        }
        return false
    }
    
}
