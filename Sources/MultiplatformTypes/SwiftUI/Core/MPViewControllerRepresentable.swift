import SwiftUI

#if os(macOS)
public typealias MPViewController = NSViewController
public typealias MPViewControllerRepresentable = NSViewControllerRepresentable
#else
public typealias MPViewController = UIViewController
public typealias MPViewControllerRepresentable = UIViewControllerRepresentable
#endif


public protocol ViewControllerRepresentable: MPViewControllerRepresentable {
    
    associatedtype VC: MPViewController
    
    func makeViewController(context: Context) -> VC
    
    func updateViewController(_ viewController: VC, context: Context)
    
}


public extension ViewControllerRepresentable {
    
    #if os(macOS)
    func makeNSViewController(context: Context) -> VC {
        makeViewController(context: context)
    }
    #else
    func makeUIViewController(context: Context) -> VC {
        makeViewController(context: context)
    }
    #endif
    
    #if os(macOS)
    func updateNSViewController(_ nsViewController: VC, context: Context) {
        updateViewController(nsViewController, context: context)
    }
    #else
    func updateUIViewController(_ uiViewController: VC, context: Context) {
        updateViewController(uiViewController, context: context)
    }
    #endif
    
}
