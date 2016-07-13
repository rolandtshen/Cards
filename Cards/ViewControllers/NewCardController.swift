//
//  NewCardController.swift
//  Cards
//
//  Created by Roland Shen on 7/6/16.
//  Copyright © 2016 Roland Shen. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework
import RealmSwift

class NewCardController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var themeButton: UIButton!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var jobField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!

    var card: Card? {
        didSet {
            hexTheme = card?.theme as? String
        }
    }
    var hexTheme: String?
    var imagePickerController: UIImagePickerController?
    
    override func viewDidLoad() {
        let defaultPic: UIImage = UIImage(named: "default")!
        photo.layer.cornerRadius = photo.frame.width / 2;
        photo.clipsToBounds = true
        photo.image = defaultPic
        
        //allows photo to be tapped
        photo.userInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(NewCardController.imageTapped(_:)))
        photo.addGestureRecognizer(tapGesture)
        
        self.view.backgroundColor = UIColor.lightGrayColor()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NewCardController.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NewCardController.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil);
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewCardController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(animated: Bool) {
        if let card = card {
            photo.image = UIImage(data: card.imageData)
            nameField.text = card.name
            jobField.text = card.job
            emailField.text = card.email
            phoneField.text = card.phoneNum
            view.backgroundColor = UIColor(hexString: hexTheme ?? "CCCCCC")
        }
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -250
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    func imageTapped(gesture: UIGestureRecognizer) {
        if (gesture.view as? UIImageView) != nil {
            print("Image Tapped")
            // Allow user to choose between photo library and camera
            let alertController = UIAlertController(title: nil, message: "Where do you want to get your picture from?", preferredStyle: .ActionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            
            alertController.addAction(cancelAction)
            
            let photoLibraryAction = UIAlertAction(title: "Photo from Library", style: .Default) { (action) in
                self.showImagePickerController(.PhotoLibrary)
            }
            
            alertController.addAction(photoLibraryAction)
            
            // Only show camera option if rear camera is available
            if (UIImagePickerController.isCameraDeviceAvailable(.Rear)) {
                let cameraAction = UIAlertAction(title: "Photo from Camera", style: .Default) { (action) in
                    self.showImagePickerController(.Camera)
                }
                alertController.addAction(cameraAction)
            }
            presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            photo.image = pickedImage
            let realm = try! Realm()
            try! realm.write {
                card?.imageData = UIImageJPEGRepresentation(pickedImage, 0.8)!
            }
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func showImagePickerController(sourceType: UIImagePickerControllerSourceType) {
        imagePickerController = UIImagePickerController()
        imagePickerController!.sourceType = sourceType
        imagePickerController!.delegate = self
        
        presentViewController(imagePickerController!, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Save" {
            let tableViewController = segue.destinationViewController as! TableViewController
            if let card = card {
                let newCard = Card()
                newCard.imageData = UIImagePNGRepresentation(photo.image!)!
                newCard.name = nameField.text ?? ""
                newCard.job = jobField.text ?? ""
                newCard.email = emailField.text ?? ""
                newCard.phoneNum = phoneField.text ?? ""
                newCard.theme = hexTheme ?? ""
                RealmHelper.updateCard(card, newCard: newCard)
            }
            else {
                let card = Card()
                card.imageData = UIImagePNGRepresentation(photo.image!)!
                card.name = nameField.text ?? ""
                card.job = jobField.text ?? ""
                card.email = emailField.text ?? ""
                card.phoneNum = phoneField.text ?? ""
                card.theme = hexTheme ?? ""
                RealmHelper.addCard(card)
            }
            
            tableViewController.cards = RealmHelper.getCards()
        }
        
        // Does nothing otherwise
    }

    @IBAction func unwindToNewCardViewController(segue: UIStoryboardSegue) {
        //unwind segue
    }
}