import SwiftUI

#if os(macOS)
public typealias MPScrollView = NSScrollView
#else
public typealias MPScrollView = UIScrollView
#endif

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
    let minimumZoomScale: CGFloat
    let maximumZoomScale: CGFloat
    let content: () -> Content
    
    public init(showsIndicators: Bool = true,
                minimumZoomScale: CGFloat = 0.5,
                maximumZoomScale: CGFloat = 2.0,
                content: @escaping () -> Content) {
        self.showsIndicators = showsIndicators
        self.minimumZoomScale = minimumZoomScale
        self.maximumZoomScale = maximumZoomScale
        self.content = content
    }
    
    public func makeView(context: Context) -> MPScrollView {
        
        let scrollView = MPScrollView()
        
        #if !os(macOS)
        scrollView.showsHorizontalScrollIndicator = showsIndicators
        scrollView.showsVerticalScrollIndicator = showsIndicators
        #endif
        
        scrollView.alwaysBounceHorizontal = true
        scrollView.alwaysBounceVertical = true
        
        scrollView.delegate = context.coordinator
        
        #if !os(macOS)
        scrollView.minimumZoomScale = minimumZoomScale
        scrollView.maximumZoomScale = maximumZoomScale
        #endif

        let zoomView: MPView = MPHostingView(rootView: content())
        context.coordinator.zoomView = zoomView
        scrollView.addSubview(zoomView)
        zoomView.translatesAutoresizingMaskIntoConstraints = false
        zoomView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        zoomView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        zoomView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        zoomView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        return scrollView
    }
    
    public func updateView(_ view: MPScrollView, context: Context) {}
    
    public func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    public class Coordinator: NSObject, UIScrollViewDelegate {
        
        var zoomView: UIView?
        
        public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            zoomView
        }
        
    }
    
}
