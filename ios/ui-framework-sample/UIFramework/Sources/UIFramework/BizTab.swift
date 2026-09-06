import SwiftUI

/**
 * BizTab - SwiftUI component matching Web UI-Framework `PPTab.vue`.
 */
public struct BizTab: View {
    public var value: Int
    public var action: () -> Void

    public init(
        value: Int = 0,
        action: @escaping () -> Void = {}
    ) {
        self.value = value
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Tab")
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
 * Web UI-Framework parity alias for [BizTab].
 */
public typealias PPTab = BizTab
