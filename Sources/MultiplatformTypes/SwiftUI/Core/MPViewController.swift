import SwiftUI

#if os(macOS)
public typealias MPViewController = NSViewController
#else
public typealias MPViewController = UIViewController
#endif
