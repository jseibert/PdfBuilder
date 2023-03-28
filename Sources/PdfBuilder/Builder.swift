#if os(OSX)
import AppKit
#else
import UIKit
#endif

extension Pdf {
    
    /// A4 Portrait Page
    public static let portraitPage = CGRect(x: 0, y: 0, width: 612, height: 792)
    
    /// A4 Landscape Page
    public static let landscapePage = CGRect(x: 0, y: 0, width: 792, height: 612)
    
    public class Builder: NSObject {
        private(set) var fullPageRect = CGRect.zero
        public var pageMargin = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)

        private var pageHeader: Pdf.PageHeader?
        public var pageCounter: PdfPageCounterProtocol?

        public var items = [DocumentItem]()
        
        private var pageStarted = false

        public func generateNewPdf(pageRect: CGRect = Pdf.portraitPage, progress: @escaping (Float) -> Void = {_ in }) -> NSMutableData {
            fullPageRect = pageRect
            
            let pdfData = beginPdfContextToData(pageRect: pageRect)
            appendPdf(progress: progress)
            endPdfContext()
            return pdfData
        }

        public func appendPdf(progress: @escaping (Float) -> Void = {_ in }) {

            var currentRect = fullPageRect

            //If page header not set then create first page
            if let item = items.first as? Pdf.PageHeader {
                pageHeader = item
            } else {
                currentRect = beginPage()
            }

            for (index, item) in items.enumerated() {
                progress(Float(index) / Float(items.count))

                if let item = item as? Pdf.PageHeader {
                    pageHeader = item
                    currentRect = beginPage()
                } else {
                    item.layout(rect: currentRect)
                    if item.shoudPageBreak(rect: currentRect) {
                        endPage()
                        currentRect = beginPage()
                        item.layout(rect: currentRect)
                    }
                    item.draw(rect: &currentRect)
                }
            }
        }
        
        private func beginPage() -> CGRect {
            pageStarted = true
            beginPdfPage()
            
            if let pageCounter = pageCounter {
                pageCounter.pageNumber += 1
            }
            
            var page = fullPageRect.inset(by: pageMargin)
            
            pageHeader?.draw(rect: &page)
            
            return page
        }
        
        private func endPage() {
            pageStarted = false
            Pdf.pdfContext?.endPDFPage()
        }
    }
}

extension Pdf.Builder {
    
    func beginPdfContextToData(pageRect: CGRect) -> NSMutableData {
        let pdfData = NSMutableData()
#if os(OSX)
        guard let pdfConsumer = CGDataConsumer(data: pdfData as CFMutableData),
              let pdfContext = CGContext(consumer: pdfConsumer, mediaBox: nil, nil) else {
            return pdfData
        }
        Pdf.pdfContext = pdfContext
        NSGraphicsContext.saveGraphicsState()
        NSGraphicsContext.current = NSGraphicsContext(cgContext: pdfContext, flipped: true)
#else
        UIGraphicsBeginPDFContextToData(pdfData, pageRect, nil)
#endif
        return pdfData
    }
    
    func endPdfContext() {
#if os(OSX)
        endPage()
        Pdf.pdfContext?.closePDF()
        NSGraphicsContext.restoreGraphicsState()
#else
        UIGraphicsEndPDFContext()
#endif
    }
    
    func beginPdfPage() {
        Pdf.log()
#if os(OSX)
        let pageInfo = [
               kCGPDFContextMediaBox: fullPageRect,
           ] as CFDictionary
        
        Pdf.pdfContext?.beginPDFPage(pageInfo)
        // Scale and translate to flip vertically
        Pdf.pdfContext?.translateBy(x: 0, y: fullPageRect.height)
        Pdf.pdfContext?.scaleBy(x: 1.0, y: -1.0)
#else
        UIGraphicsBeginPDFPage();
#endif
        
    }
}
