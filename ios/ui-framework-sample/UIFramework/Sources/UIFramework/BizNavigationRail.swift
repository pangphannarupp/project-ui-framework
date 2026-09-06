import SwiftUI

/**
 * BizNavigationRail - SwiftUI component matching Web UI-Framework `PPNavigationRail.vue`.
 */
public struct BizNavigationRail: View {
    public var items: [String]
    public var showMenu: Bool
    public var action: () -> Void

    public init(
        items: [String] = [],
        showMenu: Bool = false,
        action: @escaping () -> Void = {}
    ) {
        self.items = items
        self.showMenu = showMenu
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("NavigationRail")
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
 * Web UI-Framework parity alias for [BizNavigationRail].
 */
public typealias PPNavigationRail = BizNavigationRail
