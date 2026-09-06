import SwiftUI

/**
 * BizConfetti - SwiftUI component matching Web UI-Framework `PPConfetti.vue`.
 */
public struct BizConfetti: View {
    public var active: Bool
    public var duration: Int
    public var particleCount: Int
    public var colors: [String]
    public var action: () -> Void

    public init(
        active: Bool = false,
        duration: Int = 0,
        particleCount: Int = 0,
        colors: [String] = [],
        action: @escaping () -> Void = {}
    ) {
        self.active = active
        self.duration = duration
        self.particleCount = particleCount
        self.colors = colors
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Confetti")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color(hex: "#1A2A5E"))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .background(Color.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(hex: "#CBD5E1"), lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

/**
 * Web UI-Framework parity alias for [BizConfetti].
 */
public typealias PPConfetti = BizConfetti
