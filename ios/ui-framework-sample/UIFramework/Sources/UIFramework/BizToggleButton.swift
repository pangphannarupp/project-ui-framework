import SwiftUI

/**
 * BizToggleButton - SwiftUI component matching Web UI-Framework `PPToggleButton.vue`.
 */
public struct BizToggleButton: View {
    public var modelValue: Bool
    public var variant: String
    public var size: String
    public var disabled: Bool
    public var iconOnly: Bool
    public var label: String
    public var icon: String
    public var action: () -> Void

    public init(
        modelValue: Bool = false,
        variant: String = "outline",
        size: String = "medium",
        disabled: Bool = false,
        iconOnly: Bool = false,
        label: String = "",
        icon: String = "",
        action: @escaping () -> Void = {}
    ) {
        self.modelValue = modelValue
        self.variant = variant
        self.size = size
        self.disabled = disabled
        self.iconOnly = iconOnly
        self.label = label
        self.icon = icon
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("ToggleButton")
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
 * Web UI-Framework parity alias for [BizToggleButton].
 */
public typealias PPToggleButton = BizToggleButton
