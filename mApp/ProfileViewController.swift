//
//  ProfileViewController.swift
//  mApp
//
//  Created by Mehta on 2016-08-15.
//  Copyright © 2016 nafehshoaib. All rights reserved.
//

import Cocoa

class ProfileViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func interestsSelection (sender: NSButton) {

    }
    
    @IBAction func FinishButton(sender: AnyObject) {
        dismissController(self)
    }

}
