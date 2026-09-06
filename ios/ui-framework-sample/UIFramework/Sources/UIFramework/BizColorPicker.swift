import SwiftUI

/**
 * BizColorPicker - SwiftUI component matching Web UI-Framework `PPColorPicker.vue`.
 */
public struct BizColorPicker: View {
    public var modelValue: String
    public var colors: String
    public var allowCustom: Bool
    public var action: () -> Void

    public init(
        modelValue: String = "",
        colors: String = "() => [",
        allowCustom: Bool = true,
        action: @escaping () -> Void = {}
    ) {
        self.modelValue = modelValue
        self.colors = colors
        self.allowCustom = allowCustom
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("ColorPicker")
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
 * Web UI-Framework parity alias for [BizColorPicker].
 */
public typealias PPColorPicker = BizColorPicker
