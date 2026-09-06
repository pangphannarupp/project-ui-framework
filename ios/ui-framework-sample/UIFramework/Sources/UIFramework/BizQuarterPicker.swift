import SwiftUI

/**
 * BizQuarterPicker - SwiftUI component matching Web UI-Framework `PPQuarterPicker.vue`.
 */
public struct BizQuarterPicker: View {
    public var config: String
    public var initialDate: String
    public var showActionButtons: Bool
    public var cancelText: String
    public var confirmText: String
    public var action: () -> Void

    public init(
        config: String = "",
        initialDate: String = "",
        showActionButtons: Bool = false,
        cancelText: String = "",
        confirmText: String = "",
        action: @escaping () -> Void = {}
    ) {
        self.config = config
        self.initialDate = initialDate
        self.showActionButtons = showActionButtons
        self.cancelText = cancelText
        self.confirmText = confirmText
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("QuarterPicker")
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
 * Web UI-Framework parity alias for [BizQuarterPicker].
 */
public typealias PPQuarterPicker = BizQuarterPicker
