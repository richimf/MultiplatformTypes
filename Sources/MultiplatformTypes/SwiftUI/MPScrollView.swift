import SwiftUI

#if os(macOS)
public typealias MPScrollView = NSScrollView
#else
public typealias MPScrollView = UIScrollView
#endif

//ScrollView(axes: Axis.Set, showsIndicators: Bool, content: { })

public struct ScrollView<Content: View>: ViewRepresentable {
    
    public enum Axis {
        case area
        case zoom
    }
    let axes: Axis
    let showsIndicators: Bool
    let content: () -> Content
    
    public init(axes: Axis, showsIndicators: Bool = true, content: @escaping () -> Content) {
        self.axes = axes
        self.showsIndicators = showsIndicators
        self.content = content
    }
    
    public func makeView(context: Context) -> MPScrollView {
        
        let scrollView = MPScrollView()
        
        #if !os(macOS)
        scrollView.showsHorizontalScrollIndicator = showsIndicators
        scrollView.showsVerticalScrollIndicator = showsIndicators
        #endif
        
        #if !os(macOS)
        if axes == .zoom {
            scrollView.minimumZoomScale = 0.5
            scrollView.maximumZoomScale = 2.0
        }
        #endif

        let view: MPView = MPHostingView(rootView: content())
        scrollView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        view.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        return scrollView
    }
    
    public func updateView(_ view: MPScrollView, context: Context) {}
    
}
