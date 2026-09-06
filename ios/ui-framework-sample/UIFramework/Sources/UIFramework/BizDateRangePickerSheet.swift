import SwiftUI

/**
 * BizDateRangePickerSheet - SwiftUI component matching Web UI-Framework `PPDateRangePickerSheet.vue`.
 */
public struct BizDateRangePickerSheet: View {
    public var visible: Bool
    public var modelValue: String
    public var hideHeaderPicker: Bool
    public var hideNavButtons: Bool
    public var action: () -> Void

    public init(
        visible: Bool = false,
        modelValue: String = "() => ({ start: null",
        hideHeaderPicker: Bool = false,
        hideNavButtons: Bool = false,
        action: @escaping () -> Void = {}
    ) {
        self.visible = visible
        self.modelValue = modelValue
        self.hideHeaderPicker = hideHeaderPicker
        self.hideNavButtons = hideNavButtons
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("DateRangePickerSheet")
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
 * Web UI-Framework parity alias for [BizDateRangePickerSheet].
 */
public typealias PPDateRangePickerSheet = BizDateRangePickerSheet
