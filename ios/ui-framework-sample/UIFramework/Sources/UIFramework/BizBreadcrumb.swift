import SwiftUI

/**
 * BizBreadcrumb - SwiftUI component matching Web UI-Framework `PPBreadcrumb.vue`.
 */
public struct BizBreadcrumb: View {
    public var items: [String]
    public var separator: String
    public var separatorIcon: String
    public var action: () -> Void

    public init(
        items: [String] = [],
        separator: String = "/",
        separatorIcon: String = "",
        action: @escaping () -> Void = {}
    ) {
        self.items = items
        self.separator = separator
        self.separatorIcon = separatorIcon
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Breadcrumb")
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
 * Web UI-Framework parity alias for [BizBreadcrumb].
 */
public typealias PPBreadcrumb = BizBreadcrumb
