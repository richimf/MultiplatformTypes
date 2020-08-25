import SwiftUI

#if os(macOS)
public typealias MPScrollView = NSScrollWheelView
#else
public typealias MPScrollView = UIScrollView
#endif

@available(tvOS 14.0, *)
@available(OSX 11.0, *)
@available(iOS 14.0, *)
public struct ZoomScrollViewLibraryContent: LibraryContentProvider {
    @LibraryContentBuilder
    public var views: [LibraryItem] {
        LibraryItem(
            ZoomScrollView {
                Rectangle()
            },
            category: .control
        )
    }
}

public struct ZoomScrollView<Content: View>: ViewRepresentable {
    
    #if os(macOS)
    let zoomByScrollAmplitude: CGFloat = 0.005
    #endif
    
    var bindZoomScale: Bool
    @Binding var zoomScale: CGFloat
    var bindContentOffset: Bool
    @Binding var contentOffset: CGPoint
    
    let showsIndicators: Bool
    @Binding var minimumZoomScale: CGFloat
    @Binding var maximumZoomScale: CGFloat
    let content: () -> Content
    
    public init(zoomScale: Binding<CGFloat>? = nil,
                contentOffset: Binding<CGPoint>? = nil,
                showsIndicators: Bool = true,
                minimumZoomScale: Binding<CGFloat> = .constant(0.25),
                maximumZoomScale: Binding<CGFloat> = .constant(4.0),
                content: @escaping () -> Content) {
        bindZoomScale = zoomScale != nil
        _zoomScale = zoomScale ?? .constant(1.0)
        bindContentOffset = contentOffset != nil
        _contentOffset = contentOffset ?? .constant(.zero)
        self.showsIndicators = showsIndicators
        _minimumZoomScale = minimumZoomScale
        _maximumZoomScale = maximumZoomScale
        self.content = content
    }
    
    public func makeView(context: Context) -> MPScrollView {
        
        let scrollView = MPScrollView()
        
        let contentView: MPView = MPHostingView(rootView: content())
        
        #if os(macOS)
        scrollView.allowsMagnification = true
        scrollView.hasHorizontalScroller = showsIndicators
        scrollView.hasVerticalScroller = showsIndicators
        scrollView.usesPredominantAxisScrolling = false
        #else
        scrollView.showsHorizontalScrollIndicator = showsIndicators
        scrollView.showsVerticalScrollIndicator = showsIndicators
        scrollView.alwaysBounceHorizontal = true
        scrollView.alwaysBounceVertical = true
        scrollView.delegate = context.coordinator
        #endif
        
        // Zoom on macOS
        
        #if os(macOS)
        
        let middleView = NSMiddleView()
        
        func pressed() {
            let canZoom: Bool = isPressingOption || isPressingShift
            scrollView.canScroll = !canZoom
            #if DEBUG
            if middleView.mouseLocation != nil || !canZoom {
                middleView.backgroundColor = canZoom ? NSColor(white: 0.5, alpha: 0.05) : .clear
            }
            #endif
        }
        var isPressingShift: Bool = false { didSet { pressed() } }
        var isPressingOption: Bool = false { didSet { pressed() } }
        
        scrollView.scrollCallback = { scroll in
            let magnificationScale: CGFloat = 1.0 + scroll.y * zoomByScrollAmplitude
            let magnification: CGFloat = scrollView.magnification * magnificationScale
            if isPressingOption {
                guard let mouseLocation: CGPoint = middleView.mouseLocation else { return }
                scrollView.setMagnification(magnification, centeredAt: mouseLocation)
            } else if isPressingShift {
                let scrollFrame: CGRect = scrollView.documentVisibleRect
                let centerLocation: CGPoint = scrollFrame.origin + scrollFrame.size / 2
                scrollView.setMagnification(magnification, centeredAt: centerLocation)
            }
        }
        
        middleView.shiftPressCallback = { shift in
            isPressingShift = shift
        }
        middleView.optionPressCallback = { option in
            isPressingOption = option
        }
        middleView.addSubview(contentView)
        fill(contentView, in: middleView)
        
        let zoomView: MPView = middleView
        #else
        let zoomView: MPView = contentView
        #endif
        
        // Zoom View
        
        #if os(macOS)
        scrollView.documentView = zoomView
        #else
        scrollView.addSubview(zoomView)
        #endif
        
        zoomView.translatesAutoresizingMaskIntoConstraints = false
        #if !os(macOS)
        fill(zoomView, in: scrollView)
        #endif
        
        // Zoom Callbacks
        
        #if os(macOS)
        NotificationCenter.default.addObserver(context.coordinator,
                                               selector: #selector(context.coordinator.changed),
                                               name: NSView.boundsDidChangeNotification,
                                               object: scrollView.contentView)
        context.coordinator.didChange = {
            // FIXME: Don't modify during view update
            if bindContentOffset {
                self.contentOffset = scrollView.documentVisibleRect.origin
            }
            if bindZoomScale {
                self.zoomScale = scrollView.magnification
            }
        }
        #else
        context.coordinator.zoomView = zoomView
        context.coordinator.didScroll = {
            // FIXME: Don't modify during view update
            if bindContentOffset {
                self.contentOffset = scrollView.contentOffset
            }
        }
        context.coordinator.didZoom = {
            // FIXME: Don't modify during view update
            if bindZoomScale {
                self.zoomScale = scrollView.zoomScale
            }
        }
        #endif
        
        return scrollView
    }
    
    private func fill(_ childView: MPView, in parentView: MPView) {
        childView.translatesAutoresizingMaskIntoConstraints = false
        childView.leftAnchor.constraint(equalTo: parentView.leftAnchor).isActive = true
        childView.rightAnchor.constraint(equalTo: parentView.rightAnchor).isActive = true
        childView.topAnchor.constraint(equalTo: parentView.topAnchor).isActive = true
        childView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor).isActive = true
    }
    
    public func updateView(_ scrollView: MPScrollView, context: Context) {
        
        let animation: Animation? = context.transaction.animation
                
        #if os(macOS)
        
        scrollView.minMagnification = minimumZoomScale
        scrollView.maxMagnification = maximumZoomScale
        
        if bindZoomScale, scrollView.magnification != zoomScale {
            if animation != nil {
                scrollView.animator().magnification = zoomScale
            } else {
                scrollView.magnification = zoomScale
            }
        }
        
        if bindContentOffset, scrollView.documentVisibleRect.origin != contentOffset {
            if animation != nil {
                scrollView.animator().magnify(toFit: CGRect(origin: contentOffset, size: scrollView.documentVisibleRect.size))
            } else {
                scrollView.magnify(toFit: CGRect(origin: contentOffset, size: scrollView.documentVisibleRect.size))
            }
        }
        
        #else
        
        scrollView.minimumZoomScale = minimumZoomScale
        scrollView.maximumZoomScale = maximumZoomScale
        
        if bindZoomScale, scrollView.zoomScale != zoomScale {
            if animation != nil {
                UIView.animate(withDuration: 0.5) {
                    scrollView.zoomScale = zoomScale
                }
            } else {
                scrollView.zoomScale = zoomScale
            }
        }
        
        if bindContentOffset, scrollView.contentOffset != contentOffset {
            if animation != nil {
                UIView.animate(withDuration: 0.5) {
                    scrollView.contentOffset = contentOffset
                }
            } else {
                scrollView.contentOffset = contentOffset
            }
        }
        
        #endif

    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    #if os(macOS)
    public class Coordinator {
        
        var didChange: (() -> ())?
        
        @objc func changed() {
            didChange?()
        }
        
    }
    #else
    public class Coordinator: NSObject, UIScrollViewDelegate {
        
        var zoomView: UIView?
        
        var didScroll: (() -> ())?
        var didZoom: (() -> ())?

        public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            zoomView
        }
        
        public func scrollViewDidScroll(_ scrollView: UIScrollView) {
            didScroll?()
        }
        
        public func scrollViewDidZoom(_ scrollView: UIScrollView) {
            didZoom?()
        }
        
    }
    #endif
    
}

#if os(macOS)
public class NSScrollWheelView: NSScrollView {
    
    var canScroll: Bool = true
    
    var scrollCallback: ((CGPoint) -> ())?
    
    public override func scrollWheel(with event: NSEvent) {
        if canScroll {
            super.scrollWheel(with: event)
        }
        let scroll = CGPoint(x: event.scrollingDeltaX,
                             y: event.scrollingDeltaY)
        scrollCallback?(scroll)
    }

}
#endif

#if os(macOS)
public class NSMiddleView: NSView {
    
    public override var acceptsFirstResponder: Bool { true }
    
    var mouseLocation: CGPoint? {
        let mouseInScreen: CGPoint = NSEvent.mouseLocation
        let mouseInWindow: CGPoint = mouseInScreen - (window?.frame.origin ?? .zero)
        let mouseInView: CGPoint = convert(mouseInWindow, from: nil)
        guard mouseInView.x > 0.0 && mouseInView.x < bounds.width else { return nil }
        guard mouseInView.y > 0.0 && mouseInView.y < bounds.height else { return nil }
        return mouseInView
    }
    
    var isPressingShift: Bool = false {
        didSet {
            guard oldValue != isPressingShift else { return }
            shiftPressCallback?(isPressingShift)
        }
    }
    var shiftPressCallback: ((Bool) -> ())?
    
    var isPressingOption: Bool = false {
        didSet {
            guard oldValue != isPressingOption else { return }
            optionPressCallback?(isPressingOption)
        }
    }
    var optionPressCallback: ((Bool) -> ())?
    
    public override func flagsChanged(with event: NSEvent) {
        isPressingShift = event.modifierFlags.contains(.shift)
        isPressingOption = event.modifierFlags.contains(.option)
    }
    
}
#endif