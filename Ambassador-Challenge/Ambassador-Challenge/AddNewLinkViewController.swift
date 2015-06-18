//
//  AddNewLinkViewController.swift
//  Ambassador-Challenge
//
//  Created by Jacob Dunahee on 6/17/15.
//  Copyright (c) 2015 Jacob Dunahee. All rights reserved.
//

import UIKit

protocol AddNewLinkDelegate {
    func newLinkSaved()
}

class AddNewLinkViewController: UIViewController {
    // IBOutlets
    @IBOutlet var lblTilte : UILabel!
    @IBOutlet var tfNewLink : UITextField!
    @IBOutlet var btnSave : UIButton!
    @IBOutlet var btnCancel : UIButton!
    @IBOutlet var masterView : UIView!
    
    // Class Variables
    var delegate : AddNewLinkDelegate!
    var linkToEdit : Link?
}


// MARK: LifeCycle
extension AddNewLinkViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Checks what to set title to based on whether link is nil or not -- IF NIL THEN IT WILL CREATE NEW
        if linkToEdit != nil {
            lblTilte.text = linkToEdit?.name
            tfNewLink.text = linkToEdit?.name
        }
        
        // Sets corner radius' for certain subviews
        masterView.layer.cornerRadius = 5
        btnSave.layer.cornerRadius = btnSave.frame.height/2
        btnCancel.layer.cornerRadius = btnCancel.frame.height/2
    }
}


// MARK: Button Configs
extension AddNewLinkViewController {
    @IBAction func saveNewLink() {
        // Checks if textField is filled out
        if tfNewLink.text.isEmpty == false {
            // Checks whether to edit or save new
            if linkToEdit == nil {
                var valueDict : NSDictionary = ["name": tfNewLink.text, "openCount": 0]
                CoreDataManager.saveLinkToCoreDataWithValues(valueDict)
            } else {
                CoreDataManager.editLinkName(linkToEdit!, newName: tfNewLink.text)
            }
            
            // Delegate is called so ViewController will refetch coredata and reload tableView
            delegate.newLinkSaved()
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            var emptyAlert = UIAlertView(title: "Cannot Save", message: "The link name field must be filled out before saving.", delegate: nil, cancelButtonTitle: "Okay")
            emptyAlert.show()
        }
    }
    
    @IBAction func cancelBtnTapped() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
