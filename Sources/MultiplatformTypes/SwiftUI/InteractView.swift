import SwiftUI

public extension View {
    func onInteract(on interacted: Binding<Bool>) -> some View {
        ZStack {
            self
            InteractView { on in
                interacted.wrappedValue = on
            }
        }
    }
}

@available(*, deprecated, renamed: "InteractView")
typealias TouchView = InteractView

public struct InteractView: ViewRepresentable {
    
    let interacted: (Bool) -> ()
    
    public init(_ interacted: @escaping (Bool) -> ()) {
        self.interacted = interacted
    }
    
    public func makeView(context: Context) -> MPTouchView {
        MPTouchView(interacted: interacted)
    }
    
    public func updateView(_ view: MPTouchView, context: Context) {}
    
}

public class MPTouchView: MPView {
    
    let interacted: (Bool) -> ()
    
    init(interacted: @escaping (Bool) -> ()) {
        self.interacted = interacted
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    #if os(iOS)
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        interacted(true)
    }
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        interacted(false)
    }
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        interacted(false)
    }
    
    #elseif os(macOS)

    public override func mouseDown(with event: NSEvent) {
        interacted(true)
    }
    
    public override func mouseUp(with event: NSEvent) {
        interacted(false)
    }
    
    #endif
    
}
