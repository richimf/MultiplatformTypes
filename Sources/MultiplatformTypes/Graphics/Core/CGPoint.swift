import CoreGraphics

public extension CGPoint {
    static let one = CGPoint(x: 1.0, y: 1.0)
}

public extension CGPoint {
    func unitCropped() -> CGPoint {
        cropped(min: .zero, max: .one)
    }
    func cropped(min minimum: CGPoint, max maxmimum: CGPoint) -> CGPoint {
        CGPoint(x: max(min(x, maxmimum.x), minimum.x),
                y: max(min(y, maxmimum.y), minimum.y))
    }
}

public extension CGPoint {
    
    static func + (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        CGPoint(x: lhs.x + rhs,
                y: lhs.y + rhs)
    }
    static func - (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        CGPoint(x: lhs.x - rhs,
                y: lhs.y - rhs)
    }
    static func * (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        CGPoint(x: lhs.x * rhs,
                y: lhs.y * rhs)
    }
    static func / (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        CGPoint(x: lhs.x / rhs,
                y: lhs.y / rhs)
    }
    
    static func + (lhs: CGPoint, rhs: Float) -> CGPoint {
        CGPoint(x: lhs.x + CGFloat(rhs),
                y: lhs.y + CGFloat(rhs))
    }
    static func - (lhs: CGPoint, rhs: Float) -> CGPoint {
        CGPoint(x: lhs.x - CGFloat(rhs),
                y: lhs.y - CGFloat(rhs))
    }
    static func * (lhs: CGPoint, rhs: Float) -> CGPoint {
        CGPoint(x: lhs.x * CGFloat(rhs),
                y: lhs.y * CGFloat(rhs))
    }
    static func / (lhs: CGPoint, rhs: Float) -> CGPoint {
        CGPoint(x: lhs.x / CGFloat(rhs),
                y: lhs.y / CGFloat(rhs))
    }
    
    static func + (lhs: CGPoint, rhs: Double) -> CGPoint {
        CGPoint(x: lhs.x + CGFloat(rhs),
                y: lhs.y + CGFloat(rhs))
    }
    static func - (lhs: CGPoint, rhs: Double) -> CGPoint {
        CGPoint(x: lhs.x - CGFloat(rhs),
                y: lhs.y - CGFloat(rhs))
    }
    static func * (lhs: CGPoint, rhs: Double) -> CGPoint {
        CGPoint(x: lhs.x * CGFloat(rhs),
                y: lhs.y * CGFloat(rhs))
    }
    static func / (lhs: CGPoint, rhs: Double) -> CGPoint {
        CGPoint(x: lhs.x / CGFloat(rhs),
                y: lhs.y / CGFloat(rhs))
    }
    
    static func + (lhs: CGPoint, rhs: Int) -> CGPoint {
        CGPoint(x: lhs.x + CGFloat(rhs),
                y: lhs.y + CGFloat(rhs))
    }
    static func - (lhs: CGPoint, rhs: Int) -> CGPoint {
        CGPoint(x: lhs.x - CGFloat(rhs),
                y: lhs.y - CGFloat(rhs))
    }
    static func * (lhs: CGPoint, rhs: Int) -> CGPoint {
        CGPoint(x: lhs.x * CGFloat(rhs),
                y: lhs.y * CGFloat(rhs))
    }
    static func / (lhs: CGPoint, rhs: Int) -> CGPoint {
        CGPoint(x: lhs.x / CGFloat(rhs),
                y: lhs.y / CGFloat(rhs))
    }
    
}

public extension CGPoint {
    
    static func + (lhs: CGFloat, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs + rhs.x,
                y: lhs + rhs.y)
    }
    static func - (lhs: CGFloat, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs - rhs.x,
                y: lhs - rhs.y)
    }
    static func * (lhs: CGFloat, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs * rhs.x,
                y: lhs * rhs.y)
    }
    static func / (lhs: CGFloat, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs / rhs.x,
                y: lhs / rhs.y)
    }
    
    static func + (lhs: Float, rhs: CGPoint) -> CGPoint {
        CGPoint(x: CGFloat(lhs) + rhs.x,
                y: CGFloat(lhs) + rhs.y)
    }
    static func - (lhs: Float, rhs: CGPoint) -> CGPoint {
        CGPoint(x: CGFloat(lhs) - rhs.x,
                y: CGFloat(lhs) - rhs.y)
    }
    static func * (lhs: Float, rhs: CGPoint) -> CGPoint {
        CGPoint(x: CGFloat(lhs) * rhs.x,
                y: CGFloat(lhs) * rhs.y)
    }
    static func / (lhs: Float, rhs: CGPoint) -> CGPoint {
        CGPoint(x: CGFloat(lhs) / rhs.x,
                y: CGFloat(lhs) / rhs.y)
    }
    
    static func + (lhs: Double, rhs: CGPoint) -> CGPoint {
        CGPoint(x: CGFloat(lhs) + rhs.x,
                y: CGFloat(lhs) + rhs.y)
    }
    static func - (lhs: Double, rhs: CGPoint) -> CGPoint {
        CGPoint(x: CGFloat(lhs) - rhs.x,
                y: CGFloat(lhs) - rhs.y)
    }
    static func * (lhs: Double, rhs: CGPoint) -> CGPoint {
        CGPoint(x: CGFloat(lhs) * rhs.x,
                y: CGFloat(lhs) * rhs.y)
    }
    static func / (lhs: Double, rhs: CGPoint) -> CGPoint {
        CGPoint(x: CGFloat(lhs) / rhs.x,
                y: CGFloat(lhs) / rhs.y)
    }
    
    static func + (lhs: Int, rhs: CGPoint) -> CGPoint {
        CGPoint(x: CGFloat(lhs) + rhs.x,
                y: CGFloat(lhs) + rhs.y)
    }
    static func - (lhs: Int, rhs: CGPoint) -> CGPoint {
        CGPoint(x: CGFloat(lhs) - rhs.x,
                y: CGFloat(lhs) - rhs.y)
    }
    static func * (lhs: Int, rhs: CGPoint) -> CGPoint {
        CGPoint(x: CGFloat(lhs) * rhs.x,
                y: CGFloat(lhs) * rhs.y)
    }
    static func / (lhs: Int, rhs: CGPoint) -> CGPoint {
        CGPoint(x: CGFloat(lhs) / rhs.x,
                y: CGFloat(lhs) / rhs.y)
    }
    
}

public extension CGPoint {
    
    static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x + rhs.x,
                y: lhs.y + rhs.y)
    }
    static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x - rhs.x,
                y: lhs.y - rhs.y)
    }
    static func * (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x * rhs.x,
                y: lhs.y * rhs.y)
    }
    static func / (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x / rhs.x,
                y: lhs.y / rhs.y)
    }
    
}

public extension CGPoint {
    
    static func + (lhs: CGPoint, rhs: CGSize) -> CGPoint {
        CGPoint(x: lhs.x + rhs.width,
                y: lhs.y + rhs.height)
    }
    static func + (lhs: CGSize, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.width + rhs.x,
                y: lhs.height + rhs.y)
    }
    
    static func - (lhs: CGPoint, rhs: CGSize) -> CGPoint {
        CGPoint(x: lhs.x - rhs.width,
                y: lhs.y - rhs.height)
    }
    static func - (lhs: CGSize, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.width - rhs.x,
                y: lhs.height - rhs.y)
    }
    
    static func * (lhs: CGPoint, rhs: CGSize) -> CGPoint {
        CGPoint(x: lhs.x * rhs.width,
                y: lhs.y * rhs.height)
    }
    static func * (lhs: CGSize, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.width * rhs.x,
                y: lhs.height * rhs.y)
    }
    
    static func / (lhs: CGPoint, rhs: CGSize) -> CGPoint {
        CGPoint(x: lhs.x / rhs.width,
                y: lhs.y / rhs.height)
    }
    static func / (lhs: CGSize, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.width / rhs.x,
                y: lhs.height / rhs.y)
    }
    
}

public extension CGPoint {
    
    static func += (lhs: inout CGPoint, rhs: CGSize) {
        lhs = lhs + rhs
    }
    static func += (lhs: inout CGPoint, rhs: CGPoint) {
        lhs = lhs + rhs
    }
    static func += (lhs: inout CGPoint, rhs: CGFloat) {
        lhs = lhs + rhs
    }
    
    static func -= (lhs: inout CGPoint, rhs: CGSize) {
        lhs = lhs - rhs
    }
    static func -= (lhs: inout CGPoint, rhs: CGPoint) {
        lhs = lhs - rhs
    }
    static func -= (lhs: inout CGPoint, rhs: CGFloat) {
        lhs = lhs - rhs
    }
    
    static func *= (lhs: inout CGPoint, rhs: CGSize) {
        lhs = lhs * rhs
    }
    static func *= (lhs: inout CGPoint, rhs: CGPoint) {
        lhs = lhs * rhs
    }
    static func *= (lhs: inout CGPoint, rhs: CGFloat) {
        lhs = lhs * rhs
    }
    
    static func /= (lhs: inout CGPoint, rhs: CGSize) {
        lhs = lhs / rhs
    }
    static func /= (lhs: inout CGPoint, rhs: CGPoint) {
        lhs = lhs / rhs
    }
    static func /= (lhs: inout CGPoint, rhs: CGFloat) {
        lhs = lhs / rhs
    }
    
}

public extension CGPoint {
    
    static prefix func - (size: CGPoint) -> CGPoint {
        CGPoint(x: -size.x, y: -size.y)
    }
    
}




