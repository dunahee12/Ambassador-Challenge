//
//  ViewController.swift
//  Ambassador-Challenge
//
//  Created by Jacob Dunahee on 6/17/15.
//  Copyright (c) 2015 Jacob Dunahee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // IBOutlets
    @IBOutlet var tableView : UITableView!
    @IBOutlet var btnAdd : UIButton!
    
    // Class variables
    var savedLinkArray : NSArray!
    var selectedLink : Link!
}


// MARK: LifeCycle
extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Sets nav bar colors
        navigationController?.navigationBar.barTintColor = UIColor(red: 137/255, green: 52/255, blue: 43/255, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        // Creates local instance of coreData array
        savedLinkArray = CoreDataManager.getLinksFromCoreData()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.reloadData()
        
        // Gives the 'Add' button a floating appearance and sets colors
        self.btnAdd.layer.cornerRadius = self.btnAdd.frame.height/2
        self.btnAdd.layer.shadowOffset = CGSizeMake(5, 5)
        self.btnAdd.layer.shadowOpacity = 0.5
        self.btnAdd.setImage(self.btnAdd.imageView?.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate), forState: UIControlState.Normal)
        self.btnAdd.tintColor = UIColor.whiteColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        // Grabs coredata array and reloads table
        savedLinkArray = CoreDataManager.getLinksFromCoreData()
        tableView.reloadData()
    }
}


// MARK: UITableView 
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    // UITableView DataSource
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Returns contentView from headerCell in storyboard
        var headerCell = tableView.dequeueReusableCellWithIdentifier("headerCell") as! UITableViewCell
        headerCell.contentView.backgroundColor = UIColor(red: 178/255, green: 68/255, blue: 57/255, alpha: 1)
        return headerCell.contentView
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedLinkArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var linkCell = tableView.dequeueReusableCellWithIdentifier("linkCell") as! LinkCell
        // Gets current link from local array that matches tableview row
        var currentLink: Link = savedLinkArray[indexPath.row] as! Link 
        linkCell.setUpCellWithLink(currentLink, rowNum: indexPath.row)
        linkCell.delegate = self
        return linkCell
    }
    
    // UITableView Delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Sets selected link based on row index to set values for segue
        selectedLink = savedLinkArray[indexPath.row] as! Link
        self.performSegueWithIdentifier("landingSegue", sender: self)
    }
}


// MARK: Button Configs
extension ViewController {
    @IBAction func addButtonTapped() {
        // Sets selectedLink to nil if not already so in order to know if adding or editing link
        selectedLink = nil
        self.performSegueWithIdentifier("newLinkSegue", sender: self)
    }
}


// MARK: AddNewLinkViewController Delegate
extension ViewController: AddNewLinkDelegate {
    // Delegate function called when adding or editing link from AddViewController
    func newLinkSaved() {
        savedLinkArray = CoreDataManager.getLinksFromCoreData()
        tableView.reloadData()
    }
}


// MARK: LinkCell Delegate
extension ViewController: LinkCellDelegate {
    // Delegate called when link is deleted to reload table
    func deletedLink() {
        savedLinkArray = CoreDataManager.getLinksFromCoreData()
        tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Fade)
    }
    
    // Delegate called when link is edited to reload table
    func editTapped(linkToEdit: Link) {
        selectedLink = linkToEdit
        self.performSegueWithIdentifier("newLinkSegue", sender: self)
    }
}


// MARK: Navigation
extension ViewController {
    // Sets values for ViewControllers based on segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case "newLinkSegue":
            var controller = segue.destinationViewController as! AddNewLinkViewController
            controller.linkToEdit = selectedLink
            controller.delegate = self
        case "landingSegue":
            var controller = segue.destinationViewController as! LandingViewController
            controller.linkName = selectedLink.name
            var newOpenCount = selectedLink.openCount.integerValue + 1
            CoreDataManager.addNewLinkCount(selectedLink, count: newOpenCount)
        default:
            break
        }
    }
}











