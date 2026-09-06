import SwiftUI

/**
 * BizHeaderBar - SwiftUI component matching Web UI-Framework `PPHeaderBar.vue`.
 */
public struct BizHeaderBar: View {
    public var theme: String
    public var fixed: Bool
    public var height: String
    public var bordered: Bool
    public var action: () -> Void

    public init(
        theme: String = "light",
        fixed: Bool = false,
        height: String = "64px",
        bordered: Bool = true,
        action: @escaping () -> Void = {}
    ) {
        self.theme = theme
        self.fixed = fixed
        self.height = height
        self.bordered = bordered
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("HeaderBar")
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
 * Web UI-Framework parity alias for [BizHeaderBar].
 */
public typealias PPHeaderBar = BizHeaderBar
