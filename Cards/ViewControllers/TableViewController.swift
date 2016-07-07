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
import DZNEmptyDataSet
import RealmSwift

class TableViewController: UITableViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    var cards: Results<Card>! {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        let gradient: [UIColor] = [UIColor.flatMintColor(),UIColor.flatSkyBlueColor()]
        self.view.backgroundColor = GradientColor(UIGradientStyle.TopToBottom, frame: view.frame, colors: gradient)
        //setting up empty data set
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()
        cards = RealmHelper.getCards()
    }
    
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "You don't have any cards!"
        let changes = [NSForegroundColorAttributeName : UIColor.whiteColor()]

        return NSAttributedString(string: str, attributes: changes)
    }
    
    func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "Let's start by creating one."
        let attrs = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "cardlogo")
    }
    
    func buttonTitleForEmptyDataSet(scrollView: UIScrollView!, forState state: UIControlState) -> NSAttributedString! {
        let str = "Add Card"
        let multipleAttrs = [NSForegroundColorAttributeName: UIColor.whiteColor()]
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
            return 0
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
        
        //text color
        cell.name.textColor = UIColor(contrastingBlackOrWhiteColorOn: view.backgroundColor, isFlat: true)
        cell.job.textColor = UIColor(contrastingBlackOrWhiteColorOn: view.backgroundColor, isFlat: true)
        
        //setting that cell's view
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let viewCard: ViewCardController = storyboard.instantiateViewControllerWithIdentifier("ViewCard") as! ViewCardController
//        viewCard.photo.image = UIImage(data: card.imageData, scale: 1.0)
//        viewCard.name.text = card.name
//        viewCard.job.text = card.job
//        viewCard.email.text = card.email
//        viewCard.phone.text = card.phoneNum
        
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
        }
}
