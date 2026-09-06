import SwiftUI

/**
 * BizChip - SwiftUI component matching Web UI-Framework `PPChip.vue`.
 */
public struct BizChip: View {
    public var label: String
    public var icon: String
    public var color: String
    public var variant: String
    public var size: String
    public var closable: Bool
    public var clickable: Bool
    public var bgColor: String
    public var textColor: String
    public var action: () -> Void

    public init(
        label: String = "",
        icon: String = "",
        color: String = "default",
        variant: String = "solid",
        size: String = "md",
        closable: Bool = false,
        clickable: Bool = false,
        bgColor: String = "",
        textColor: String = "",
        action: @escaping () -> Void = {}
    ) {
        self.label = label
        self.icon = icon
        self.color = color
        self.variant = variant
        self.size = size
        self.closable = closable
        self.clickable = clickable
        self.bgColor = bgColor
        self.textColor = textColor
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Chip")
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
 * Web UI-Framework parity alias for [BizChip].
 */
public typealias PPChip = BizChip
