#if os(OSX)
import AppKit
#else
import UIKit
#endif

extension Pdf {
    open class PageBreak: DocumentItem {
        
        open override func shoudPageBreak(rect: CGRect) -> Bool {
            return true
        }
        
    }
}


