#if os(OSX)
import AppKit
#else
import UIKit
#endif

extension Pdf {

    open class Padding: DocumentItemAutoBreak {

        let size: CGSize
        let element: DocumentItem

        public init(equal size: CGFloat, _ element: DocumentItem) {
            self.size = .init(width: size, height: size)
            self.element = element
        }
        
        public init(size: CGSize, _ element: DocumentItem) {
            self.size = size
            self.element = element
        }

        open override func draw(rect: inout CGRect) {
            var insetRect = rect.insetBy(dx: size.width, dy: size.height)

            element.draw(rect: &insetRect)
            let height = rect.height - insetRect.height
            rect.origin.y += height
            rect.size.height -= height
        }
    }

}
