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
    
    let zoomAmplitude: CGFloat = 0.005
    
    let showsIndicators: Bool
    @Binding var minimumZoomScale: CGFloat
    @Binding var maximumZoomScale: CGFloat
    let content: () -> Content
    
    public init(showsIndicators: Bool = true,
                minimumZoomScale: Binding<CGFloat> = .constant(0.25),
                maximumZoomScale: Binding<CGFloat> = .constant(4.0),
                content: @escaping () -> Content) {
        self.showsIndicators = showsIndicators
        _minimumZoomScale = minimumZoomScale
        _maximumZoomScale = maximumZoomScale
        self.content = content
    }
    
    public func makeView(context: Context) -> MPScrollView {
        
        let scrollView = MPScrollView()
        
        let contentView: MPView = MPHostingView(rootView: content())
        
        #if os(macOS)
        
        let middleView = NSMiddleView()
        
        var isPressingShift: Bool = false {
            didSet {
                scrollView.canScroll = !isPressingShift
                #if DEBUG
                if middleView.mouseLocation != nil || !isPressingShift {
                    middleView.backgroundColor = isPressingShift ? NSColor(white: 0.5, alpha: 0.05) : .clear
                }
                #endif
            }
        }
        
        scrollView.scrollCallback = { scroll in
            guard isPressingShift else { return }
            guard let mouseLocation: CGPoint = middleView.mouseLocation else { return }
            let magScale: CGFloat = 1.0 + scroll.y * zoomAmplitude
            zoom(by: magScale, to: mouseLocation, in: scrollView)
        }
        
        middleView.shiftPressCallback = { shift in
            isPressingShift = shift
        }
        middleView.addSubview(contentView)
        fill(contentView, in: middleView)
        
        let zoomView: MPView = middleView
        #else
        let zoomView: MPView = contentView
        #endif
        
        #if os(macOS)
        scrollView.allowsMagnification = true
        scrollView.rulersVisible = true
        scrollView.hasHorizontalScroller = showsIndicators
        scrollView.hasVerticalScroller = showsIndicators
        #else
        scrollView.showsHorizontalScrollIndicator = showsIndicators
        scrollView.showsVerticalScrollIndicator = showsIndicators
        scrollView.alwaysBounceHorizontal = true
        scrollView.alwaysBounceVertical = true
        scrollView.delegate = context.coordinator
        #endif
        
        #if os(macOS)
        scrollView.documentView = zoomView
        #else
        scrollView.addSubview(zoomView)
        #endif
        
        zoomView.translatesAutoresizingMaskIntoConstraints = false
        #if !os(macOS)
        fill(zoomView, in: scrollView)
        #endif
        
        #if !os(macOS)
        context.coordinator.zoomView = zoomView
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
    
    #if os(macOS)
    func zoom(by magScale: CGFloat,
              to focusPoint: CGPoint,
              in scrollView: MPScrollView) {
        
//        let magFrame: CGRect = scrollView.documentVisibleRect
//        let magOrigin: CGPoint = magFrame.origin
//        let magSize: CGSize = magFrame.size
//        let focusOffset: CGPoint = focusPoint - magOrigin
//        let focusOffsetUV: CGPoint = focusOffset / magSize
//        let newMagSize: CGSize = magSize * magScale
//        let magSizeDiff: CGSize = newMagSize - magSize
//        let newMouseOffset: CGPoint = newMagSize * focusOffsetUV
//        let newMagOrigin: CGPoint = magOrigin + magSizeDiff * focusOffsetUV
//        let newMagFrame: CGRect = CGRect(origin: newMagOrigin, size: newMagSize)
//        scrollView/*.animator()*/.magnify(toFit: newMagFrame)
        
        scrollView.setMagnification(scrollView.magnification * magScale, centeredAt: focusPoint)
        
    }
    #endif
    
    public func updateView(_ scrollView: MPScrollView, context: Context) {
        
        #if os(macOS)
        scrollView.minMagnification = minimumZoomScale
        scrollView.maxMagnification = maximumZoomScale
        #else
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
    
    var isPressingShift: Bool = false {
        didSet {
            guard oldValue != isPressingShift else { return }
            shiftPressCallback?(isPressingShift)
        }
    }
    var shiftPressCallback: ((Bool) -> ())?
    
    var mouseLocation: CGPoint? {
        let mouseInScreen: CGPoint = NSEvent.mouseLocation
        let mouseInWindow: CGPoint = mouseInScreen - (window?.frame.origin ?? .zero)
        let mouseInView: CGPoint = convert(mouseInWindow, from: nil)
        guard mouseInView.x > 0.0 && mouseInView.x < bounds.width else { return nil }
        guard mouseInView.y > 0.0 && mouseInView.y < bounds.height else { return nil }
        return mouseInView
    }
    
    public override func flagsChanged(with event: NSEvent) {
        isPressingShift = event.modifierFlags.contains(.shift)
    }
    
}
#endif
