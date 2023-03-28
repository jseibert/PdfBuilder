#if os(OSX)
import AppKit
#else
import UIKit
#endif
import AVFoundation

extension Pdf {

    open class Image: DocumentItemAutoBreak {
        let image: AImage?
        let fixedSize: CGSize?
        let circle: Bool
        
        // TODO: create shapes if need more then circle
        public init(_ image: AImage?, size: CGSize? = nil, circle: Bool = false) {
            self.image = image
            self.fixedSize = size
            self.circle = circle
        }
        
        open override func draw(rect: inout CGRect) {
            var size = fixedSize ?? .zero
            
            if let image = image, fixedSize == nil {
                size = CGSize(
                    width: rect.width,
                    height: rect.width / image.size.width * image.size.height )
            }
            
            Pdf.log("size: \(size)")
            
            let tempRect = CGRect(
                x: rect.minX + ((rect.maxX - rect.minX) - size.width) / 2,
                y: rect.minY,
                width: size.width,
                height: size.height)
            
            let context = UIGraphicsGetCurrentContext()
            if circle {
                UIBezierPath(roundedRect: tempRect, cornerRadius: tempRect.width / 2).addClip()
            }
            
            let imgRect = AVMakeRect(
                aspectRatio: image?.size ?? .zero,
                insideRect: tempRect)
            
            
#if os(OSX)
            if let image {
                // TODO: Drawing SFSymbol produces black rectangle
                let upscaleSize = CGSize(width: image.size.height * 3, height: image.size.width * 3)
                let img = Pdf.drawImage(size: upscaleSize) {
                    image.draw(in: NSRect(origin: .zero, size: upscaleSize))
                }
                img?.draw(in: imgRect)
            }
#else
            image?.draw(in: imgRect)
#endif
            
            context?.resetClip()
            
            rect.origin.y += tempRect.height
            if tempRect.height > rect.size.height {
                rect.size.height = 0
            } else {
                rect.size.height -= tempRect.height
            }
        }
    }
}


