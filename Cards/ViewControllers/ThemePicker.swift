//
//  ThemePicker.swift
//  Cards
//
//  Created by Roland Shen on 7/6/16.
//  Copyright © 2016 Roland Shen. All rights reserved.
//

import UIKit
import Foundation
import ChameleonFramework

class ThemePicker: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var mySegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    let flatColors: [(String, UIColor)] = [
        ("Black", UIColor.flatBlackColor()),
        ("Blue", UIColor.flatBlueColor()),
        ("Brown", UIColor.flatBrownColor()),
        ("Green", UIColor.flatForestGreenColor()),
        ("Gray", UIColor.flatGrayColor()),
        ("Green", UIColor.flatGreenColor()),
        ("Lime", UIColor.flatLimeColor()),
        ("Magenta", UIColor.flatMagentaColor()),
        ("Maroon", UIColor.flatMaroonColor()),
        ("Mint", UIColor.flatMintColor()),
        ("Orange", UIColor.flatOrangeColor()),
        ("Pink", UIColor.flatPinkColor()),
        ("PowderBlue", UIColor.flatPowderBlueColor()),
        ("Purple", UIColor.flatPurpleColor()),
        ("Red", UIColor.flatRedColor()),
        ("Teal", UIColor.flatTealColor()),
        ("Watermelon", UIColor.flatWatermelonColor()),
        ("Yellow", UIColor.flatYellowColor())
    ]
    
    let gradientColors: [(String, [UIColor])] = [
        ("Red/Purple", [UIColor.flatRedColor(), UIColor.flatPurpleColor()]),
        ("Blue/Green", [UIColor.flatMintColor(), UIColor.flatSkyBlueColor()]),
        ("Yellow/Orange", [UIColor.flatYellowColor(), UIColor.flatOrangeColor()]),
        ("Lime/Green", [UIColor.flatLimeColor(), UIColor.flatGreenColor()])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowNum = 0
        
        switch(mySegmentedControl.selectedSegmentIndex) {
        //flat colors
        case 0:
            rowNum = flatColors.count
            break
        case 1:
            rowNum = gradientColors.count
            break
            
        default:
            break
        }
        return rowNum
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("colorCell", forIndexPath: indexPath) as! ThemePickerCell
        
        switch(mySegmentedControl.selectedSegmentIndex) {
        case 0:
            cell.colorLabel.text = flatColors[indexPath.row].0
            cell.colorPreview.backgroundColor = flatColors[indexPath.row].1
            break
        case 1:
            cell.colorLabel.text = gradientColors[indexPath.row].0
            cell.colorPreview.backgroundColor = GradientColor(UIGradientStyle.TopToBottom, frame: view.frame, colors: gradientColors[indexPath.row].1)
            break
        default:
            break
        }
        return cell
    }
}
