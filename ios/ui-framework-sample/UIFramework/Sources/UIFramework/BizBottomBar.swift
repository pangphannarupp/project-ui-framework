import SwiftUI

/**
 * BizBottomBar - SwiftUI component matching Web UI-Framework `PPBottomBar.vue`.
 */
public struct BizBottomBar: View {
    public var theme: String
    public var fixed: Bool
    public var bordered: Bool
    public var align: String
    public var action: () -> Void

    public init(
        theme: String = "light",
        fixed: Bool = true,
        bordered: Bool = true,
        align: String = "right",
        action: @escaping () -> Void = {}
    ) {
        self.theme = theme
        self.fixed = fixed
        self.bordered = bordered
        self.align = align
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("BottomBar")
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
 * Web UI-Framework parity alias for [BizBottomBar].
 */
public typealias PPBottomBar = BizBottomBar
