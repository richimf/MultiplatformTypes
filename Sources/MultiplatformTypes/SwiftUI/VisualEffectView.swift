import SwiftUI

#if os(macOS)
public typealias MPVisualEffectView = NSVisualEffectView
#else
public typealias MPVisualEffectView = UIVisualEffectView
#endif

public extension View {
    func backgroundBlur() -> some View {
        background(VisualEffectView())
    }
    func backgroundBlur(cornerRadius: CGFloat) -> some View {
        background(VisualEffectView().mask(RoundedRectangle(cornerRadius: cornerRadius)))
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
