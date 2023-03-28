#if os(OSX)
import AppKit
#else
import UIKit
#endif

extension Pdf {
    
    open class Text: DocumentItemAutoBreak {
        
        let text: NSAttributedString
        var _padding: CGFloat = 2
        
        public init(_ text: String, attributes: StringAttributes = StringAttributes(), backgroundColor: AColor? = nil) {
            self.text = NSAttributedString(
                string: text,
                attributes: attributes)
            super.init()
            self.backgroundColorFill = backgroundColor ?? .clear
        }
        
        public init(_ text: NSAttributedString, backgroundColor: AColor? = nil) {
            self.text = text
            super.init()
            self.backgroundColorFill = backgroundColor ?? .clear
        }
        
        open override func draw(rect: inout CGRect) {
            Pdf.log(text.string)
            
            let textRect = rect.insetBy(dx: _padding, dy: _padding)
            let textBounds = text.bounds(withSize: textRect.size)

            let options: NSString.DrawingOptions = [
                .usesLineFragmentOrigin,
                .truncatesLastVisibleLine
            ]
            //text.draw(in: textRect, options: options)
            text.draw(with: textRect, options: options, context: nil)
            
            let height = textBounds.height + 2 * _padding
            rect.origin.y += height
            rect.size.height -= height
        }
    }
}



