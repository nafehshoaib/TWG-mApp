//
//  LoginViewController.swift
//  mApp
//
//  Created by Mehta on 2016-08-15.
//  Copyright © 2016 nafehshoaib. All rights reserved.
//

import Cocoa

class LoginViewController: NSViewController {

    @IBAction func Gmail(sender: AnyObject) {
    }
    
    @IBAction func Slack(sender: AnyObject) {
    }
    
    @IBAction func GetStarted(sender: AnyObject) {
        let profileVC = storyboard?.instantiateControllerWithIdentifier("ProfileVC") as! ProfileViewController
        view.window?.contentViewController = profileVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    /* Use when doing the if and else login functionality linked to the map
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject!){
        
    }
    */
    
}
