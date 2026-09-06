import SwiftUI

/**
 * BizBadge - SwiftUI component matching Web UI-Framework `PPBadge.vue`.
 */
public struct BizBadge: View {
    public var value: Int
    public var max: Int
    public var dot: Bool
    public var color: String
    public var placement: String
    public var hidden: Bool
    public var bordered: Bool
    public var bgColor: String
    public var textColor: String
    public var action: () -> Void

    public init(
        value: Int = 0,
        max: Int = 0,
        dot: Bool = false,
        color: String = "danger",
        placement: String = "top-right",
        hidden: Bool = false,
        bordered: Bool = true,
        bgColor: String = "",
        textColor: String = "",
        action: @escaping () -> Void = {}
    ) {
        self.value = value
        self.max = max
        self.dot = dot
        self.color = color
        self.placement = placement
        self.hidden = hidden
        self.bordered = bordered
        self.bgColor = bgColor
        self.textColor = textColor
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Badge")
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
 * Web UI-Framework parity alias for [BizBadge].
 */
public typealias PPBadge = BizBadge
