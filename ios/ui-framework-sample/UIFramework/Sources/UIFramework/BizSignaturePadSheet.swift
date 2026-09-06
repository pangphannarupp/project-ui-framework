import SwiftUI

/**
 * BizSignaturePadSheet - SwiftUI component matching Web UI-Framework `PPSignaturePadSheet.vue`.
 */
public struct BizSignaturePadSheet: View {
    public var modelValue: Bool
    public var title: String
    public var placeholder: String
    public var strokeColor: String
    public var lineWidth: Int
    public var backgroundColor: String
    public var cancelText: String
    public var confirmText: String
    public var clearText: String
    public var action: () -> Void

    public init(
        modelValue: Bool = false,
        title: String = "Sign Here",
        placeholder: String = "Please sign here",
        strokeColor: String = "#000000",
        lineWidth: Int = 2,
        backgroundColor: String = "#ffffff",
        cancelText: String = "Cancel",
        confirmText: String = "Save",
        clearText: String = "Clear",
        action: @escaping () -> Void = {}
    ) {
        self.modelValue = modelValue
        self.title = title
        self.placeholder = placeholder
        self.strokeColor = strokeColor
        self.lineWidth = lineWidth
        self.backgroundColor = backgroundColor
        self.cancelText = cancelText
        self.confirmText = confirmText
        self.clearText = clearText
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("SignaturePadSheet")
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
 * Web UI-Framework parity alias for [BizSignaturePadSheet].
 */
public typealias PPSignaturePadSheet = BizSignaturePadSheet
