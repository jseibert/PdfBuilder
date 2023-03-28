#if os(OSX)
import AppKit
#else
import UIKit
#endif
import SwiftUI

extension Pdf {

    open class PageBackground: DocumentItem {

        open override func draw(rect: inout CGRect) {
            var fillRect = builder?.fullPageRect ?? .zero
            fillRect.origin.y = rect.minY
            backgroundColorFill.setFill()

            
            let context = UIGraphicsGetCurrentContext()
            context?.fill(fillRect)
        }
    }
}
