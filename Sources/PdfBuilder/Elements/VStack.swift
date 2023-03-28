#if os(OSX)
import AppKit
#else
import UIKit
#endif

extension Pdf {

    open class VStack: Grid {

        public init(_ items: [DocumentItem], separatorColor: AColor = .clear) {
            super.init(columns: [.flexible], items: items, separatorColor: separatorColor)
        }
    }
}
