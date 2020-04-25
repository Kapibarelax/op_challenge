//
//  ViewController.swift
//  MyCamera
//
//  Created by 高松美香 on 2020/04/06.
//  Copyright © 2020 learning-swift. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBOutlet weak var pictureImage: UIImageView!
    
    
    @IBAction func cameraButtonAction(_ sender: Any) {
        
        let alertController = UIAlertController(title: "確認", message: "選択してください", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "カメラ", style: .default, handler: {(action) in
            
            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .camera
            imagePickerController.delegate = self
            self.present(imagePickerController, animated: true, completion: nil)
            
        })
        alertController.addAction(cameraAction)
        
        let photoLibraryAction = UIAlertAction(title: "フォトライブラリ", style: .default, handler: {(action) in
            
            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.delegate = self
            self.present(imagePickerController, animated: true, completion: nil)
            
        })
        alertController.addAction(photoLibraryAction)
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        alertController.popoverPresentationController?.sourceView = view
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func shareButtonAction(_ sender: Any) {
        
        if let shareImage = pictureImage.image {
            let shareImages = [shareImage]
            let controller = UIActivityViewController(activityItems: shareImages, applicationActivities: nil)
            controller.popoverPresentationController?.sourceView = view
            present(controller, animated: true, completion: nil)
            
        }
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        pictureImage.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        dismiss(animated: true, completion: nil)
        
    }
    
    
}

