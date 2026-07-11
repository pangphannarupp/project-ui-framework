import SwiftUI

public struct BizSkeletonText: View {
    @State private var isAnimating = false

    public init() {}

    public var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(hex: "#F0F0F0"),
                            Color(hex: "#E0E0E0"),
                            Color(hex: "#F0F0F0")
                        ]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(width: geometry.size.width, height: geometry.size.height)
                .mask(Rectangle())
                .offset(x: isAnimating ? geometry.size.width : -geometry.size.width)
                .animation(
                    Animation.linear(duration: 1.5).repeatForever(autoreverses: false),
                    value: isAnimating
                )
        }
        .background(Color(hex: "#F0F0F0"))
        .cornerRadius(4)
        .onAppear {
            isAnimating = true
        }
    }
}
