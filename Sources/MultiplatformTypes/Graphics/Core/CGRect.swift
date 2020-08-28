import CoreGraphics

public extension CGRect {

    static let one = CGRect(origin: .zero, size: .one)
}

public extension CGRect {

    var unitVFlip: CGRect { CGRect(x: minX, y: 1.0 - maxY, width: width, height: height) }
    var unitHFlip: CGRect { CGRect(x: 1.0 - maxX, y: minY, width: width, height: height) }
    
}

public extension CGRect {
    
    init(minX: CGFloat, minY: CGFloat, maxX: CGFloat, maxY: CGFloat) {
        self.init(x: minX, y: minY, width: maxX - minX, height: maxY - minY)
    }
    
}

public extension CGRect {
    
    static func + (lhs: CGRect, rhs: CGPoint) -> CGRect {
        CGRect(origin: lhs.origin + rhs, size: lhs.size)
    }
    
    static func + (lhs: CGRect, rhs: CGSize) -> CGRect {
        CGRect(origin: lhs.origin, size: lhs.size + rhs)
    }
    
}
