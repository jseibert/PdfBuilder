#if os(OSX)
import AppKit
#else
import UIKit
#endif
import AVFoundation

extension Pdf {
    
    public enum Shape {
        case circle
        case roundedRect(radius: CGFloat)
    }

    open class ClipShape: DocumentItemAutoBreak {

        let shape: Shape
        let element: DocumentItem

        public init(_ shape: Shape, _ element: DocumentItem) {
            self.shape = shape
            self.element = element
        }

        open override func draw(rect: inout CGRect) {
            let tempRect = estimateDraw(rect: rect, elements: [element])

            var fillRect = rect
            fillRect.size.height = rect.height - tempRect.height

            let context = UIGraphicsGetCurrentContext()
            switch shape {
                
            case .circle:
                let clipRect = AVMakeRect(
                    aspectRatio: CGSize(width: 1, height: 1),
                    insideRect: fillRect)
                UIBezierPath(roundedRect: clipRect, cornerRadius: clipRect.width / 2).addClip()
                
            case .roundedRect(let radius):
                UIBezierPath(roundedRect: fillRect, cornerRadius: radius).addClip()
            }
            context?.clip()

            element.draw(rect: &rect)
            
            context?.resetClip()
        }
    }

}
