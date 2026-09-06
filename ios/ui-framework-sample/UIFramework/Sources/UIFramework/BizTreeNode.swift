import SwiftUI

/**
 * BizTreeNode - SwiftUI component matching Web UI-Framework `PPTreeNode.vue`.
 */
public struct BizTreeNode: View {
    public var node: String
    public var level: Int
    public var isLast: Bool
    public var action: () -> Void

    public init(
        node: String = "",
        level: Int = 0,
        isLast: Bool = false,
        action: @escaping () -> Void = {}
    ) {
        self.node = node
        self.level = level
        self.isLast = isLast
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("TreeNode")
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
 * Web UI-Framework parity alias for [BizTreeNode].
 */
public typealias PPTreeNode = BizTreeNode
