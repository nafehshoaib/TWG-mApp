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
    
    override func viewWillAppear() {
        
    }
    
    @IBAction func interestsSelection (sender: NSButton) {

    }
    
    @IBAction func FinishButton(sender: AnyObject) {
        self.view.window!.close()
    }

    @IBAction func Back(sender: AnyObject) {
        //dismissController(LoginViewController)
        let loginVC = storyboard?.instantiateControllerWithIdentifier("loginVC") as! LoginViewController
        view.window?.contentViewController = loginVC
    }
    
}
