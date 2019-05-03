//
//  ViewController.swift
//  FoodTracker
//
//  Created by Jeffrey on 8/4/2019.
//  Copyright © 2019 gabrielle. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    // MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var moodNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var dateTextField: UITextField!
    
    // MARK: UIDateField
    private var datePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field's user input through delegate callbacks.
        nameTextField.delegate=self
        
        // Date Field
        datePicker=UIDatePicker()
        datePicker?.datePickerMode = .dateAndTime
        datePicker?.addTarget(self, action:#selector(ViewController.dateChanged(datePicker:)),for:.valueChanged)
        
        let tapGesture=UITapGestureRecognizer(target: self, action: #selector(ViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        dateTextField.inputView=datePicker
    }
    
    @objc func viewTapped(gestureRecognizer:UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    // MARK: UIDateFieldDelegate
    @objc func dateChanged(datePicker:UIDatePicker){
        let dateFormatter=DateFormatter()
        dateFormatter.dateFormat="MM/dd/yyyy HH:mm"
        dateTextField.text=dateFormatter.string( from: datePicker.date)
        // Dismisses datepicker automatically
        view.endEditing(true)
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Hide the keyboard when user hits return on keyboard
        textField.resignFirstResponder()
        
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        // Set the label text as the text field input by the user
        moodNameLabel.text=textField.text
    }
    
    // MARK: UIImgagePickerontrollerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        // Dismiss the picker if user cancels
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // Use the original image, not the edited image
        guard let selectedImage=info[.originalImage] as? UIImage
        else{
             fatalError("Expected a dictionary containing an image, but was provided with the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        photoImageView.image=selectedImage
        
        // Dismiss the picker
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        // Hide the keyboard if user taps photo while typing in text field
        nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController=UIImagePickerController()
        
        // Only allow photos to be picked, not taken
        imagePickerController.sourceType = .photoLibrary
        
        // Notifies ViewController when user picks an image.
        imagePickerController.delegate=self
        present(imagePickerController,animated: true,completion: nil)
    }

}

