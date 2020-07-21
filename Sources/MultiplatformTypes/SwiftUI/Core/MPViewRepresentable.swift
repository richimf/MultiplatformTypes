import SwiftUI

#if os(macOS)
public typealias MPViewRepresentable = NSViewRepresentable
#else
public typealias MPViewRepresentable = UIViewRepresentable
#endif


public protocol ViewRepresentable: MPViewRepresentable {
    
    associatedtype V: MPView
    
    func makeView(context: Context) -> V
    
    func updateView(_ view: V, context: Context)
    
}


public extension ViewRepresentable {
    
    #if os(macOS)
    func makeNSView(context: Context) -> V {
        makeView(context: context)
    }
    #else
    func makeUIView(context: Context) -> V {
        makeView(context: context)
    }
    #endif
    
    #if os(macOS)
    func updateNSView(_ nsView: V, context: Context) {
        updateView(nsView, context: context)
    }
    #else
    func updateUIView(_ uiView: V, context: Context) {
        updateView(uiView, context: context)
    }
    #endif
    
}
