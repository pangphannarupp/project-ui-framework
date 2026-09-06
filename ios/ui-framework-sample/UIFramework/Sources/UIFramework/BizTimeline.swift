import SwiftUI

/**
 * BizTimeline - SwiftUI component matching Web UI-Framework `PPTimeline.vue`.
 */
public struct BizTimeline: View {
    public var direction: String
    public var align: String
    public var animated: Bool
    public var action: () -> Void

    public init(
        direction: String = "",
        align: String = "",
        animated: Bool = false,
        action: @escaping () -> Void = {}
    ) {
        self.direction = direction
        self.align = align
        self.animated = animated
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Timeline")
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
 * Web UI-Framework parity alias for [BizTimeline].
 */
public typealias PPTimeline = BizTimeline
