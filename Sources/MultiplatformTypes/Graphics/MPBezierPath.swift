// https://gist.github.com/lukaskubanek/1f3585314903dfc66fc7

import Foundation

#if os(macOS)
import AppKit
#else
import UIKit
#endif


#if os(macOS)
public typealias MPBezierPath = NSBezierPath
#else
public typealias MPBezierPath = UIBezierPath
#endif


#if os(macOS)
public extension MPBezierPath {

    convenience init(cgPath: CGPath) {
        
        self.init()
        
        cgPath.applyWithBlock { elementPointer in
            let element: CGPathElement = elementPointer.pointee
            let point: CGPoint = element.points.pointee
            switch element.type {
            case .moveToPoint:
                move(to: point)
            case .addLineToPoint:
                line(to: point)
            case .addQuadCurveToPoint:
                let currentPoint: CGPoint = cgPath.currentPoint
                // TODO: - Double check `/ 3`
                let x: CGFloat = (currentPoint.x + 2 * point.x) / 3
                let y: CGFloat = (currentPoint.y + 2 * point.y) / 3
                let interpolatedPoint = CGPoint(x: x, y: y)
                let endPoint: CGPoint = element.points.successor().pointee
                curve(to: endPoint,
                      controlPoint1: interpolatedPoint,
                      controlPoint2: interpolatedPoint)
            case .addCurveToPoint:
                let midPoint: CGPoint = element.points.successor().pointee
                let endPoint: CGPoint = element.points.successor().successor().pointee
                curve(to: endPoint,
                      controlPoint1: point,
                      controlPoint2: midPoint)
            case .closeSubpath:
                close()
            @unknown default:
                break
            }
        }
        
    }
    
}
#endif

//extension NSBezierPath {
//
//    init(cgPath: CGPath) {
//
//    }
//
//  var cgPath: CGPath {
//    get {
//      return self.transformToCGPath()
//    }
//  }
//
//  /// Transforms the NSBezierPath into a CGPathRef
//  ///
//  /// :returns: The transformed NSBezierPath
//  private func transformToCGPath() -> CGPath
//  {
//    // Create path
//    let path = CGMutablePath()
//    let points = UnsafeMutablePointer<NSPoint>.allocate(capacity: 3)
//    let numElements = self.elementCount
//    let cgPoint1 = CGPoint(x: points[0].x, y: points[0].y)
//    let cgPoint2 = CGPoint(x: points[1].x, y: points[1].y)
//    let cgPoint3 = CGPoint(x: points[2].x, y: points[2].y)
//
//    if numElements > 0
//    {
//      var didClosePath = true
//
//      for index in 0..<numElements
//      {
//        let pathType = self.element(at: index, associatedPoints: points)
//
//        switch pathType
//        {
//          case .moveToBezierPathElement :
//            path.move(to: cgPoint1)
//          case .lineToBezierPathElement :
//            path.addLine(to: cgPoint1)
//            didClosePath = false
//          case .curveToBezierPathElement :
//            path.addCurve(to: cgPoint1, control1: cgPoint2, control2: cgPoint3)
//            didClosePath = false
//          case .closePathBezierPathElement:
//            path.closeSubpath()
//            didClosePath = true
//        }
//      }
//
//      if !didClosePath { path.closeSubpath() }
//    }
//
//    points.deallocate(capacity: 3)
//    return path
//  }
//
//}
