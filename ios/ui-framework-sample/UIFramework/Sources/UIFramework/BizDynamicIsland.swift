import SwiftUI

/**
 * BizDynamicIsland - SwiftUI component matching Web UI-Framework `PPDynamicIsland.vue`.
 */
public struct BizDynamicIsland: View {
    public var modelValue: Bool
    public var state: String
    public var position: String
    public var offset: Int
    public var fullWidth: Bool
    public var wrapperClass: String
    public var autoHideTimeout: Int
    public var dismissOnOutsideClick: Bool
    public var bgColor: String
    public var textColor: String
    public var action: () -> Void

    public init(
        modelValue: Bool = false,
        state: String = "",
        position: String = "",
        offset: Int = 0,
        fullWidth: Bool = false,
        wrapperClass: String = "",
        autoHideTimeout: Int = 0,
        dismissOnOutsideClick: Bool = false,
        bgColor: String = "",
        textColor: String = "",
        action: @escaping () -> Void = {}
    ) {
        self.modelValue = modelValue
        self.state = state
        self.position = position
        self.offset = offset
        self.fullWidth = fullWidth
        self.wrapperClass = wrapperClass
        self.autoHideTimeout = autoHideTimeout
        self.dismissOnOutsideClick = dismissOnOutsideClick
        self.bgColor = bgColor
        self.textColor = textColor
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("DynamicIsland")
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
 * Web UI-Framework parity alias for [BizDynamicIsland].
 */
public typealias PPDynamicIsland = BizDynamicIsland
