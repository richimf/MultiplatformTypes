import SwiftUI

#if os(macOS)
public typealias MPHostingController = NSHostingController
#else
public typealias MPHostingController = UIHostingController
#endif
