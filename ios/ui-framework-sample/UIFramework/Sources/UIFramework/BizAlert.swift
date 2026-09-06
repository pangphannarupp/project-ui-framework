import SwiftUI

/**
 * BizAlert - SwiftUI component matching Web UI-Framework `PPAlert.vue`.
 */
public struct BizAlert: View {
    public var modelValue: Bool
    public var title: String
    public var message: String
    public var confirmText: String
    public var dismissOnOverlayClick: Bool
    public var backdropType: String
    public var action: () -> Void

    public init(
        modelValue: Bool = false,
        title: String = "",
        message: String = "",
        confirmText: String = "",
        dismissOnOverlayClick: Bool = false,
        backdropType: String = "",
        action: @escaping () -> Void = {}
    ) {
        self.modelValue = modelValue
        self.title = title
        self.message = message
        self.confirmText = confirmText
        self.dismissOnOverlayClick = dismissOnOverlayClick
        self.backdropType = backdropType
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Alert")
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
 * Web UI-Framework parity alias for [BizAlert].
 */
public typealias PPAlert = BizAlert
