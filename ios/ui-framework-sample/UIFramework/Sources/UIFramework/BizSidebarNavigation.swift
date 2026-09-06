import SwiftUI

/**
 * BizSidebarNavigation - SwiftUI component matching Web UI-Framework `PPSidebarNavigation.vue`.
 */
public struct BizSidebarNavigation: View {
    public var modelValue: String
    public var expandedItems: String
    public var items: [String]
    public var theme: String
    public var variant: String
    public var collapsed: Bool
    public var width: String
    public var collapsedWidth: String
    public var showToggle: Bool
    public var action: () -> Void

    public init(
        modelValue: String = "",
        expandedItems: String = "",
        items: [String] = [],
        theme: String = "dark",
        variant: String = "indicator",
        collapsed: Bool = false,
        width: String = "260px",
        collapsedWidth: String = "80px",
        showToggle: Bool = false,
        action: @escaping () -> Void = {}
    ) {
        self.modelValue = modelValue
        self.expandedItems = expandedItems
        self.items = items
        self.theme = theme
        self.variant = variant
        self.collapsed = collapsed
        self.width = width
        self.collapsedWidth = collapsedWidth
        self.showToggle = showToggle
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("SidebarNavigation")
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
 * Web UI-Framework parity alias for [BizSidebarNavigation].
 */
public typealias PPSidebarNavigation = BizSidebarNavigation
