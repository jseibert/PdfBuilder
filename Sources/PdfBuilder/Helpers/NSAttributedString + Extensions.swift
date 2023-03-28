#if os(OSX)
import AppKit
#else
import UIKit
#endif

extension NSAttributedString {
    func bounds(withSize: CGSize) -> CGRect {
        return boundingRect(
            with: withSize,
            options: NSString.DrawingOptions.usesLineFragmentOrigin,
            context: nil)
    }
}

public extension Sequence where Iterator.Element == NSAttributedString {
    func joined(with separator: NSAttributedString) -> NSAttributedString {
        return self.reduce(NSMutableAttributedString()) {
            (r, e) in
            if r.length > 0 {
                r.append(separator)
            }
            r.append(e)
            return r
        }
    }

    func joined(with separator: String = "") -> NSAttributedString {
        return self.joined(with: NSAttributedString(string: separator))
    }
}
