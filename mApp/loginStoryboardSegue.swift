//
//  loginStoryboardSegue.swift
//  mApp
//
//  Created by Nafeh Shoaib on 2016-08-15.
//  Copyright © 2016 nafehshoaib. All rights reserved.
//

import Cocoa

class loginStoryboardSegue: NSStoryboardSegue {
    override init(identifier: String, source sourceController: AnyObject, destination destinationController: AnyObject) {
        super.init(identifier: "login", source: sourceController, destination: destinationController)
    }
    
    override func perform() {
        sourceController.presentViewControllerAsSheet(destinationController as! NSViewController)
    }
}
