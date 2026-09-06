import SwiftUI

/**
 * BizScrollSegmentButton - SwiftUI component matching Web UI-Framework `PPScrollSegmentButton.vue`.
 */
public struct BizScrollSegmentButton: View {
    public var isActive: Bool
    public var action: () -> Void

    public init(
        isActive: Bool = false,
        action: @escaping () -> Void = {}
    ) {
        self.isActive = isActive
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("ScrollSegmentButton")
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
 * Web UI-Framework parity alias for [BizScrollSegmentButton].
 */
public typealias PPScrollSegmentButton = BizScrollSegmentButton
