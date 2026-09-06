import SwiftUI

/**
 * BizTooltip - SwiftUI component matching Web UI-Framework `PPTooltip.vue`.
 */
public struct BizTooltip: View {
    public var content: String
    public var placement: String
    public var theme: String
    public var delay: Int
    public var bgColor: String
    public var textColor: String
    public var action: () -> Void

    public init(
        content: String = "",
        placement: String = "top",
        theme: String = "dark",
        delay: Int = 200,
        bgColor: String = "",
        textColor: String = "",
        action: @escaping () -> Void = {}
    ) {
        self.content = content
        self.placement = placement
        self.theme = theme
        self.delay = delay
        self.bgColor = bgColor
        self.textColor = textColor
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Tooltip")
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
 * Web UI-Framework parity alias for [BizTooltip].
 */
public typealias PPTooltip = BizTooltip
