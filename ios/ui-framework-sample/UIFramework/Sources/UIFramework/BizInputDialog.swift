import SwiftUI

/**
 * BizInputDialog - SwiftUI component matching Web UI-Framework `PPInputDialog.vue`.
 */
public struct BizInputDialog: View {
    public var modelValue: Bool
    public var title: String
    public var message: String
    public var initialValue: String
    public var placeholder: String
    public var inputType: String
    public var confirmText: String
    public var cancelText: String
    public var required: Bool
    public var dismissOnOverlayClick: Bool
    public var action: () -> Void

    public init(
        modelValue: Bool = false,
        title: String = "",
        message: String = "",
        initialValue: String = "",
        placeholder: String = "",
        inputType: String = "",
        confirmText: String = "",
        cancelText: String = "",
        required: Bool = false,
        dismissOnOverlayClick: Bool = false,
        action: @escaping () -> Void = {}
    ) {
        self.modelValue = modelValue
        self.title = title
        self.message = message
        self.initialValue = initialValue
        self.placeholder = placeholder
        self.inputType = inputType
        self.confirmText = confirmText
        self.cancelText = cancelText
        self.required = required
        self.dismissOnOverlayClick = dismissOnOverlayClick
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("InputDialog")
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
 * Web UI-Framework parity alias for [BizInputDialog].
 */
public typealias PPInputDialog = BizInputDialog
