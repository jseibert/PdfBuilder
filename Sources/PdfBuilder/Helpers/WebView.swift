import SwiftUI
import WebKit

#if os(OSX)
struct WebView : NSViewRepresentable {
    
    let data: Data
    let mimeType: String
    
    func makeNSView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    
    func updateNSView(_ uiView: WKWebView, context: Context) {
        
        uiView.load(data,
                    mimeType: mimeType,
                    characterEncodingName: "utf8",
                    baseURL: Bundle.main.bundleURL)
    }
    
}
#else
struct WebView : UIViewRepresentable {
    
    let data: Data
    let mimeType: String
    
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
        uiView.load(data,
                    mimeType: mimeType,
                    characterEncodingName: "utf8",
                    baseURL: Bundle.main.bundleURL)
    }
    
}
#endif

struct WebView_Previews : PreviewProvider {
    static var previews: some View {
        WebView(data: Data(), mimeType: "image/png")
    }
}
