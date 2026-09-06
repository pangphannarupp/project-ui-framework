import SwiftUI

/**
 * BizRibbonButton - SwiftUI component matching Web UI-Framework `PPRibbonButton.vue`.
 */
public struct BizRibbonButton: View {
    public var label: String
    public var icon: String
    public var iconSvg: String
    public var size: String
    public var active: Bool
    public var disabled: Bool
    public var action: () -> Void

    public init(
        label: String = "",
        icon: String = "",
        iconSvg: String = "",
        size: String = "large",
        active: Bool = false,
        disabled: Bool = false,
        action: @escaping () -> Void = {}
    ) {
        self.label = label
        self.icon = icon
        self.iconSvg = iconSvg
        self.size = size
        self.active = active
        self.disabled = disabled
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("RibbonButton")
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
 * Web UI-Framework parity alias for [BizRibbonButton].
 */
public typealias PPRibbonButton = BizRibbonButton
