#if os(macOS)
import AppKit
#else
import UIKit
#endif
import SwiftUI

#if os(macOS)
public typealias MPImage = NSImage
#else
public typealias MPImage = UIImage
#endif

#if os(macOS)
public extension Data {
    var bitmap: NSBitmapImageRep? { NSBitmapImageRep(data: self) }
}
public extension NSBitmapImageRep {
    var png: Data? { representation(using: .png, properties: [:]) }
}
public extension MPImage {
    func pngData() -> Data? {
        tiffRepresentation?.bitmap?.png
    }
}
#endif

public extension Image {
    init(image: MPImage) {
        #if os(macOS)
        self.init(nsImage: image)
        #else
        self.init(uiImage: image)
        #endif
    }
}

@available(iOS 13, *)
@available(OSX 10.16, *)
public extension MPImage {
    #if os(macOS)
    static let `nil`: MPImage = MPImage(systemSymbolName: "camera.metering.none", accessibilityDescription: nil)!
    #else
    static let `nil`: MPImage = MPImage(systemName: "camera.metering.none")!
    #endif
}

@available(iOS 13, *)
@available(OSX 10.16, *)
public extension Optional where Wrapped == MPImage {
    var forceBond: Binding<MPImage> {
        Binding<MPImage>(get: { self ?? .nil }, set: { _ in })
    }
}
