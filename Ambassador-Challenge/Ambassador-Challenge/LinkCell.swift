//
//  LinkCell.swift
//  Ambassador-Challenge
//
//  Created by Jacob Dunahee on 6/17/15.
//  Copyright (c) 2015 Jacob Dunahee. All rights reserved.
//

import UIKit

// Delegate protocol
protocol LinkCellDelegate {
    func deletedLink()
    func editTapped(linkToEdit: Link)
}

class LinkCell: UITableViewCell {
    // IBOutlets
    @IBOutlet var lblLinkName : UILabel!
    @IBOutlet var lblCountNum : UILabel!
    
    // Class Variables
    var currentLink : Link!
    var delegate : LinkCellDelegate!
}


// MARK: Init Functions
extension LinkCell {
    func setUpCellWithLink(link: Link, rowNum: Int) {
        currentLink = link
        
        // Sets labels in cell
        lblLinkName.text = link.name
        lblCountNum.text = link.openCount.stringValue
        
        // Sets background either grey or white based on odd or even row index
        if rowNum % 2 == 1 {
            backgroundColor = UIColor(white: 0.9, alpha: 1)
        }
    }
}


// MARK: Button Configs
extension LinkCell {
    @IBAction func deleteTapped() {
        // Deletes link and triggers delegate
        CoreDataManager.deleteLink(currentLink)
        delegate.deletedLink()
    }
    
    @IBAction func editTapped() {
        // Triggers delegate function for editing link
        delegate.editTapped(currentLink)
    }
}
