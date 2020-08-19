# MultiplatformTypes

UIKit and AppKit typealiases with unified functions for iOS, tvOS and macOS.

- `MPImage` = `UIImage` & `NSImage`
- `MPColor` = `UIColor` & `NSColor`

- `MPView` = `UIView` & `NSView`
- `MPViewController` = `UIViewController` & `NSViewController`

- `MPViewRepresentable` = `UIViewRepresentable` & `NSViewRepresentable`
  - Use as protocol `ViewRepresentable`
- `MPViewControllerRepresentable` = `UIViewControllerRepresentable` & `NSViewControllerRepresentable`
  - Use as protocol `ViewControllerRepresentable`

- `MPHostingView` = `UIHostingView` & `NSHostingView`
- `MPHostingController` = `UIHostingController` & `NSHostingController`

- `MPScrollView` = `UIScrollView` & `NSScrollView`

- `MPBezierPath` = `UIBezierPath` & `NSBezierPath`

- `MPVisualEffectView` = `UIVisualEffectView` & `NSVisualEffectView`
  - Use in SwiftUI as `BlurView()` or `.backgroundBlur(cornerRadius:)`
