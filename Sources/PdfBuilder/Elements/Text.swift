import AppKit

extension Pdf {
    
    open class Text: DocumentItemAutoBreak {
        
        let text: NSAttributedString
        var _padding: CGFloat = 2
        
        public init(_ text: String, attributes: StringAttributes = StringAttributes(), backgroundColor: NSColor? = nil) {
            self.text = NSAttributedString(
                string: text,
                attributes: attributes)
            super.init()
            self.backgroundColorFill = backgroundColor ?? .clear
        }
        
        public init(_ text: NSAttributedString, backgroundColor: NSColor? = nil) {
            self.text = text
            super.init()
            self.backgroundColorFill = backgroundColor ?? .clear
        }
        
        open override func draw(rect: inout CGRect) {
            let textRect = rect.insetBy(dx: _padding, dy: _padding)
            let textBounds = text.bounds(withSize: textRect.size)
  
            text.draw(in: textRect)
            
            let height = textBounds.height + 2 * _padding
            rect.origin.y += height
            rect.size.height -= height
        }
        
//        open func padding__(_ value: CGFloat) -> Self {
//            _padding = value
//            return self
//        }
    }
}



