import SwiftUI

/**
 * BizImageTransition - SwiftUI component matching Web UI-Framework `PPImageTransition.vue`.
 */
public struct BizImageTransition: View {
    public var expandedImageHeight: String
    public var backgroundColor: String
    public var action: () -> Void

    public init(
        expandedImageHeight: String = "",
        backgroundColor: String = "",
        action: @escaping () -> Void = {}
    ) {
        self.expandedImageHeight = expandedImageHeight
        self.backgroundColor = backgroundColor
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("ImageTransition")
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
 * Web UI-Framework parity alias for [BizImageTransition].
 */
public typealias PPImageTransition = BizImageTransition
