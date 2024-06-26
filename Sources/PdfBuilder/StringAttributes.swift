import AppKit

public typealias StringAttributes = [NSAttributedString.Key : Any]

public func + (left: StringAttributes, right: StringAttributes) -> StringAttributes {
    var left = left
    for element in right {
        left[element.key] = element.value
    }
    return left
}

public extension StringAttributes {
    
    static func light(_ size: CGFloat = 10) -> StringAttributes {[
        .foregroundColor: NSColor.black,
        .font: NSFont.systemFont(ofSize: size, weight: .light),
    ]}
    
    static func title() -> StringAttributes {[
        .foregroundColor: NSColor.black,
        .font: NSFont.systemFont(ofSize: 14, weight: .bold),
    ]}
    
    static func title2() -> StringAttributes {[
        .foregroundColor: NSColor.black,
        .font: NSFont.systemFont(ofSize: 12, weight: .bold),
    ]}
    
    static func regular() -> StringAttributes {[
        .foregroundColor: NSColor.black,
        .font: NSFont.systemFont(ofSize: 10, weight: .regular)
    ]}
    
    static func bold() -> StringAttributes {[
        .foregroundColor: NSColor.black,
        .font: NSFont.systemFont(ofSize: 10, weight: .bold)
    ]}
    
    static func italic() -> StringAttributes {[
        .foregroundColor: NSColor.black,
        .font: NSFont.italicSystemFont(ofSize: 10)
    ]}
    
    static func caption() -> StringAttributes {[
        .foregroundColor: NSColor.black,
        .font: NSFont.systemFont(ofSize: 7, weight: .light)
    ]}
    
    static func boldRed() -> StringAttributes {[
        .foregroundColor: NSColor.red,
        .font: NSFont.systemFont(ofSize: 10, weight: .bold)
    ]}
    
    static func alignment(_ alignment: NSTextAlignment) -> StringAttributes {
        let style = NSMutableParagraphStyle()
        style.alignment = alignment
        return [.paragraphStyle: style]
    }
    
    static func lineHeight(_ height: CGFloat) -> StringAttributes {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = height
        return [.paragraphStyle: style]
    }
    
    static func foregroundColor(_ color: NSColor) -> StringAttributes {[
        .foregroundColor: color
    ]}
    
    func title() -> StringAttributes { self + Self.title() }
    func title2() -> StringAttributes { self + Self.title2() }
    func bold() -> StringAttributes { self + Self.bold() }
    func italic() -> StringAttributes { self + Self.italic() }
    func caption() -> StringAttributes { self + Self.caption() }
    func boldRed() -> StringAttributes { self + Self.boldRed() }
    
    func light(_ size: CGFloat = 10) -> StringAttributes { self + Self.light(size) }
    func lineHeight(_ height: CGFloat) -> StringAttributes { self + Self.lineHeight(height) }
    func alignment(_ alignment: NSTextAlignment) -> StringAttributes { self + Self.alignment(alignment) }
    func foregroundColor(_ color: NSColor) -> StringAttributes { self + Self.foregroundColor(color) }
}

