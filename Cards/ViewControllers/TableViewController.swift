//
//  TableViewController.swift
//  Cards
//
//  Created by Roland Shen on 7/5/16.
//  Copyright © 2016 Roland Shen. All rights reserved.
//

import UIKit
import Foundation
import ChameleonFramework
import RealmSwift
import DZNEmptyDataSet

class TableViewController: UITableViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    var cards: Results<Card>! {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.whiteColor()
        //setting up empty data set
        tableView.tableFooterView = UIView()
        cards = RealmHelper.getCards()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()
    }
    
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "You don't have any cards!"
        let changes = [NSForegroundColorAttributeName : UIColor.blackColor()]

        return NSAttributedString(string: str, attributes: changes)
    }
    
    func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "Let's start by creating one."
        let attrs = [NSForegroundColorAttributeName : UIColor.blackColor()]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "cardlogo")
    }
    
    func buttonTitleForEmptyDataSet(scrollView: UIScrollView!, forState state: UIControlState) -> NSAttributedString! {
        let str = "Add Card"
        let multipleAttrs = [NSForegroundColorAttributeName: UIColor.blackColor()]
        return NSAttributedString(string: str, attributes: multipleAttrs)
    }
    
    func emptyDataSetDidTapButton(scrollView: UIScrollView!) {
        performSegueWithIdentifier("addCard", sender: self)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(cards != nil) {
            return cards.count
        }
        else {
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cardCell", forIndexPath: indexPath) as! TableViewCell
        let row = indexPath.row
        let card = cards[row]
        
        // setting profile pic
        let image: UIImage = UIImage(named: "default")!
        cell.picture.layer.cornerRadius = cell.picture.frame.size.width / 2;
        cell.picture.clipsToBounds = true
        cell.picture.image = image
        cell.name.text = card.name
        cell.job.text = card.job
        cell.picture.image = UIImage(data: card.imageData, scale:1.0)
        cell.email.text = card.email
        cell.phone.text = card.phoneNum
        
        //round cell corners
        cell.cardView.layer.cornerRadius = 15
        cell.cardView.layer.masksToBounds = true
        
        cell.cardView.backgroundColor = UIColor(hexString: card.theme as String)
        
        //text color
        cell.name.textColor = UIColor(contrastingBlackOrWhiteColorOn: cell.cardView.backgroundColor, isFlat: true)
        cell.job.textColor = UIColor(contrastingBlackOrWhiteColorOn: cell.cardView.backgroundColor, isFlat: true)
        cell.email.textColor = UIColor(contrastingBlackOrWhiteColorOn: cell.cardView.backgroundColor, isFlat: true)
        cell.phone.textColor = UIColor(contrastingBlackOrWhiteColorOn: cell.cardView.backgroundColor, isFlat: true)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let card = cards[indexPath.row]
        if editingStyle == .Delete {
            RealmHelper.deleteCard(card)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            tableView.reloadData()
        }
    }
    
    @IBAction func unwindToTableViewController(segue: UIStoryboardSegue) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == "displayCard" {
                print("Table view cell tapped")
                let indexPath = tableView.indexPathForSelectedRow!
                let card = cards[indexPath.row]
                let displayCard = segue.destinationViewController as! NewCardController
                displayCard.card = card
            }
            else if identifier == "viewThemePicker" {
                //do nothing
            }
        }
    }
}
