//
//  ProfileImageView.swift
//  mApp
//
//  Created by Nafeh Shoaib on 2016-08-26.
//  Copyright © 2016 nafehshoaib. All rights reserved.
//

import Cocoa

@IBDesignable
class ProfileImageView: NSImageView {
    
    @IBInspectable var cornerRadius: CGFloat = 0
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        cornerRadius = self.bounds.width / 2
        layer?.cornerRadius = cornerRadius
        // Drawing code here.
    }
    
    func setProfilePic(firstName: String, lastName: String) {
        image = NSImage(named: firstName + Array(arrayLiteral: lastName)[0] + ".jpg")
    }
    
}
