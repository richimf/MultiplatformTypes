import SwiftUI

public extension Color {
    static let clearGray: Color = Color(.displayP3, white: 0.5, opacity: 0.001)
}

public extension Color {
    static func background(colorScheme: ColorScheme) -> Color {
        #if os(macOS)
        return Color(.windowBackgroundColor)
        #else
        return colorScheme == .light ? .white : .black
        #endif
    }
}

public extension Color {
    static var background: some View {
        #if os(macOS)
        return Color(.windowBackgroundColor)
        #else
        return Color.primary.colorInvert()
        #endif
    }
}
