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
    var bindContentCenter: Bool
    @Binding var contentCenter: CGPoint
    
    let showsIndicators: Bool
    @Binding var minimumZoomScale: CGFloat
    @Binding var maximumZoomScale: CGFloat
    let content: () -> Content
    
    /// Unify coordinates for macOS with iOS, zero at top.
    private let vFlip: Bool = true
    
    // MARK: - Life Cycle
    
    public init(zoomScale: Binding<CGFloat>? = nil,
                contentCenter: Binding<CGPoint>? = nil,
                showsIndicators: Bool = true,
                minimumZoomScale: Binding<CGFloat> = .constant(0.25),
                maximumZoomScale: Binding<CGFloat> = .constant(4.0),
                content: @escaping () -> Content) {
        bindZoomScale = zoomScale != nil
        _zoomScale = zoomScale ?? .constant(1.0)
        bindContentCenter = contentCenter != nil
        _contentCenter = contentCenter ?? .constant(.zero)
        self.showsIndicators = showsIndicators
        _minimumZoomScale = minimumZoomScale
        _maximumZoomScale = maximumZoomScale
        self.content = content
    }
    
    // MARK: - Make
    
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
            guard !context.coordinator.isUpdating else { return }
            if bindContentCenter {
                contentCenter = getContentCenter(in: scrollView)
            }
            if bindZoomScale {
                zoomScale = getZoomScale(in: scrollView)
            }
        }
        #else
        context.coordinator.zoomView = zoomView
        context.coordinator.didScroll = {
            guard !context.coordinator.isUpdating else { return }
            if bindContentCenter {
                contentCenter = getContentCenter(in: scrollView)
            }
        }
        context.coordinator.didZoom = {
            guard !context.coordinator.isUpdating else { return }
            if bindZoomScale {
                zoomScale = getZoomScale(in: scrollView)
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
    
    // MARK: - Update
    
    public func updateView(_ scrollView: MPScrollView, context: Context) {
        
        context.coordinator.isUpdating = true
        defer { context.coordinator.isUpdating = false }
        
        #if os(macOS)
        scrollView.minMagnification = minimumZoomScale
        scrollView.maxMagnification = maximumZoomScale
        #else
        scrollView.minimumZoomScale = minimumZoomScale
        scrollView.maximumZoomScale = maximumZoomScale
        #endif
        
        let animation: Animation? = context.transaction.animation
        let animate: Bool = animation != nil
        
        let currentZoomScale: CGFloat = getZoomScale(in: scrollView)
        let newZoom: Bool = currentZoomScale != zoomScale
        if bindZoomScale, newZoom {
            setZoomScale(zoomScale, in: scrollView, animated: animate)
        }
        
        let currentContentCenter: CGPoint = getContentCenter(in: scrollView)
        let newCenter: Bool = currentContentCenter != contentCenter
        if bindContentCenter, newCenter {
            setContentCenter(contentCenter, in: scrollView, animated: animate)
        }
        
    }
    
    // MARK: - Zoom Scale
    
    func getZoomScale(in scrollView: MPScrollView) -> CGFloat {
        #if os(macOS)
        return scrollView.magnification
        #else
        return scrollView.zoomScale
        #endif
    }
    
    
    func setZoomScale(_ zoomScale: CGFloat, in scrollView: MPScrollView, animated: Bool) {
        #if os(macOS)
        if animated {
            scrollView.animator().magnification = zoomScale
        } else {
            scrollView.magnification = zoomScale
        }
        #else
        if animated {
            UIView.animate(withDuration: 0.5) {
                scrollView.zoomScale = zoomScale
            }
        } else {
            scrollView.zoomScale = zoomScale
        }
        #endif
    }
    
    // MARK: - Content Center
    
    func getContentCenter(in scrollView: MPScrollView) -> CGPoint {
        #if os(macOS)
        let contentSize: CGSize = scrollView.documentView?.bounds.size ?? .one
        let origin: CGPoint = scrollView.documentVisibleRect.origin
        let size: CGSize = scrollView.documentVisibleRect.size
        let center: CGPoint = origin + size / 2
        return vFlip ? CGPoint(x: center.x, y: contentSize.height - center.y) : center
        #else
        return scrollView.contentOffset + scrollView.contentSize / 2
        #endif
    }
    
    func setContentCenter(_ contentCenter: CGPoint, in scrollView: MPScrollView, animated: Bool) {
        #if os(macOS)
        let contentSize: CGSize = scrollView.documentView?.bounds.size ?? .one
        let size: CGSize = scrollView.documentVisibleRect.size
        let center: CGPoint = vFlip ? CGPoint(x: contentCenter.x, y: contentSize.height - contentCenter.y) : contentCenter
        let origin: CGPoint = center - size / 2
        let frame = CGRect(origin: origin, size: size)
        if animated {
            scrollView.animator().magnify(toFit: frame)
        } else {
            scrollView.magnify(toFit: frame)
        }
        #else
        let contentOffset: CGPoint = contentCenter - scrollView.contentSize / 2
        if animated {
            UIView.animate(withDuration: 0.5) {
                scrollView.contentOffset = contentOffset
            }
        } else {
            scrollView.contentOffset = contentOffset
        }
        #endif
    }
    
    // MARK: - Coordinator
    
    public func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    public class MultiCoordinator: NSObject {
        var isUpdating: Bool = false
    }
    #if os(macOS)
    public class Coordinator: MultiCoordinator {
        
        var didChange: (() -> ())?
        
        @objc func changed() {
            didChange?()
        }
        
    }
    #else
    public class Coordinator: MultiCoordinator, UIScrollViewDelegate {
        
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

// MARK: - Wheel

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

// MARK: - Middle

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
