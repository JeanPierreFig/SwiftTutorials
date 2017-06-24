//
//  ViewController.swift
//  iCaptureMe
//
//  Created by John Xiong on 5/24/17.
//  Copyright © 2017 xiong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func usePhotoLibraryButtonPressed(_ sender: UIButton) {
        takeImageButton?.isHidden = true
        openPhotoLibrary()
    }
    
    @IBAction func useCameraButtonPressed(_ sender: UIButton) {
        takeImageButton?.isHidden = false
        startCamera()
    }
    
    @IBAction func takeImageButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var takeImageButton: UIButton?

    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
    }
    
    fileprivate func openPhotoLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            imagePicker.modalPresentationStyle = .popover
            present(imagePicker, animated: true, completion: nil)
        } else {
            displayBasicAlert(title: "Cannot open Library", message: "Cannot open library on this device")
        }
    }
    
    fileprivate func startCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera)!
            imagePicker.modalPresentationStyle = .popover
            present(imagePicker, animated: true, completion: nil)
        } else {
            displayBasicAlert(title: "Cannot open Camera", message: "Device does not have a camera")
        }
    }
    
    fileprivate func displayBasicAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageView?.contentMode = .scaleAspectFit
        imageView?.image = selectedImage
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
