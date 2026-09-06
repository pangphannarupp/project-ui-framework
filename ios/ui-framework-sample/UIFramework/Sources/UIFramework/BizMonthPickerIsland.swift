import SwiftUI

/**
 * BizMonthPickerIsland - SwiftUI component matching Web UI-Framework `PPMonthPickerIsland.vue`.
 */
public struct BizMonthPickerIsland: View {
    public var modelValue: Bool
    public var title: String
    public var config: String
    public var initialDate: String
    public var showActionButtons: Bool
    public var cancelText: String
    public var confirmText: String
    public var position: String
    public var fullWidth: Bool
    public var offset: Int
    public var action: () -> Void

    public init(
        modelValue: Bool = false,
        title: String = "",
        config: String = "",
        initialDate: String = "",
        showActionButtons: Bool = false,
        cancelText: String = "",
        confirmText: String = "",
        position: String = "top",
        fullWidth: Bool = false,
        offset: Int = 16,
        action: @escaping () -> Void = {}
    ) {
        self.modelValue = modelValue
        self.title = title
        self.config = config
        self.initialDate = initialDate
        self.showActionButtons = showActionButtons
        self.cancelText = cancelText
        self.confirmText = confirmText
        self.position = position
        self.fullWidth = fullWidth
        self.offset = offset
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("MonthPickerIsland")
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
 * Web UI-Framework parity alias for [BizMonthPickerIsland].
 */
public typealias PPMonthPickerIsland = BizMonthPickerIsland
