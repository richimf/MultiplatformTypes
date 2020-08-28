import SwiftUI

public extension View {
    
    func frame(size: CGSize, alignment: Alignment = .center) -> some View {
        self.frame(width: size.width, height: size.height, alignment: alignment)
    }
    
}

public extension View {
    
    func offset(_ point: CGPoint) -> some View {
        self.offset(x: point.x, y: point.y)
    }
    
}
