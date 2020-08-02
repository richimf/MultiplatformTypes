//import SwiftUI
//
//public struct Stack<Content: View>: View {
//    public enum Axis {
//        case horizontal
//        case vertical
//    }
//    let axis: Axis
//    let spacing: CGFloat?
//    let content: [Content]
//    public init(axis: Axis, spacing: CGFloat?, @ViewBuilder _ content: () -> ([Content])) {
//        self.axis = axis
//        self.spacing = spacing
//        self.content = content()
//    }
//    @ViewBuilder
//    public var body: some View {
//        switch axis {
//        case .horizontal:
//            HStack(spacing: spacing) {
//                ForEach(0..<content.count) { i in
//                    content[i]
//                }
//            }
//        case .vertical:
//            VStack(spacing: spacing) {
//                ForEach(0..<content.count) { i in
//                    content[i]
//                }
//            }
//        }
//    }
//}
