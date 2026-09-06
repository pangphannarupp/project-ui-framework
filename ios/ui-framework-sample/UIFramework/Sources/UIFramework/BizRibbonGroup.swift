import SwiftUI

/**
 * BizRibbonGroup - SwiftUI component matching Web UI-Framework `PPRibbonGroup.vue`.
 */
public struct BizRibbonGroup: View {
    public var title: String
    public var action: () -> Void

    public init(
        title: String = "",
        action: @escaping () -> Void = {}
    ) {
        self.title = title
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("RibbonGroup")
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
 * Web UI-Framework parity alias for [BizRibbonGroup].
 */
public typealias PPRibbonGroup = BizRibbonGroup
