import SwiftUI

/**
 * BizDropdown - SwiftUI component matching Web UI-Framework `PPDropdown.vue`.
 */
public struct BizDropdown: View {
    public var items: [String]
    public var placement: String
    public var action: () -> Void

    public init(
        items: [String] = [],
        placement: String = "bottom-right",
        action: @escaping () -> Void = {}
    ) {
        self.items = items
        self.placement = placement
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Dropdown")
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
 * Web UI-Framework parity alias for [BizDropdown].
 */
public typealias PPDropdown = BizDropdown
