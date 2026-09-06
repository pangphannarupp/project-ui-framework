import SwiftUI

/**
 * BizAnimatedTabs - SwiftUI component matching Web UI-Framework `PPAnimatedTabs.vue`.
 */
public struct BizAnimatedTabs: View {
    public var modelValue: Int
    public var tabs: [String]
    public var action: () -> Void

    public init(
        modelValue: Int = 0,
        tabs: [String] = [],
        action: @escaping () -> Void = {}
    ) {
        self.modelValue = modelValue
        self.tabs = tabs
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("AnimatedTabs")
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
 * Web UI-Framework parity alias for [BizAnimatedTabs].
 */
public typealias PPAnimatedTabs = BizAnimatedTabs
