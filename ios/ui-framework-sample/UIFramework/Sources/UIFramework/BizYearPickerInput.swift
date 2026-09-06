import SwiftUI

/**
 * BizYearPickerInput - SwiftUI component matching Web UI-Framework `PPYearPickerInput.vue`.
 */
public struct BizYearPickerInput: View {
    public var modelValue: Int
    public var placeholder: String
    public var clearable: Bool
    public var format: Int
    public var action: () -> Void

    public init(
        modelValue: Int = 0,
        placeholder: String = "Select a year",
        clearable: Bool = true,
        format: Int = 0,
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
                Text("YearPickerInput")
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
 * Web UI-Framework parity alias for [BizYearPickerInput].
 */
public typealias PPYearPickerInput = BizYearPickerInput
