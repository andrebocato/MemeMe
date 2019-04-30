//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by André Sanches Bocato on 07/11/18.
//  Copyright © 2018 André Sanches Bocato. All rights reserved.
//
// @TODO: textfields should jump to other lines when text is too long
// @TODO: You will need to implement the activityViewController's completionWithItemsHandler to call your saveImage method if the action is successful. See this reference: https://developer.apple.com/documentation/uikit/uiactivityviewcontroller/completionwithitemshandler
// @TODO: center textField.text

import UIKit

class MemeEditorViewController: UIViewController, UINavigationControllerDelegate {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var topTextField: UITextField! {
        didSet {
            topTextField.delegate = self
            topTextField.autocapitalizationType = .allCharacters
            topTextField.defaultTextAttributes = memeTextAttributes
        }
    }
    @IBOutlet private weak var bottomTextField: UITextField! {
        didSet {
            bottomTextField.delegate = self
            bottomTextField.autocapitalizationType = .allCharacters
            bottomTextField.defaultTextAttributes = memeTextAttributes
        }
    }
    @IBOutlet private weak var activityBarButtonItem: UIBarButtonItem!
    @IBOutlet private weak var cancelBarButtonItem: UIBarButtonItem!
    @IBOutlet private weak var cameraBarButtonItem: UIBarButtonItem!
    @IBOutlet private weak var photoLibraryBarButtonItem: UIBarButtonItem!
    
    // MARK: - Properties
    
    private var lastMeme: Meme?
    
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
        selectImagePickerSourceType(sourceType: .photoLibrary)
    }
    
    @IBAction private func cameraBarButtonItemDidReceiveTouchUpInside(_ sender: Any) {
        selectImagePickerSourceType(sourceType: .camera)
    }
    
    @IBAction private func activityBarButtonItemDidReceiveTouchUpInside(_ sender: Any) {
        presentActivityView()
    }
    
    @IBAction private func cancelBarButtonItemDidReceiveTouchUpInside(_ sender: Any) {
        resetMemeData()
    }
    
    // MARK: - Functions
    
    private func presentActivityView() {
        let imageToShare: UIImage = generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [imageToShare], applicationActivities: [])
        activityViewController.completionWithItemsHandler = {(activityType, completed: Bool, returnedItems:[Any]?, error: Error?) in
            if (!completed) {
                return
            }
            self.saveImage()
        }
        self.present(activityViewController, animated: true, completion: nil)
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
    
    func selectImagePickerSourceType(sourceType: UIImagePickerController.SourceType) {
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
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
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
        hideNavigationBarAndToolbar()
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        showNavigationBarAndToolbar()
        
        return memedImage
    }
    
    func hideNavigationBarAndToolbar() {
        toolbar.isHidden = true
        navigationBar.isHidden = true
    }
    
    func showNavigationBarAndToolbar() {
        toolbar.isHidden = false
        navigationBar.isHidden = false
    }
    
    func saveImage() {
        // Create the meme
        let memedImage = generateMemedImage()
        self.lastMeme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageView.image!, memedImage: memedImage)
    }
    
    // Mark: - Text Attributes
    
    let memeTextAttributes:[NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: -5.0]
}

// MARK: - Extensions

extension MemeEditorViewController: UIImagePickerControllerDelegate {
    
    // MARK: - Image Picker Controller Delegate
    
}

extension MemeEditorViewController: UITextFieldDelegate {
    
    // MARK: - Text Field Delegate
    
}
