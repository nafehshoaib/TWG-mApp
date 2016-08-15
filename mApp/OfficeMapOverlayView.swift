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
    /*
    override func drawMapRect(mapRect: MKMapRect, zoomScale: MKZoomScale, inContext context: NSGraphicsContext) {
        
        let theMapRect = overlay.boundingMapRect
        let theRect = rectForMapRect(theMapRect)
        let imageReference = overlayImage.CGImageForProposedRect(, context: context, hints: nil)
        
        CGContextScaleCTM(context.CGContext, 1.0, -1.0)
        CGContextTranslateCTM(context.CGContext, 0.0, -theRect.size.height)
        CGContextDrawImage(context.CGContext, theRect, imageReference)
    }
 */
}

