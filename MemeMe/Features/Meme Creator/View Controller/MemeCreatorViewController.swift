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
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var topTextField: UITextField!
    @IBOutlet private weak var bottomTextField: UITextField!
    
    // MARK: - Initialization
    
    init(nibName nibNameOrNil: String?,
         bundle nibBundleOrNil: Bundle?,
         originalImage: UIImage) {
        self.originalImage = originalImage
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
        configureTexFields([topTextField, bottomTextField])
    }
    
    private func configureImageView() {
        imageView.image = originalImage
    }
    
    
    /// Configures text fields text attributes, settings and delegates.
    ///
    /// - Parameter textFields: An array of UITextFields to be configured.
    private func configureTexFields(_ textFields: [UITextField]) {
        for textField in textFields {
            textField.delegate = self
            textField.autocapitalizationType = .allCharacters
            textField.defaultTextAttributes = memeTextAttributes
        }
    }
    
    private func createBarButtonItems() {
        let finishBarButtonItem = UIBarButtonItem(image: UIImage(named: "done"), style: .done, target: self, action: #selector(finishBarButtonItemDidReceiveTouchUpInside(_:)))
        navigationItem.rightBarButtonItem = finishBarButtonItem
        
        let discardBarButtonItem = UIBarButtonItem(image: UIImage(named: "discard"), style: .done, target: self, action: #selector(discardBarButtonItemDidReceiveTouchUpInside(_:)))
        navigationItem.leftBarButtonItem = discardBarButtonItem
    }
    
    // @TODO: refactor. there must be a better way to do this
    private func generateMemedImage() -> UIImage {
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let imageFromPrintScreen = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return imageFromPrintScreen
    }
    
    // MARK: - Actions
    
    @objc private func finishBarButtonItemDidReceiveTouchUpInside(_ sender: UIBarButtonItem) {
        let newMeme = Meme(topText: topTextField.text ?? "", bottomText: bottomTextField.text ?? "", originalImage: originalImage, memedImage: generateMemedImage(), id: UUID().uuidString)
//        let modelController = logicController
//        modelController.createNew(newMeme)
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func discardBarButtonItemDidReceiveTouchUpInside(_ sender: UIBarButtonItem) {
        AlertHelper.showAlert(inController: self, title: "Are you sure?", message: "This action cannot be undone.", rightAction: UIAlertAction(title: "Discard", style: .destructive, handler: { [weak self] (action) in
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
    
    // from legacy code
    @objc func keyboardWillShow(_ notification: Notification) {
        if bottomTextField.isEditing {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    // from legacy code
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    private func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    // from legacy code
    private func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // from legacy code
    private func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}

extension MemeCreatorViewController: UITextFieldDelegate {
    
    // MARK: - UITextField Delegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == topTextField {
            textField.resignFirstResponder()
            bottomTextField.becomeFirstResponder()
        }
    }
    
}
