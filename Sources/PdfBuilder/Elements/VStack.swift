import AppKit

extension Pdf {

    open class VStack: Grid {

        public init(_ items: [DocumentItem], separatorColor: NSColor = .clear) {
            super.init(columns: [.flexible], items: items, separatorColor: separatorColor)
        }
    }
}
