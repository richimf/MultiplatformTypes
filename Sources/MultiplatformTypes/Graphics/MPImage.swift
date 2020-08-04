#if os(macOS)
import AppKit
#else
import UIKit
#endif
import SwiftUI
//#if !os(macOS)
//import AVKit
//#endif

#if os(macOS)
public typealias MPImage = NSImage
#else
public typealias MPImage = UIImage
#endif

#if os(macOS)
public extension Data {
    var bitmap: NSBitmapImageRep? { NSBitmapImageRep(data: self) }
}
#endif

// MARK: - PNG

#if os(macOS)
public extension NSBitmapImageRep {
    var png: Data? { representation(using: .png, properties: [:]) }
}
public extension MPImage {
    func pngData() -> Data? {
        tiffRepresentation?.bitmap?.png
    }
}
#endif

// MARK: - JPEG

#if os(macOS)
public extension NSBitmapImageRep {
    var jpeg: Data? { representation(using: .jpeg, properties: [:]) }
}
public extension MPImage {
    func jpegData(compressionQuality: CGFloat) -> Data? {
        guard let bitmap: NSBitmapImageRep = tiffRepresentation?.bitmap else { return nil }
        let properties: [NSBitmapImageRep.PropertyKey : Any] = [
            .compressionFactor: compressionQuality
        ]
        return bitmap.representation(using: .jpeg, properties: properties)
    }
}
#endif

// MARK: - SwiftUI

public extension Image {
    init(image: MPImage) {
        #if os(macOS)
        self.init(nsImage: image)
        #else
        self.init(uiImage: image)
        #endif
    }
}

// MARK: - Nil

@available(iOS 13, *)
@available(OSX 10.16, *)
public extension MPImage {
    #if os(macOS)
    static let `nil`: MPImage = MPImage(systemSymbolName: "camera.metering.none", accessibilityDescription: nil)!
    #else
    static let `nil`: MPImage = MPImage(systemName: "camera.metering.none")!
    #endif
}

// MARK: - Force Bond

@available(iOS 13, *)
@available(OSX 10.16, *)
public extension Optional where Wrapped == MPImage {
    var forceBond: Binding<MPImage> {
        Binding<MPImage>(get: { self ?? .nil }, set: { _ in })
    }
}

// MARK: - CGImage

#if os(macOS)
extension MPImage {
    var cgImage: CGImage? {
        cgImage(forProposedRect: nil, context: nil, hints: nil)
    }
}
#endif

// MARK: - HEIC

//public extension MPImage {
//
//    static let isHeicSupported: Bool = (CGImageDestinationCopyTypeIdentifiers() as! [String]).contains("public.heic")
//
//    func heicData(compressionQuality: CGFloat = 1.0) -> Data? {
//        guard let mutableData: CFMutableData = CFDataCreateMutable(nil, 0),
//              let destination: CGImageDestination = CGImageDestinationCreateWithData(mutableData, AVFileType.heic as CFString, 1, nil),
//              let cgImage: CGImage = cgImage
//        else { return nil }
//        var properties: [CFString: Any] = [:]
//        properties[kCGImageDestinationLossyCompressionQuality] = compressionQuality
//        #if !os(macOS)
//        properties[kCGImagePropertyOrientation] = imageOrientation.cgImageOrientation.rawValue
//        #endif
//        CGImageDestinationAddImage(destination, cgImage, properties as CFDictionary)
//        guard CGImageDestinationFinalize(destination) else { return nil }
//        return mutableData as Data
//    }
//
//}

//#if !os(macOS)
//
//extension CGImagePropertyOrientation {
//    init(_ uiOrientation: UIImage.Orientation) {
//        switch uiOrientation {
//            case .up: self = .up
//            case .upMirrored: self = .upMirrored
//            case .down: self = .down
//            case .downMirrored: self = .downMirrored
//            case .left: self = .left
//            case .leftMirrored: self = .leftMirrored
//            case .right: self = .right
//            case .rightMirrored: self = .rightMirrored
//        @unknown default:
//            fatalError()
//        }
//    }
//}
//
//extension UIImage.Orientation {
//    var cgImageOrientation: CGImagePropertyOrientation { .init(self) }
//}
//
//#endif
