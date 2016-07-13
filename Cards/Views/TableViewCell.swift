//
//  TableViewCell.swift
//  Cards
//
//  Created by Roland Shen on 7/5/16.
//  Copyright © 2016 Roland Shen. All rights reserved.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var job: UILabel!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var line: UIView!
}