#if os(macOS)
import AppKit
#else
import UIKit
#endif
import SwiftUI

#if os(macOS)
public typealias MPColor = NSColor
#else
public typealias MPColor = UIColor
#endif

public typealias MP_RGB = (r: Double, g: Double, b: Double)
public typealias MP_RGBA = (r: Double, g: Double, b: Double, a: Double)
public typealias MP_HSV = (h: Double, s: Double, v: Double)

// MARK: - Channels

public extension MPColor {
    var red: Double {
        Double(CIColor(color: self).red)
    }
    var green: Double {
        Double(CIColor(color: self).green)
    }
    var blue: Double {
        Double(CIColor(color: self).blue)
    }
    var alpha: Double {
        Double(CIColor(color: self).alpha)
    }
    var opacity: Double { alpha }
    var rgb: MP_RGB {
        let ciColor: CIColor = CIColor(color: self)
        return (r: Double(ciColor.red),
                g: Double(ciColor.green),
                b: Double(ciColor.blue))
    }
    var rgba: MP_RGBA {
        let ciColor: CIColor = CIColor(color: self)
        return (r: Double(ciColor.red),
                g: Double(ciColor.green),
                b: Double(ciColor.blue),
                a: Double(ciColor.alpha))
    }
}

// MARK: - Init


// TODO: Add matching initalizers


// MARK: - Operators

public extension MPColor {
    
//    static func + (lhs: MPColor, rhs: MPColor) -> MPColor {
//
//    }
    
}

// MARK: - HSV

public extension MPColor {

    var hsv: MP_HSV {
        let rgb: MP_RGB = self.rgb
        return MPColor.hsv(r: rgb.r, g: rgb.g, b: rgb.b)
    }
    
    static func hsv(r: Double, g: Double, b: Double) -> MP_HSV {
        var h, s, v: Double
        var mn, mx, d: Double
        mn = r < g ? r : g
        mn = mn < b ? mn : b
        mx = r > g ? r : g
        mx = mx > b ? mx : b
        v = mx
        d = mx - mn
        if (d < 0.00001) {
            s = 0.0
            h = 0.0
            return (h: h, s: s, v: v)
        }
        if mx > 0.0 {
            s = d / mx
        } else {
            s = 0.0
            h = 0.0
            return (h: h, s: s, v: v)
        }
        if r >= mx {
            h = (g - b) / d
        } else if g >= mx {
            h = 2.0 + (b - r) / d
        } else {
            h = 4.0 + (r - g) / d
        }
        h /= 6.0
        if h < 0.0 {
            h += 1.0
        }
        return (h: h, s: s, v: v)
    }
    
    static func rgb(h: Double, s: Double, v: Double) -> MP_RGB {
        let r: Double
        let g: Double
        let b: Double
        var hh, p, q, t, ff: Double
        var i: Int
        if (s <= 0.0) {
            r = v
            g = v
            b = v
            return  (r: r, g: g, b: b)
        }
        hh = (h - floor(h)) * 6.0
        i = Int(hh)
        ff = hh - Double(i)
        p = v * (1.0 - s)
        q = v * (1.0 - (s * ff))
        t = v * (1.0 - (s * (1.0 - ff)))
        switch(i) {
        case 0:
            r = v
            g = t
            b = p
        case 1:
            r = q
            g = v
            b = p
        case 2:
            r = p
            g = v
            b = t
        case 3:
            r = p
            g = q
            b = v
        case 4:
            r = t
            g = p
            b = v
        case 5:
            r = v
            g = p
            b = q
        default:
            r = v
            g = p
            b = q
        }
        return (r: r, g: g, b: b)
    }
    
}

// MARK: - Hex

public extension MPColor {

    static func hex(r: Double, g: Double, b: Double) -> String {
        let hexInt: Int = (Int)(Double(r)*255)<<16 | (Int)(Double(g)*255)<<8 | (Int)(Double(b)*255)<<0
        return String(format:"#%06x", hexInt).uppercased()
    }

    static func rgb(hex: String) -> MP_RGB? {
        let hasHash: Bool = hex.first == "#"
        guard (hasHash ? [4,7] : [3,6]).contains(hex.count) else { return nil }
        var hex = hex
        if hasHash {
            if hex.count == 4 {
                hex = hex[1..<4]
            } else {
                hex = hex[1..<7]
            }
        }
        if hex.count == 3 {
            let r = hex[0..<1]
            let g = hex[1..<2]
            let b = hex[2..<3]
            hex = r + r + g + g + b + b
        }
        var hexInt: UInt64 = 0
        let scanner: Scanner = Scanner(string: hex)
        scanner.scanHexInt64(&hexInt)
        let r: Double = Double((hexInt & 0xff0000) >> 16) / 255.0
        let g: Double = Double((hexInt & 0xff00) >> 8) / 255.0
        let b: Double = Double((hexInt & 0xff) >> 0) / 255.0
        return (r: r, g: g, b: b)
    }

}

extension String {
    
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    
    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
    
}
