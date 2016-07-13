//
//  Card.swift
//  Cards
//
//  Created by Roland Shen on 7/5/16.
//  Copyright © 2016 Roland Shen. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import Realm

class Card: Object {
    
    dynamic var imageData: NSData = UIImagePNGRepresentation(UIImage(named: "default")!)!
    dynamic var name = ""
    dynamic var job = ""
    dynamic var email = ""
    dynamic var phoneNum = ""
    dynamic var modificationTime = NSDate()
    dynamic var theme: NSString = "CCCCCC"
}