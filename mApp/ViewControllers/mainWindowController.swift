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

class mainWindowController: NSWindowController, NSToolbarDelegate {
    
    //let ref = Firebase(url: "")
    @IBOutlet weak var Toolbar: NSToolbar!
    
    override func windowDidLoad() {
        super.windowDidLoad()
        window!.titleVisibility = .Hidden
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    
}