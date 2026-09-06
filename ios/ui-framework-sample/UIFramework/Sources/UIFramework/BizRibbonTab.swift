import SwiftUI

/**
 * BizRibbonTab - SwiftUI component matching Web UI-Framework `PPRibbonTab.vue`.
 */
public struct BizRibbonTab: View {
    public var title: String
    public var color: String
    public var id: String
    public var action: () -> Void

    public init(
        title: String = "",
        color: String = "",
        id: String = "",
        action: @escaping () -> Void = {}
    ) {
        self.title = title
        self.color = color
        self.id = id
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("RibbonTab")
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
 * Web UI-Framework parity alias for [BizRibbonTab].
 */
public typealias PPRibbonTab = BizRibbonTab
