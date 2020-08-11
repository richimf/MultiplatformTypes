import SwiftUI

#if os(macOS)
public typealias MPVisualEffectView = NSVisualEffectView
#else
public typealias MPVisualEffectView = UIVisualEffectView
#endif

public extension View {
    /// `backgroundBlur` is a convenience method for adding a `VisualEffectView` background.
    ///
    /// `fallbackColor` is used on **macOS**
    /// use `.desktopBackgroundBlur()` to get a native **macOS** desktop blur
    func backgroundBlur(cornerRadius: CGFloat = 0.0, fallbackColor: Color = .clear) -> some View {
        #if os(macOS)
        return background(fallbackColor)
        #else
        return background(VisualEffectView().mask(RoundedRectangle(cornerRadius: cornerRadius)))
        #endif
    }
    /// Only used for **macOS** desktop blur.
    func desktopBackgroundBlur() -> some View {
        #if os(macOS)
        return background(VisualEffectView())
        #else
        return self
        #endif
    }
}

public struct BlurView: View {
    let cornerRadius: CGFloat
    public init(cornerRadius: CGFloat = 0.0) {
        self.cornerRadius = cornerRadius
    }
    @ViewBuilder
    public var body: some View {
        VisualEffectView()
            .mask(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

public struct VisualEffectView: ViewRepresentable {

    @Environment(\.colorScheme) var colorScheme
    
    public init() {}
    
    public func makeView(context: Context) -> MPVisualEffectView {
        #if os(macOS)
        return MPVisualEffectView()
        #else
        return MPVisualEffectView(effect: blurEffect())
        #endif
    }
    
    public func updateView(_ view: MPVisualEffectView, context: Context) {
        #if canImport(UIKit)
        view.effect = blurEffect()
        #endif
    }
    
    #if canImport(UIKit)
    func blurEffect() -> UIBlurEffect {
        UIBlurEffect(style: colorScheme == .light ? .light : .dark)
    }
    #endif
    
}
