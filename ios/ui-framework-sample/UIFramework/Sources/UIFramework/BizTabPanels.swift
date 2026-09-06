import SwiftUI

/**
 * BizTabPanels - SwiftUI component matching Web UI-Framework `PPTabPanels.vue`.
 */
public struct BizTabPanels: View {
    public var action: () -> Void

    public init(
        action: @escaping () -> Void = {}
    ) {
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("TabPanels")
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
 * Web UI-Framework parity alias for [BizTabPanels].
 */
public typealias PPTabPanels = BizTabPanels
