//
//  LoginViewController.swift
//  mApp
//
//  Created by Mehta on 2016-08-15.
//  Copyright © 2016 nafehshoaib. All rights reserved.
//

import Cocoa
import FirebaseOSX
import GTMOauth2

class LoginViewController: NSViewController {
    
    let ref = Firebase(url: "https://xyz.firebaseio.com")

    @IBAction func Gmail(sender: AnyObject) {
        let frameworkBundle = NSBundle(forClass: GTMOAuth2WindowController.self)
        
        let windowController = GTMOAuth2WindowController(scope: "", clientID: clientID, clientSecret: clientSecret, keychainItemName: keychainName, resourceBundle: frameworkBundle)
        windowController.signInSheetModalForWindow(window, delegate: self, finishedSelector: #selector(mainWindowController.didFinishWithAuth(windowController:auth:error:)))

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
    
    func didFinishWithAuth(windowController wc:GTMOAuth2WindowController, auth: GTMOAuth2Authentication, error: NSError?) {
        if error != nil {
            print(error)
        } else {
            print(auth)
            ref.authWithOAuthProvider("google", token: auth.accessToken, withCompletionBlock: { err, auth in
                if err != nil {
                    print(err)
                } else {
                    print(auth)
                }
            })
        }
    }
}

    /* Use when doing the if and else login functionality linked to the map
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject!){
        
    }
    */
