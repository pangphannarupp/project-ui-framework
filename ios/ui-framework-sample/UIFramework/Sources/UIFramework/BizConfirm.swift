import SwiftUI

/**
 * BizConfirm - SwiftUI component matching Web UI-Framework `PPConfirm.vue`.
 */
public struct BizConfirm: View {
    public var modelValue: Bool
    public var title: String
    public var message: String
    public var confirmText: String
    public var cancelText: String
    public var confirmVariant: String
    public var dismissOnOverlayClick: Bool
    public var action: () -> Void

    public init(
        modelValue: Bool = false,
        title: String = "",
        message: String = "",
        confirmText: String = "",
        cancelText: String = "",
        confirmVariant: String = "",
        dismissOnOverlayClick: Bool = false,
        action: @escaping () -> Void = {}
    ) {
        self.modelValue = modelValue
        self.title = title
        self.message = message
        self.confirmText = confirmText
        self.cancelText = cancelText
        self.confirmVariant = confirmVariant
        self.dismissOnOverlayClick = dismissOnOverlayClick
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Confirm")
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
 * Web UI-Framework parity alias for [BizConfirm].
 */
public typealias PPConfirm = BizConfirm
