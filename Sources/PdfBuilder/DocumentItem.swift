#if os(OSX)
import AppKit
#else
import UIKit
#endif

open class DocumentItem: NSObject {
    
    weak var builder: Pdf.Builder?

    open var debugIdentifier: String?

    open var backgroundColorFill: AColor = .clear

    open func layout(rect: CGRect) {

    }

    open func shoudPageBreak(rect: CGRect) -> Bool {
        return false
    }

    open func draw(rect: inout CGRect) {

    }

    open func backgroundColor(_ color: AColor?) -> Self {
        backgroundColorFill = color ?? .clear
        return self
    }
    
    open func estimateDraw(rect: CGRect, elements: [DocumentItem]) -> CGRect {
        Pdf.isEstimating = true
        var tempRect = rect
        let img = Pdf.drawImage(size: rect.size) {
            for item in elements {
                item.draw(rect: &tempRect)
            }
        }
        Pdf.isEstimating = false
        return tempRect
    }
}

open class DocumentItemAutoBreak: DocumentItem {

    //TODO: Review page break logic, to find
    open override func shoudPageBreak(rect: CGRect) -> Bool {
        Pdf.isEstimating = true
        var tempRect = rect
        let img = Pdf.drawImage(size: CGSize(width: rect.maxX, height: rect.maxY)) {
            draw(rect: &tempRect)
        }
        Pdf.isEstimating = false
        let should = tempRect.origin.y > rect.maxY || rect.height < 10 //|| tempRect.height == 0
        Pdf.log(should)
        return should
    }
}
