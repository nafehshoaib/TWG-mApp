//
//  EmployeeView.swift
//  mApp
//
//  Created by Nafeh Shoaib on 2016-08-25.
//  Copyright © 2016 nafehshoaib. All rights reserved.
//

import Cocoa
import MapKit

class EmployeeView: NSView {
    
    var email = ""
    @IBOutlet var name: NSTextField?
    @IBOutlet var position: NSTextField?
    @IBOutlet var skills: NSTextField?
    @IBOutlet var interests: NSTextField?
    @IBOutlet var imageView: ProfileImageView?
    
    @IBAction func emailButton(sender: NSButton) {
        let mailToAddress = "mailto:" + email
        NSWorkspace.sharedWorkspace().openURL(NSURL(string: mailToAddress)!)
    }
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        // Drawing code here.
    }
    
    func instantiateFromNib() -> NSView {
        var views: NSArray? = []
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = NSNib(nibNamed: String(self.dynamicType), bundle: bundle)!
        nib.instantiateWithOwner(self, topLevelObjects: views)
        
        var view: EmployeeView!
        
        for object: AnyObject in views! {
            
            if let obj = object as? EmployeeView {
                view = obj
                break
            }
        }
        return view
    }
}
