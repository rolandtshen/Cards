//
//  NewCardController.swift
//  Cards
//
//  Created by Roland Shen on 7/6/16.
//  Copyright © 2016 Roland Shen. All rights reserved.
//

import Foundation
import UIKit

class NewCardController: UIViewController {
    
    @IBOutlet weak var themeButton: UIButton!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var jobField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!

    var card: Card?
    var imagePickerController: UIImagePickerController?
    var photoHelper: PhotoHelper
    
    override func viewDidLoad() {
        let defaultPic: UIImage = UIImage(named: "default")!
        photo.layer.cornerRadius = photo.frame.size.width / 2;
        photo.clipsToBounds = true
        photo.image = defaultPic
        
        //allows photo to be tapped
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(NewCardController.imageTapped(_:)))
        photo.addGestureRecognizer(tapGesture)
        photo.userInteractionEnabled = true
    }
    
    func imageTapped(gesture: UIGestureRecognizer) {
        if (gesture.view as? UIImageView) != nil {
            print("Image Tapped")
            photoHelper = PhotoHelper(viewController: self) { (image: UIImage?) -> Void in
                self.photo.image = image!
            }
        }
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let tableViewController = segue.destinationViewController as! TableViewController
        
        if segue.identifier == "Save" {
            if let card = card {
                let newCard = Card()
                newCard.imageData = UIImagePNGRepresentation(photo.image!)!
                newCard.name = nameField.text ?? ""
                newCard.job = jobField.text ?? ""
                newCard.email = emailField.text ?? ""
                newCard.phoneNum = phoneField.text ?? ""
                RealmHelper.updateCard(card, newCard: newCard)
            }
            else {
                let card = Card()
                card.imageData = UIImagePNGRepresentation(photo.image!)!
                card.name = nameField.text ?? ""
                card.job = jobField.text ?? ""
                card.email = emailField.text ?? ""
                card.phoneNum = phoneField.text ?? ""
                RealmHelper.addCard(card)
            }
            tableViewController.cards = RealmHelper.getCards()
        }
    }

    @IBAction func unwindToNewCardViewController(segue: UIStoryboardSegue) {
        //unwind segue
    }
}