import SwiftUI

/**
 * BizNavigationDrawer - SwiftUI component matching Web UI-Framework `PPNavigationDrawer.vue`.
 */
public struct BizNavigationDrawer: View {
    public var modelValue: Bool
    public var title: String
    public var items: [String]
    public var type: String
    public var action: () -> Void

    public init(
        modelValue: Bool = false,
        title: String = "",
        items: [String] = [],
        type: String = "",
        action: @escaping () -> Void = {}
    ) {
        self.modelValue = modelValue
        self.title = title
        self.items = items
        self.type = type
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("NavigationDrawer")
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
 * Web UI-Framework parity alias for [BizNavigationDrawer].
 */
public typealias PPNavigationDrawer = BizNavigationDrawer
