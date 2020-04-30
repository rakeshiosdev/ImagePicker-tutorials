//
//  ViewController.swift
//  ImagePicker-tutorials
//
//  Created by Rakesh Kumar on 20/04/20.
//  Copyright © 2020 Rakesh Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnProfile: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        btnProfile.layer.cornerRadius = 60
        btnProfile.layer.masksToBounds = true
    }

    @IBAction func touchProfileButton(_ sender: UIButton) {
        tapProfileButton()
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func tapProfileButton(){
        
        let photoLibraryAction = UIAlertAction(title: "Choose from Library", style: .default) { (action) in
            self.showImagePickerController(sourceType: .photoLibrary)
        }
        let cameraAction = UIAlertAction(title: "Take from Camera", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.showImagePickerController(sourceType: .camera)
            }else{
                let alert = UIAlertController(title: "Alert", message: "Device has no camera", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Cancel", style: .default)
                alert.addAction(cancelAction)
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        let objAlert = UIAlertController(title: nil, message: "Choose your image", preferredStyle: .actionSheet)
        objAlert.addAction(photoLibraryAction)
        objAlert.addAction(cameraAction)
        objAlert.addAction(cancelAction)
        self.present(objAlert, animated: true, completion: nil)
    }
    
    
    func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     
        if let editImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            btnProfile.setImage(editImage, for: .normal)
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            btnProfile.setImage(originalImage, for: .normal)
        }
        
        dismiss(animated: true, completion: nil)
    }
}
