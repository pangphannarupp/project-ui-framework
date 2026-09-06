import SwiftUI

/**
 * BizMathKeyboard - SwiftUI component matching Web UI-Framework `PPMathKeyboard.vue`.
 */
public struct BizMathKeyboard: View {
    public var theme: String
    public var variant: String
    public var backgroundColor: String
    public var action: () -> Void

    public init(
        theme: String = "",
        variant: String = "",
        backgroundColor: String = "",
        action: @escaping () -> Void = {}
    ) {
        self.theme = theme
        self.variant = variant
        self.backgroundColor = backgroundColor
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("MathKeyboard")
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
 * Web UI-Framework parity alias for [BizMathKeyboard].
 */
public typealias PPMathKeyboard = BizMathKeyboard
