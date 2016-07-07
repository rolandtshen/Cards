//
//  ViewCardController.swift
//  Cards
//
//  Created by Roland Shen on 7/6/16.
//  Copyright © 2016 Roland Shen. All rights reserved.
//

import Foundation
import UIKit

class ViewCardController: UIViewController {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var job: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    
    convenience init() {
        self.init()
        photo.image = UIImage(named: "default")
        name.text = ""
        job.text = ""
        email.text = ""
        phone.text = ""
    }

    override func viewDidLoad() {
        let defaultPic: UIImage = UIImage(named: "default")!
        photo.layer.cornerRadius = photo.frame.size.width / 2;
        photo.clipsToBounds = true
        photo.image = defaultPic
    }
    
}
