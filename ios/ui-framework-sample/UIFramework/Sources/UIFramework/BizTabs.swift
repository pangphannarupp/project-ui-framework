import SwiftUI

/**
 * BizTabs - SwiftUI component matching Web UI-Framework `PPTabs.vue`.
 */
public struct BizTabs: View {
    public var modelValue: Int
    public var variant: String
    public var action: () -> Void

    public init(
        modelValue: Int = 0,
        variant: String = "standard",
        action: @escaping () -> Void = {}
    ) {
        self.modelValue = modelValue
        self.variant = variant
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Tabs")
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
 * Web UI-Framework parity alias for [BizTabs].
 */
public typealias PPTabs = BizTabs
