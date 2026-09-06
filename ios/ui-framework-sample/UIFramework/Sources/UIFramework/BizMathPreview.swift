import SwiftUI

/**
 * BizMathPreview - SwiftUI component matching Web UI-Framework `PPMathPreview.vue`.
 */
public struct BizMathPreview: View {
    public var equation: String
    public var displayMode: Bool
    public var action: () -> Void

    public init(
        equation: String = "",
        displayMode: Bool = false,
        action: @escaping () -> Void = {}
    ) {
        self.equation = equation
        self.displayMode = displayMode
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("MathPreview")
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
 * Web UI-Framework parity alias for [BizMathPreview].
 */
public typealias PPMathPreview = BizMathPreview
