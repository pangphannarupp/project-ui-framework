import SwiftUI

/**
 * BizContextMenu - SwiftUI component matching Web UI-Framework `PPContextMenu.vue`.
 */
public struct BizContextMenu: View {
    public var items: [String]
    public var triggerMode: String
    public var placement: String
    public var action: () -> Void

    public init(
        items: [String] = [],
        triggerMode: String = "click",
        placement: String = "bottom-left",
        action: @escaping () -> Void = {}
    ) {
        self.items = items
        self.triggerMode = triggerMode
        self.placement = placement
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("ContextMenu")
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
 * Web UI-Framework parity alias for [BizContextMenu].
 */
public typealias PPContextMenu = BizContextMenu
