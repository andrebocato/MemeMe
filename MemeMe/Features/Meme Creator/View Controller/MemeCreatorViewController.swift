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
    @IBOutlet private weak var topTextField: UITextField! {
        didSet {
            configure(topTextField)
        }
    }
    @IBOutlet private weak var bottomTextField: UITextField! {
        didSet {
            configure(bottomTextField)
        }
    }
    @IBOutlet private weak var activityBarButtonItem: UIBarButtonItem!
    @IBOutlet private weak var cancelBarButtonItem: UIBarButtonItem!
    @IBOutlet private weak var cameraBarButtonItem: UIBarButtonItem!
    @IBOutlet private weak var photoLibraryBarButtonItem: UIBarButtonItem!
    @IBOutlet private weak var printScreenView: UIView!
    
    // MARK: - Properties
    
    private var lastMeme: Meme?
    
    // MARK: - Initialization
    
    init(nibName nibNameOrNil: String?,
         bundle nibBundleOrNil: Bundle?,
         originalImage: UIImage) {
        self.originalImage = originalImage
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        checkForCameraAvailability()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: - IBActions
    
    @IBAction private func photoLibraryButtonDidReceiveTouchUpInside(_ sender: Any) {
        selectImagePickerSourceType(.photoLibrary)
    }
    
    @IBAction private func cameraBarButtonItemDidReceiveTouchUpInside(_ sender: Any) {
        selectImagePickerSourceType(.camera)
    }
    
    @IBAction private func activityBarButtonItemDidReceiveTouchUpInside(_ sender: Any) {
        presentActivityView()
    }
    
    @IBAction private func cancelBarButtonItemDidReceiveTouchUpInside(_ sender: Any) {
        resetMemeData()
    }
    
    // MARK: - UI Configuration
    
    /// Sets up a text field configuration.
    ///
    /// - Parameter textField: The text field to be configured.
    private func configure(_ textField: UITextField) {
        textField.delegate = self
        textField.autocapitalizationType = .allCharacters
        textField.defaultTextAttributes = memeTextAttributes
    }
    
    // MARK: - Functions
    
    /// Presents an activity view controller.
    private func presentActivityView() {
        let imageToShare: UIImage = generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [imageToShare], applicationActivities: [])
        activityViewController.completionWithItemsHandler = { [weak self] (activityType, completed, returnedItems, error) in
            if !completed { return }
            self?.saveImage()
        }
        present(activityViewController, animated: true, completion: nil)
    }
    
    private func resetMemeData() {
        imageView.image = nil
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
    }
    
    private func checkForCameraAvailability() {
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            cameraBarButtonItem.isEnabled = false
        }
    }
    
    func selectImagePickerSourceType(_ sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if bottomTextField.isEditing {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    private func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func generateMemedImage() -> UIImage {
        UIGraphicsBeginImageContext(printScreenView.frame.size)
        printScreenView.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let imageFromPrintScreenView = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return imageFromPrintScreenView
    }
    
    func saveImage() {
        lastMeme = Meme(topText: topTextField.text ?? "",
                        bottomText: bottomTextField.text ?? "",
                        originalImage: imageView.image ?? UIImage(),
                        memedImage: generateMemedImage())
    }
    
    // MARK: - Attributed Text Attributes
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        .strokeColor: UIColor.black,
        .foregroundColor: UIColor.white,
        .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        .strokeWidth: -5.0
    ]
    
}
