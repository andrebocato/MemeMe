//
//  MemeCreatorViewController.swift
//  MemeMe
//
//  Created by Andre Sanches Bocato on 03/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//
// @TODO: redo layout

import UIKit

class MemeCreatorViewController: UIViewController {
    
    // MARK: - Dependencies
    
    private let originalImage: UIImage
    private let modelController: MemeModelController
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var topTextField: UITextField!
    @IBOutlet private weak var bottomTextField: UITextField!
    
    // MARK: - Initialization
    
    init(nibName nibNameOrNil: String?,
         bundle nibBundleOrNil: Bundle?,
         originalImage: UIImage,
         modelController: MemeModelController) {
        self.originalImage = originalImage
        self.modelController = modelController
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
        imageView.image = originalImage
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
        let printScreen = view.asImage(bounds: imageView.bounds) // @TODO: fix white bars on produced image
        let newMeme = Meme(topText: topTextField.text ?? "",
                           bottomText: bottomTextField.text ?? "",
                           originalImage: originalImage,
                           memedImage: printScreen,
                           id: UUID().uuidString)

        modelController.createNew(newMeme)
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func discardBarButtonItemDidReceiveTouchUpInside(_ sender: UIBarButtonItem) {
        AlertHelper.showAlert(inController: self,
                              title: "Are you sure?",
                              message: "This action cannot be undone.",
                              rightAction: UIAlertAction(title: "Discard", style: .destructive, handler: { [weak self] (action) in
                                self?.navigationController?.popViewController(animated: true)
                              }))
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
    
}
