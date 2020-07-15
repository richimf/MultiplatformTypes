import SwiftUI

#if os(macOS)
public typealias MPHostingView = NSHostingView
#else
public class MPHostingView<Content: View>: UIView {
    let hostingController: UIHostingController<Content>
    let view: UIView
    public init(rootView: Content) {
        hostingController = UIHostingController(rootView: rootView)
        view = hostingController.view
        super.init(frame: .zero)
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        view.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        view.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        view.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
#endif
