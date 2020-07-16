import CoreGraphics

public extension CGRect {
    static let one = CGRect(origin: .zero, size: .one)
    var unitVFlip: CGRect { CGRect(x: minX, y: 1.0 - maxY, width: width, height: height) }
    var unitHFlip: CGRect { CGRect(x: 1.0 - maxX, y: minY, width: width, height: height) }
}
