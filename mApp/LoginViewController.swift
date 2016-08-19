//
//  LoginViewController.swift
//  mApp
//
//  Created by Mehta on 2016-08-15.
//  Copyright © 2016 nafehshoaib. All rights reserved.
//

import Cocoa
import Firebase
import GTMOAuth2

class LoginViewController: NSViewController {
    
    let ref = Firebase(url: "https://xyz.firebaseio.com")

    @IBAction func Gmail(sender: AnyObject) {
        let myWindow = self.view.window as! mainWindowController
        myWindow.loadGoogle()
    }
    
    @IBAction func Slack(sender: AnyObject) {
    }
    
    @IBAction func GetStarted(sender: AnyObject) {
        let profileVC = storyboard?.instantiateControllerWithIdentifier("ProfileVC") as! ProfileViewController
        view.window?.contentViewController = profileVC
        isLoggedIn = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

    /* Use when doing the if and else login functionality linked to the map
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject!){
        
    }
    */
