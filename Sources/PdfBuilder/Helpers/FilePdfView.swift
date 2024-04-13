#if os(OSX)
import AppKit
import PDFKit
#else
import UIKit
#endif
import SwiftUI


public struct FilePdfView: View {
    let pdfData: Data
    
    public init(pdfData: Data) {
        self.pdfData = pdfData
    }
    
#if os(OSX)
    public var body: some View {
        PDFKitView(data: pdfData)
    }
#else
    public var body: some View {
        WebView(data: pdfData, mimeType: "application/pdf")
    }
#endif
}

struct FileImageView: View {
    let image: Image
    
    var body: some View {
        image.resizable().aspectRatio(contentMode: .fit)
    }
}

#if os(OSX)
struct PDFKitView: NSViewRepresentable {
    let data: Data
    
    func makeNSView(context: NSViewRepresentableContext<PDFKitView>) -> PDFView {
        // Creating a new PDFVIew and adding a document to it
        let pdfView = PDFView()
        pdfView.document = PDFDocument(data: data)
        return pdfView
    }
    
    func updateNSView(_ uiView: PDFView, context: NSViewRepresentableContext<PDFKitView>) {
        // we will leave this empty as we don't need to update the PDF
    }
}
#endif
