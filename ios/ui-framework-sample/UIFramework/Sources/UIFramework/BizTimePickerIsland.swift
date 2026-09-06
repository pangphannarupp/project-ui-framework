import SwiftUI

/**
 * BizTimePickerIsland - SwiftUI component matching Web UI-Framework `PPTimePickerIsland.vue`.
 */
public struct BizTimePickerIsland: View {
    public var modelValue: Bool
    public var timeValue: String
    public var title: String
    public var min: String
    public var max: String
    public var minuteValues: Int
    public var hourCycle: String
    public var showActionButtons: Bool
    public var position: String
    public var fullWidth: Bool
    public var offset: Int
    public var theme: String
    public var action: () -> Void

    public init(
        modelValue: Bool = false,
        timeValue: String = "",
        title: String = "",
        min: String = "",
        max: String = "",
        minuteValues: Int = 0,
        hourCycle: String = "primary",
        showActionButtons: Bool = false,
        position: String = "top",
        fullWidth: Bool = false,
        offset: Int = 16,
        theme: String = "auto",
        action: @escaping () -> Void = {}
    ) {
        self.modelValue = modelValue
        self.timeValue = timeValue
        self.title = title
        self.min = min
        self.max = max
        self.minuteValues = minuteValues
        self.hourCycle = hourCycle
        self.showActionButtons = showActionButtons
        self.position = position
        self.fullWidth = fullWidth
        self.offset = offset
        self.theme = theme
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("TimePickerIsland")
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
 * Web UI-Framework parity alias for [BizTimePickerIsland].
 */
public typealias PPTimePickerIsland = BizTimePickerIsland
