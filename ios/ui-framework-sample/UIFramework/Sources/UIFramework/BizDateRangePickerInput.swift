import SwiftUI

/**
 * BizDateRangePickerInput - SwiftUI component matching Web UI-Framework `PPDateRangePickerInput.vue`.
 */
public struct BizDateRangePickerInput: View {
    public var modelValue: String
    public var placeholder: String
    public var clearable: Bool
    public var format: String
    public var action: () -> Void

    public init(
        modelValue: String = "",
        placeholder: String = "Select a date range",
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
                Text("DateRangePickerInput")
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
 * Web UI-Framework parity alias for [BizDateRangePickerInput].
 */
public typealias PPDateRangePickerInput = BizDateRangePickerInput
