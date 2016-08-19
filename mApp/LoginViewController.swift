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

let scopes: [String] = [
    "openid",
    "https://www.googleapis.com/auth/calendar.readonly",
]

class LoginViewController: NSViewController {
    
    let ref = Firebase(url: "https://xyz.firebaseio.com")

    @IBAction func Gmail(sender: AnyObject) {
        loadGoogle()
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
    
    func loadGoogle() {
        let frameworkBundle = NSBundle(forClass: GTMOAuth2WindowController.self)
        let windowController = GTMOAuth2WindowController(scope: "" , clientID: "197820099549-60u0q5sttaacio87tl4umaik1tob49ls.apps.googleusercontent.com", clientSecret: "zwTPJEKyWrCiGgC_DOCYNALJ", keychainItemName: "mApps: Google", resourceBundle: frameworkBundle)
        
        windowController.signInSheetModalForWindow(self.view.window, delegate: self, finishedSelector: #selector(LoginViewController.didFinishWithAuth(windowController:auth:error:)))
    }
    
    func didFinishWithAuth(windowController wc:GTMOAuth2WindowController, auth: GTMOAuth2Authentication, error: NSError?) {
        if error != nil {
            print(error)
            isLoggedIn = false
        } else {
            print(auth)
            isLoggedIn = true
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
