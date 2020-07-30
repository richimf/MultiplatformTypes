import CoreGraphics

public extension CGSize {
    static let one = CGSize(width: 1.0, height: 1.0)
}

//extension CGSize: ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral {
//    public init(integerLiteral value: Int) {
//        let floatValue = CGFloat(value)
//        self.init(width: floatValue, height: floatValue)
//    }
//    public init(floatLiteral value: Double) {
//        let floatValue = CGFloat(value)
//        self.init(width: floatValue, height: floatValue)
//    }
//}

public extension CGSize {
    
    static func + (lhs: CGSize, rhs: CGFloat) -> CGSize {
        CGSize(width: lhs.width + rhs,
               height: lhs.height + rhs)
    }
    static func - (lhs: CGSize, rhs: CGFloat) -> CGSize {
        CGSize(width: lhs.width - rhs,
               height: lhs.height - rhs)
    }
    static func * (lhs: CGSize, rhs: CGFloat) -> CGSize {
        CGSize(width: lhs.width * rhs,
               height: lhs.height * rhs)
    }
    static func / (lhs: CGSize, rhs: CGFloat) -> CGSize {
        CGSize(width: lhs.width / rhs,
               height: lhs.height / rhs)
    }
    
    static func + (lhs: CGSize, rhs: Float) -> CGSize {
        CGSize(width: lhs.width + CGFloat(rhs),
               height: lhs.height + CGFloat(rhs))
    }
    static func - (lhs: CGSize, rhs: Float) -> CGSize {
        CGSize(width: lhs.width - CGFloat(rhs),
               height: lhs.height - CGFloat(rhs))
    }
    static func * (lhs: CGSize, rhs: Float) -> CGSize {
        CGSize(width: lhs.width * CGFloat(rhs),
               height: lhs.height * CGFloat(rhs))
    }
    static func / (lhs: CGSize, rhs: Float) -> CGSize {
        CGSize(width: lhs.width / CGFloat(rhs),
               height: lhs.height / CGFloat(rhs))
    }
    
    static func + (lhs: CGSize, rhs: Double) -> CGSize {
        CGSize(width: lhs.width + CGFloat(rhs),
               height: lhs.height + CGFloat(rhs))
    }
    static func - (lhs: CGSize, rhs: Double) -> CGSize {
        CGSize(width: lhs.width - CGFloat(rhs),
               height: lhs.height - CGFloat(rhs))
    }
    static func * (lhs: CGSize, rhs: Double) -> CGSize {
        CGSize(width: lhs.width * CGFloat(rhs),
               height: lhs.height * CGFloat(rhs))
    }
    static func / (lhs: CGSize, rhs: Double) -> CGSize {
        CGSize(width: lhs.width / CGFloat(rhs),
               height: lhs.height / CGFloat(rhs))
    }
    
    static func + (lhs: CGSize, rhs: Int) -> CGSize {
        CGSize(width: lhs.width + CGFloat(rhs),
               height: lhs.height + CGFloat(rhs))
    }
    static func - (lhs: CGSize, rhs: Int) -> CGSize {
        CGSize(width: lhs.width - CGFloat(rhs),
               height: lhs.height - CGFloat(rhs))
    }
    static func * (lhs: CGSize, rhs: Int) -> CGSize {
        CGSize(width: lhs.width * CGFloat(rhs),
               height: lhs.height * CGFloat(rhs))
    }
    static func / (lhs: CGSize, rhs: Int) -> CGSize {
        CGSize(width: lhs.width / CGFloat(rhs),
               height: lhs.height / CGFloat(rhs))
    }
    
}

public extension CGSize {
    
    static func + (lhs: CGFloat, rhs: CGSize) -> CGSize {
        CGSize(width: lhs + rhs.width,
               height: lhs + rhs.height)
    }
    static func - (lhs: CGFloat, rhs: CGSize) -> CGSize {
        CGSize(width: lhs - rhs.width,
               height: lhs - rhs.height)
    }
    static func * (lhs: CGFloat, rhs: CGSize) -> CGSize {
        CGSize(width: lhs * rhs.width,
               height: lhs * rhs.height)
    }
    static func / (lhs: CGFloat, rhs: CGSize) -> CGSize {
        CGSize(width: lhs / rhs.width,
               height: lhs / rhs.height)
    }
    
    static func + (lhs: Float, rhs: CGSize) -> CGSize {
        CGSize(width: CGFloat(lhs) + rhs.width,
               height: CGFloat(lhs) + rhs.height)
    }
    static func - (lhs: Float, rhs: CGSize) -> CGSize {
        CGSize(width: CGFloat(lhs) - rhs.width,
               height: CGFloat(lhs) - rhs.height)
    }
    static func * (lhs: Float, rhs: CGSize) -> CGSize {
        CGSize(width: CGFloat(lhs) * rhs.width,
               height: CGFloat(lhs) * rhs.height)
    }
    static func / (lhs: Float, rhs: CGSize) -> CGSize {
        CGSize(width: CGFloat(lhs) / rhs.width,
               height: CGFloat(lhs) / rhs.height)
    }
    
    static func + (lhs: Double, rhs: CGSize) -> CGSize {
        CGSize(width: CGFloat(lhs) + rhs.width,
               height: CGFloat(lhs) + rhs.height)
    }
    static func - (lhs: Double, rhs: CGSize) -> CGSize {
        CGSize(width: CGFloat(lhs) - rhs.width,
               height: CGFloat(lhs) - rhs.height)
    }
    static func * (lhs: Double, rhs: CGSize) -> CGSize {
        CGSize(width: CGFloat(lhs) * rhs.width,
               height: CGFloat(lhs) * rhs.height)
    }
    static func / (lhs: Double, rhs: CGSize) -> CGSize {
        CGSize(width: CGFloat(lhs) / rhs.width,
               height: CGFloat(lhs) / rhs.height)
    }
    
    static func + (lhs: Int, rhs: CGSize) -> CGSize {
        CGSize(width: CGFloat(lhs) + rhs.width,
               height: CGFloat(lhs) + rhs.height)
    }
    static func - (lhs: Int, rhs: CGSize) -> CGSize {
        CGSize(width: CGFloat(lhs) - rhs.width,
               height: CGFloat(lhs) - rhs.height)
    }
    static func * (lhs: Int, rhs: CGSize) -> CGSize {
        CGSize(width: CGFloat(lhs) * rhs.width,
               height: CGFloat(lhs) * rhs.height)
    }
    static func / (lhs: Int, rhs: CGSize) -> CGSize {
        CGSize(width: CGFloat(lhs) / rhs.width,
               height: CGFloat(lhs) / rhs.height)
    }
    
}

public extension CGSize {
    
    static func + (lhs: CGSize, rhs: CGSize) -> CGSize {
        CGSize(width: lhs.width + rhs.width,
               height: lhs.height + rhs.height)
    }
    static func - (lhs: CGSize, rhs: CGSize) -> CGSize {
        CGSize(width: lhs.width - rhs.width,
               height: lhs.height - rhs.height)
    }
    static func * (lhs: CGSize, rhs: CGSize) -> CGSize {
        CGSize(width: lhs.width * rhs.width,
               height: lhs.height * rhs.height)
    }
    static func / (lhs: CGSize, rhs: CGSize) -> CGSize {
        CGSize(width: lhs.width / rhs.width,
               height: lhs.height / rhs.height)
    }
    
}

public extension CGSize {
    
    static func + (lhs: CGSize, rhs: CGPoint) -> CGSize {
        CGSize(width: lhs.width + rhs.x,
               height: lhs.height + rhs.y)
    }
    static func - (lhs: CGSize, rhs: CGPoint) -> CGSize {
        CGSize(width: lhs.width - rhs.x,
               height: lhs.height - rhs.y)
    }
    static func * (lhs: CGSize, rhs: CGPoint) -> CGSize {
        CGSize(width: lhs.width * rhs.x,
               height: lhs.height * rhs.y)
    }
    static func / (lhs: CGSize, rhs: CGPoint) -> CGSize {
        CGSize(width: lhs.width / rhs.x,
               height: lhs.height / rhs.y)
    }
    
}

