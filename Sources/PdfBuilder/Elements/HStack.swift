#if os(OSX)
import AppKit
#else
import UIKit
#endif

extension Pdf {
    
    open class HStack: Grid {
        
        public init(_ items: [DocumentItem], separatorColor: AColor = .clear) {
            super.init(columns: [GridColumnWidth].init(repeating: .flexible, count: items.count), items: items, separatorColor: separatorColor)
        }
        
        public init(_ items: [DocumentItem], fixedFirstColumnWidth: CGFloat, separatorColor: AColor = .clear) {
            super.init(columns: [GridColumnWidth.fixed(v: fixedFirstColumnWidth)] + [GridColumnWidth].init(repeating: .flexible, count: items.count-1), items: items, separatorColor: separatorColor)
        }
    }
}
