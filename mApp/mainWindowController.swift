//
//  mainWindowController.swift
//  mApp
//
//  Created by Nafeh Shoaib on 2016-08-09.
//  Copyright © 2016 nafehshoaib. All rights reserved.
//

import Cocoa
//import Firebase
import GTMOAuth2

class mainWindowController: NSWindowController {
    
    //let ref = Firebase(url: "")
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        window!.titleVisibility = .Hidden
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    func loadGoogle() {
        let frameworkBundle = NSBundle(forClass: GTMOAuth2WindowController.self)
        let windowController = GTMOAuth2WindowController(scope: "", clientID: "", clientSecret: "", keychainItemName: "", resourceBundle: frameworkBundle)
        windowController.signInSheetModalForWindow(window, delegate: self, finishedSelector: #selector(mainWindowController.didFinishWithAuth(windowController:auth:error:)))
    }
    
    func didFinishWithAuth(windowController wc:GTMOAuth2WindowController, auth: GTMOAuth2Authentication, error: NSError?) {
        if error != nil {
            print(error)
        } else {
            print(auth)
            //ref.authWithOAuthProvider("google", token: auth.accessToken, withCompletionBlock: { err, auth in
               /* if err != nil {
                    print(err)
                } else {
                    print(auth)
                }
            }) */
        }
    }
}