import SwiftUI

/**
 * BizReceiveAmountSheet - SwiftUI component matching Web UI-Framework `PPReceiveAmountSheet.vue`.
 */
public struct BizReceiveAmountSheet: View {
    public var modelValue: Bool
    public var action: () -> Void

    public init(
        modelValue: Bool = false,
        action: @escaping () -> Void = {}
    ) {
        self.modelValue = modelValue
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("ReceiveAmountSheet")
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
 * Web UI-Framework parity alias for [BizReceiveAmountSheet].
 */
public typealias PPReceiveAmountSheet = BizReceiveAmountSheet
