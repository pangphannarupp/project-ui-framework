import SwiftUI

/**
 * BizYearPicker - SwiftUI component matching Web UI-Framework `PPYearPicker.vue`.
 */
public struct BizYearPicker: View {
    public var config: String
    public var initialYear: Int
    public var initialEndYear: Int
    public var title: String
    public var showActionButtons: Bool
    public var action: () -> Void

    public init(
        config: String = "",
        initialYear: Int = 0,
        initialEndYear: Int = 0,
        title: String = "",
        showActionButtons: Bool = false,
        action: @escaping () -> Void = {}
    ) {
        self.config = config
        self.initialYear = initialYear
        self.initialEndYear = initialEndYear
        self.title = title
        self.showActionButtons = showActionButtons
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("YearPicker")
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
 * Web UI-Framework parity alias for [BizYearPicker].
 */
public typealias PPYearPicker = BizYearPicker
