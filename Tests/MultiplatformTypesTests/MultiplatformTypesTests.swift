import XCTest
@testable import MultiplatformTypes

final class MultiplatformTypesTests: XCTestCase {
    
    func testMPColorHSV() {
        let randomColor: MPColor = MPColor(red: .random(in: 0.0...1.0),
                                           green: .random(in: 0.0...1.0),
                                           blue: .random(in: 0.0...1.0),
                                           alpha: 1.0)
        let hsv: MP_HSV = randomColor.hsv
        let checkColor: MPColor = MPColor(hue: CGFloat(hsv.h),
                                          saturation: CGFloat(hsv.s),
                                          brightness: CGFloat(hsv.v),
                                          alpha: 1.0)
        XCTAssertEqual(randomColor, checkColor)
    }

    static var allTests = [
        ("testMPColorHSV", testMPColorHSV),
    ]
}
