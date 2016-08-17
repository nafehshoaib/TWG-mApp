//
//  OfficeMapOverlayView.swift
//  mApp
//
//  Created by Mehta on 2016-08-15.
//  Copyright © 2016 nafehshoaib. All rights reserved.
//

import Cocoa
import MapKit

class OfficeMapOverlayView: MKOverlayRenderer {
    var overlayImage: NSImage
    
    init(overlay:MKOverlay, overlayImage:NSImage) {
        self.overlayImage = overlayImage
        super.init(overlay: overlay)
    }
    
    override func drawMapRect(mapRect: MKMapRect, zoomScale: MKZoomScale, inContext context: CGContext) {
        
        var imageRect: CGRect = CGRectMake(0, 0, overlayImage.size.width, overlayImage.size.height)
        let imageReference = overlayImage.CGImageForProposedRect(&imageRect, context: nil, hints: nil)
        
        let theMapRect = overlay.boundingMapRect
        let theRect = rectForMapRect(theMapRect)
        
        
        CGContextScaleCTM(context, 1.0, -1.0)
        CGContextTranslateCTM(context, 0.0, -theRect.size.height)
        CGContextDrawImage(context, theRect, imageReference)
    }
}

