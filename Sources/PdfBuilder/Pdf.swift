#if os(OSX)

import AppKit
public typealias AColor = NSColor
public typealias AImage = NSImage

typealias UIFont = NSFont
public typealias UIEdgeInsets = NSEdgeInsets
typealias UIBezierPath = NSBezierPath

func UIGraphicsGetCurrentContext() -> CGContext? {
    Pdf.pdfContext
}


extension NSBezierPath {
    convenience init(roundedRect: CGRect, cornerRadius: CGFloat) {
        self.init(roundedRect: roundedRect, xRadius: cornerRadius, yRadius: cornerRadius)
    }
}

extension NSImage {
    convenience init(systemName: String) {
        self.init(systemSymbolName: systemName, accessibilityDescription: nil)!
    }
}

extension UIFont {
    
    static func italicSystemFont(ofSize fontSize: CGFloat) -> NSFont {
        let systemFont = NSFont.systemFont(ofSize: fontSize)
        
        // Create a font descriptor with the italic trait
        let fontDescriptor = systemFont.fontDescriptor.withSymbolicTraits(.italic)
        
        // Create a font from the descriptor
        let italicSystemFont = NSFont(descriptor: fontDescriptor, size: fontSize)
        
        return italicSystemFont ?? systemFont // Return italic font or fallback to system font
    }
}

extension NSRect {
    func inset(by insets: NSEdgeInsets) -> NSRect {
        var rect = self
        rect.origin.x += insets.left
        rect.origin.y += insets.top
        rect.size.width -= (insets.left + insets.right)
        rect.size.height -= (insets.top + insets.bottom)
        return rect
    }
}

#else

import UIKit
public typealias AColor = UIColor
public typealias AImage = UIImage

extension NSString {
    typealias DrawingOptions = NSStringDrawingOptions
}

#endif


public enum Pdf {
    
    static var pdfContext: CGContext?
    
    // MARK: Color Helpers
    
    public static let separatorColor = AColor(white: 0, alpha: 0.2)
    
    // MARK: Logging
    
    public static var logEnabled = true
    
    static var isEstimating = false
    
    public static func log(_ msg: Any? = nil, function: String = #function, file: String = #file, line: Int = #line) {
        if logEnabled, !isEstimating {
            print("📘 \(makeTag(function: function, file: file, line: line)) 💡 \(msg ?? "-")")
        }
    }
    
    private static func makeTag(function: String, file: String, line: Int) -> String {
        let className = NSURL(fileURLWithPath: file).lastPathComponent ?? file
        return "\(className) 👉 \(function) ➡ \(line)"
    }
    
    // MARK: Drawing helper
    
    @discardableResult
    public static func drawImage(size: CGSize, block: () -> Void) -> AImage? {
        
#if os(OSX)
        guard let bitmap = NSBitmapImageRep(
            bitmapDataPlanes: nil,
            pixelsWide: Int(size.width),
            pixelsHigh: Int(size.height),
            bitsPerSample: 8,
            samplesPerPixel: 4,
            hasAlpha: true,
            isPlanar: false,
            colorSpaceName: .calibratedRGB,
            bytesPerRow: 0,
            bitsPerPixel: 0) else {
            return nil
        }
        
        guard let context = NSGraphicsContext(bitmapImageRep: bitmap) else {
            return nil
        }
        
        NSGraphicsContext.saveGraphicsState()
        NSGraphicsContext.current = context
        
        block()
        
        NSGraphicsContext.restoreGraphicsState()
        
        let img = NSImage(size: size)
        img.addRepresentation(bitmap)
#else
        UIGraphicsBeginImageContext(size)
        block()
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
#endif
        
        return img
    }
    
}
