import SwiftUI

/**
 * BizCollapseItem - SwiftUI component matching Web UI-Framework `PPCollapseItem.vue`.
 */
public struct BizCollapseItem: View {
    public var name: Int
    public var title: String
    public var disabled: Bool
    public var action: () -> Void

    public init(
        name: Int = 0,
        title: String = "",
        disabled: Bool = false,
        action: @escaping () -> Void = {}
    ) {
        self.name = name
        self.title = title
        self.disabled = disabled
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("CollapseItem")
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
 * Web UI-Framework parity alias for [BizCollapseItem].
 */
public typealias PPCollapseItem = BizCollapseItem
