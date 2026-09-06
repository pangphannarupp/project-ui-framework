import SwiftUI

/**
 * BizTreeSelect - SwiftUI component matching Web UI-Framework `PPTreeSelect.vue`.
 */
public struct BizTreeSelect: View {
    public var modelValue: Int
    public var data: [String]
    public var label: String
    public var placeholder: String
    public var variant: String
    public var error: String
    public var helperText: String
    public var disabled: Bool
    public var required: Bool
    public var iconLeft: String
    public var clearable: Bool
    public var expandAll: Bool
    public var action: () -> Void

    public init(
        modelValue: Int = 0,
        data: [String] = [],
        label: String = "",
        placeholder: String = "",
        variant: String = "",
        error: String = "",
        helperText: String = "",
        disabled: Bool = false,
        required: Bool = false,
        iconLeft: String = "",
        clearable: Bool = false,
        expandAll: Bool = false,
        action: @escaping () -> Void = {}
    ) {
        self.modelValue = modelValue
        self.data = data
        self.label = label
        self.placeholder = placeholder
        self.variant = variant
        self.error = error
        self.helperText = helperText
        self.disabled = disabled
        self.required = required
        self.iconLeft = iconLeft
        self.clearable = clearable
        self.expandAll = expandAll
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("TreeSelect")
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
 * Web UI-Framework parity alias for [BizTreeSelect].
 */
public typealias PPTreeSelect = BizTreeSelect
