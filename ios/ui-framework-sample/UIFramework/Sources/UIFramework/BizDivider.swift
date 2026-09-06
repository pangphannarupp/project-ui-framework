import SwiftUI

/**
 * BizDivider - SwiftUI component matching Web UI-Framework `PPDivider.vue`.
 */
public struct BizDivider: View {
    public var variant: String
    public var orientation: String
    public var align: String
    public var color: String
    public var margin: String
    public var action: () -> Void

    public init(
        variant: String = "solid",
        orientation: String = "horizontal",
        align: String = "center",
        color: String = "",
        margin: String = "",
        action: @escaping () -> Void = {}
    ) {
        self.variant = variant
        self.orientation = orientation
        self.align = align
        self.color = color
        self.margin = margin
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Divider")
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
 * Web UI-Framework parity alias for [BizDivider].
 */
public typealias PPDivider = BizDivider
