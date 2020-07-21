import SwiftUI

#if os(macOS)
public typealias MPView = NSView
#else
public typealias MPView = UIView
#endif

#if os(macOS)
public extension MPView {
    var alpha: CGFloat {
        get { alphaValue }
        set { alphaValue = newValue }
    }
}
#endif
