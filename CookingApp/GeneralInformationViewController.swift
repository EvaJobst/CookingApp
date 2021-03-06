//
//  GeneralInformationTableViewController.swift
//  CookingApp
//
//  Created by Hannes on 28.02.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import UIKit

class GeneralInformationViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    @IBOutlet weak var summaryTextField: UITextView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var servingsTextField: UITextField!
    let entities = EntityManager()
    //@IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //authorLabel.text = entities.author[0].name
        authorLabel.text = "User"
        summaryTextField.layer.borderWidth = 1
        
        summaryTextField.delegate = self
        nameTextField.delegate = self
        servingsTextField.delegate = self
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //nameTextField.delegate = self
        self.hideKeyboard()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(self.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    /*@IBAction func openCameraButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func openPhotoLibraryButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        imageView.image = image
        self.dismiss(animated: true, completion: nil)
        
    }*/
}
