#if os(OSX)
import AppKit
#else
import UIKit
#endif
import SwiftUI


public struct FilePdfView: View {
    let pdfData: Data
    
    public init(pdfData: Data) {
        self.pdfData = pdfData
    }
    
    public var body: some View {
        WebView(data: pdfData, mimeType: "application/pdf")
    }
}

struct FileImageView: View {
    let image: Image
    
    var body: some View {
        image.resizable().aspectRatio(contentMode: .fit)
    }
}
