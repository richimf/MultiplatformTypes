import SwiftUI

public extension CGPath {
    
    func scaled(by scale: CGFloat) -> CGPath {
        var transform = CGAffineTransform(scaleX: scale, y: scale)
        return withUnsafeMutablePointer(to: &transform) { transform -> CGPath in
            copy(using: transform) ?? CGPath(rect: .zero, transform: nil)
        }
    }
    
}

public extension Path {

    func scaled(to scale: CGFloat) -> Path {
        Path(cgPath.scaled(by: scale))
    }

}
