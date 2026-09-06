import SwiftUI

/**
 * BizReceivingAccountSheet - SwiftUI component matching Web UI-Framework `PPReceivingAccountSheet.vue`.
 */
public struct BizReceivingAccountSheet: View {
    public var modelValue: Bool
    public var accounts: [String]
    public var selectedAccountId: String
    public var action: () -> Void

    public init(
        modelValue: Bool = false,
        accounts: [String] = [],
        selectedAccountId: String = "",
        action: @escaping () -> Void = {}
    ) {
        self.modelValue = modelValue
        self.accounts = accounts
        self.selectedAccountId = selectedAccountId
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("ReceivingAccountSheet")
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
 * Web UI-Framework parity alias for [BizReceivingAccountSheet].
 */
public typealias PPReceivingAccountSheet = BizReceivingAccountSheet
