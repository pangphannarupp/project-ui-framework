import SwiftUI

/**
 * BizDateRangePicker - SwiftUI component matching Web UI-Framework `PPDateRangePicker.vue`.
 */
public struct BizDateRangePicker: View {
    public var modelValue: String
    public var hideHeaderPicker: Bool
    public var hideNavButtons: Bool
    public var action: () -> Void

    public init(
        modelValue: String = "",
        hideHeaderPicker: Bool = false,
        hideNavButtons: Bool = false,
        action: @escaping () -> Void = {}
    ) {
        self.modelValue = modelValue
        self.hideHeaderPicker = hideHeaderPicker
        self.hideNavButtons = hideNavButtons
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("DateRangePicker")
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
 * Web UI-Framework parity alias for [BizDateRangePicker].
 */
public typealias PPDateRangePicker = BizDateRangePicker
