//
//  MemesEditorViewController.swift
//  Meme Project_JDH_v2.1
//
//  Created by Do Hyung Joo on 25/11/18.
//  Copyright © 2018 Do Hyung Joo. All rights reserved.
//

import UIKit
import Photos

class MemeEditorViewController : UIViewController {
    
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var textTop: UITextField!
    @IBOutlet weak var textBottom: UITextField!
    @IBOutlet weak var toolbarTop: UIToolbar!
    @IBOutlet weak var toolbarBottom: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    
    var meme = [Memes]()
    
    
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.backgroundColor: UIColor.clear,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 50)!,
        NSAttributedString.Key.strokeWidth:  -5
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.bringSubviewToFront(toolbarTop)
        self.view.bringSubviewToFront(toolbarBottom)
        
        debugPrint("Launching View DId Load")
        
        view.backgroundColor = UIColor.gray
        
        configure(textField: textTop, withTexttext: "Top")
        configure(textField: textBottom, withTexttext: "Bottom")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Your Code Here...
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        subscribeToKeyboardNotifications()
        subscribeToKeyboardHideNotifications()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
}


// MARK: - UINavigationControllerDelegate
extension MemeEditorViewController: UINavigationControllerDelegate {
    // UINavigationControllerDelegate methods

}


// MARK: - UITextFieldDelegate
extension MemeEditorViewController: UITextFieldDelegate {
    // UITextFieldDelegate methods

    
    func configure(textField: UITextField, withTexttext: String) {
        
        textField.text = withTexttext
        textField.defaultTextAttributes = memeTextAttributes
        textField.borderStyle = .none
        textField.textAlignment = NSTextAlignment.center
        textField.keyboardAppearance = .default
        textField.keyboardType = .default
        textField.delegate = self
        self.view.addSubview(textField)
        
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // became first responder
        textField.text = nil
        textField.becomeFirstResponder()
        print("TextField did begin editing method called")
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // called when 'return' key pressed. return NO to ignore.
        print("TextField should return method called")
        // may be useful: textField.resignFirstResponder()
        
        textField.resignFirstResponder()
        return true
    }

    
}
    
    

// MARK: - UIImagePickerControllerDelegate
extension MemeEditorViewController: UIImagePickerControllerDelegate {
    // UIImagePickerControllerDelegate methods
    
    func presentImagePickerWith(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func pickAnImage(_ sender: Any) {
        
        presentImagePickerWith(sourceType: UIImagePickerController.SourceType.photoLibrary)
        
    }
    
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        
        presentImagePickerWith(sourceType: UIImagePickerController.SourceType.camera)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        
        if textBottom.isFirstResponder {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
    }
    
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func subscribeToKeyboardHideNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickerView.image = image
            imagePickerView.contentMode = UIView.ContentMode.scaleAspectFill
            imagePickerView.clipsToBounds = true
            imagePickerView.translatesAutoresizingMaskIntoConstraints = true
            imagePickerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            dismiss(animated: true, completion: nil)
            
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
    }
    
    func generateMemedImage() -> UIImage {
        
        // TODO: Hide toolbar and navbar
        hideTopAndBottomBars(true)
        
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // TODO: Show toolbar and navbar
        
        toolbarTop.isHidden = false
        toolbarBottom.isHidden = false
        
        return memedImage
        
    }
    
    
    func hideTopAndBottomBars(_ hide: Bool) {
        toolbarTop.isHidden = true
        toolbarBottom.isHidden = true
    }
    
    func save() {
        // Create the meme
        let meme = Memes(
            topText: textTop.text!,
            bottomText: textBottom.text!,
            originalImage: imagePickerView.image!,
            memedImage: generateMemedImage())
        
        // Add it to the memes array in the Application Delegate
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
    }
    
    @IBAction func shareImage(_ sender: Any) {
        
        let sharedImage = generateMemedImage()
        let activityController = UIActivityViewController(activityItems:    [sharedImage], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
        
        activityController.completionWithItemsHandler =  { activity, success, items, error in
            
            if success {
                self.save()
            }
            
        }
        
    }
    
}
