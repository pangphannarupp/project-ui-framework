import SwiftUI

/**
 * BizTabList - SwiftUI component matching Web UI-Framework `PPTabList.vue`.
 */
public struct BizTabList: View {
    public var scrollable: Bool
    public var action: () -> Void

    public init(
        scrollable: Bool = false,
        action: @escaping () -> Void = {}
    ) {
        self.scrollable = scrollable
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("TabList")
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
 * Web UI-Framework parity alias for [BizTabList].
 */
public typealias PPTabList = BizTabList
