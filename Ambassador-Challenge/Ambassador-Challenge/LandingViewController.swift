//
//  LandingViewController.swift
//  Ambassador-Challenge
//
//  Created by Jacob Dunahee on 6/17/15.
//  Copyright (c) 2015 Jacob Dunahee. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
    // IBOutlets
    @IBOutlet var lblLinkName : UILabel!
    @IBOutlet var lblUrl : UITextField!
    
    // Class Variables
    var linkName : String!
}


// MARK: LifeCycle
extension LandingViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        // Sets up formatted url string with given linkName
        var urlString = String(format: "www.engineeringChallenge.com/landing/?link=%@", linkName)
        lblLinkName.text = String(format: "%@!", linkName)
        lblUrl.text = urlString
    }
}
