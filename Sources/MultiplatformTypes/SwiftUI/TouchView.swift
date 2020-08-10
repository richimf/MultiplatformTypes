import SwiftUI

public struct TouchView: ViewRepresentable {
    
    let touched: (Bool) -> ()
    
    public init(touched: @escaping (Bool) -> ()) {
        self.touched = touched
    }
    
    public func makeView(context: Context) -> MPTouchView {
        MPTouchView(touched: touched)
    }
    
    public func updateView(_ view: MPTouchView, context: Context) {}
    
}

public class MPTouchView: MPView {
    
    let touched: (Bool) -> ()
    
    init(touched: @escaping (Bool) -> ()) {
        self.touched = touched
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    #if os(iOS)
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touched(true)
    }
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touched(false)
    }
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touched(false)
    }
    #endif
    
}
