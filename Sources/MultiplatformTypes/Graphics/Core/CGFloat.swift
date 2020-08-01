import CoreGraphics
#if canImport(UIKit)
import UIKit
#endif

public extension CGFloat {
    static let onePixel: CGFloat = {
        #if os(macOS)
        return 0.5
        #else
        return 1.0 / UIScreen.main.scale
        #endif
    }()
}
