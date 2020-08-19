import SwiftUI

#if os(macOS)
public typealias MPScrollView = NSScrollView
#else
public typealias MPScrollView = UIScrollView
#endif

@available(tvOS 14.0, *)
@available(OSX 11.0, *)
@available(iOS 14.0, *)
public struct ScrollZoomViewLibraryContent: LibraryContentProvider {
    @LibraryContentBuilder
    public var views: [LibraryItem] {
        LibraryItem(
            ScrollZoomView {
                Rectangle()
            },
            category: .control
        )
    }
}

public struct ScrollZoomView<Content: View>: ViewRepresentable {
    
    let showsIndicators: Bool
    @Binding var minimumZoomScale: CGFloat
    @Binding var maximumZoomScale: CGFloat
    let content: () -> Content
    
    public init(showsIndicators: Bool = true,
                minimumZoomScale: Binding<CGFloat> = .constant(0.5),
                maximumZoomScale: Binding<CGFloat> = .constant(2.0),
                content: @escaping () -> Content) {
        self.showsIndicators = showsIndicators
        _minimumZoomScale = minimumZoomScale
        _maximumZoomScale = maximumZoomScale
        self.content = content
    }
    
    public func makeView(context: Context) -> MPScrollView {
        
        let scrollView = MPScrollView()
        
        #if !os(macOS)
        
        scrollView.showsHorizontalScrollIndicator = showsIndicators
        scrollView.showsVerticalScrollIndicator = showsIndicators
        
        scrollView.alwaysBounceHorizontal = true
        scrollView.alwaysBounceVertical = true
        
        scrollView.delegate = context.coordinator
        
        #endif
        
        let zoomView: MPView = MPHostingView(rootView: content())
        scrollView.addSubview(zoomView)
        
        #if !os(macOS)
        context.coordinator.zoomView = zoomView
        #endif
        
        zoomView.translatesAutoresizingMaskIntoConstraints = false
        zoomView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        zoomView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        zoomView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        zoomView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        return scrollView
    }
    
    public func updateView(_ scrollView: MPScrollView, context: Context) {
        
        #if !os(macOS)
        scrollView.minimumZoomScale = minimumZoomScale
        scrollView.maximumZoomScale = maximumZoomScale
        #endif

    }
    
    #if !os(macOS)
    
    public func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    public class Coordinator: NSObject, UIScrollViewDelegate {
        
        var zoomView: UIView?
        
        public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            zoomView
        }
        
    }
    
    #endif
    
}
