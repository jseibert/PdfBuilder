import AppKit

extension Pdf {

    open class Background: DocumentItemAutoBreak {

        let color: NSColor
        let element: DocumentItem

        public init(color: NSColor, _ element: DocumentItem) {
            self.color = color
            self.element = element
        }

        open override func draw(rect: inout CGRect) {
            let tempRect = estimateDraw(rect: rect, elements: [element])

            var fillRect = rect
            fillRect.size.height = rect.height - tempRect.height

            color.setFill()
            let context = UIGraphicsGetCurrentContext()
            context?.fill(fillRect)

            element.draw(rect: &rect)
        }
    }

}
