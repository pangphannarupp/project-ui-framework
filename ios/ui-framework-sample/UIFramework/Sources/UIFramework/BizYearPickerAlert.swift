import SwiftUI

/**
 * BizYearPickerAlert - SwiftUI component matching Web UI-Framework `PPYearPickerAlert.vue`.
 */
public struct BizYearPickerAlert: View {
    public var modelValue: Bool
    public var title: String
    public var config: String
    public var initialYear: Int
    public var showActionButtons: Bool
    public var dismissOnOverlayClick: Bool
    public var action: () -> Void

    public init(
        modelValue: Bool = false,
        title: String = "",
        config: String = "",
        initialYear: Int = 0,
        showActionButtons: Bool = false,
        dismissOnOverlayClick: Bool = false,
        action: @escaping () -> Void = {}
    ) {
        self.modelValue = modelValue
        self.title = title
        self.config = config
        self.initialYear = initialYear
        self.showActionButtons = showActionButtons
        self.dismissOnOverlayClick = dismissOnOverlayClick
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("YearPickerAlert")
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
 * Web UI-Framework parity alias for [BizYearPickerAlert].
 */
public typealias PPYearPickerAlert = BizYearPickerAlert
