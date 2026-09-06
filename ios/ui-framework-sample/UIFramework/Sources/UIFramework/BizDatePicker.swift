import SwiftUI

/**
 * BizDatePicker - SwiftUI component matching Web UI-Framework `PPDatePicker.vue`.
 */
public struct BizDatePicker: View {
    public var modelValue: String
    public var placeholder: String
    public var clearable: Bool
    public var format: String
    public var action: () -> Void

    public init(
        modelValue: String = "",
        placeholder: String = "Select a date",
        clearable: Bool = true,
        format: String = "",
        action: @escaping () -> Void = {}
    ) {
        self.modelValue = modelValue
        self.placeholder = placeholder
        self.clearable = clearable
        self.format = format
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("DatePicker")
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
 * Web UI-Framework parity alias for [BizDatePicker].
 */
public typealias PPDatePicker = BizDatePicker
