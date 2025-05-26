//
//  cameraViewController.swift
//  vFlair
//
//  Created by Prajwal V.v on 22/11/18.
//  Copyright © 2018 fluid. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import RAMAnimatedTabBarController
class cameraViewController: UIViewController {
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var shareButton: UIButton!
    var selectedImage: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        photo.isUserInteractionEnabled = true
        photo.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleSelectedPhoto)))
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handlePost()

    }
    
    func handlePost(){
        if selectedImage != nil{
            self.shareButton.isEnabled = true
            self.shareButton.backgroundColor = .green
            
        }else{
            self.shareButton.isEnabled = false
            self.shareButton.backgroundColor = .gray
        }
    }
    
    @objc func keyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            
        }, completion: nil)
    }
    
    @objc func keyboardShow() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
//            self.view.frame = CGRect(x: 0, y: -173, width: self.view.frame.width, height: self.view.frame.height)
            
        }, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @objc func handleSelectedPhoto(){
        let pickerController = UIImagePickerController()
        ProgressHUD.show("Loading...")
        //        let Pick = UIImagePickerController.InfoKey.originalImage
        pickerController.allowsEditing = true
        pickerController.delegate = self
        present(pickerController,animated: true, completion: ProgressHUD.dismiss)
    }
    
    
    @IBAction func buttonIfClicked(_ sender: Any) {
        view.endEditing(true)
        ProgressHUD.show("Waiting...", interaction: false)
        if let profileImg = self.selectedImage, let imageData = profileImg.jpegData(compressionQuality: 0.1){
            let ratio = profileImg.size.width / profileImg.size.height
            HelperService.uploadDataToServer(data: imageData, ratio: ratio, caption: caption.text!, onSuccess: {
                self.clean()
                self.navigationController?.popViewController(animated: true)
            })
            
        } else {
            ProgressHUD.showError("Profile Image can't be empty")
        }
        }
   
    
    func clean() {
        self.caption.text = ""
        self.photo.image = UIImage(named: "ADDIMG")
        self.selectedImage = nil
    }
    }


extension cameraViewController:
UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        if let image = info[.originalImage] as? UIImage{
            selectedImage = image
            photo.image = image
        }else{
            
            print("there was a problem getting the image")
            
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
