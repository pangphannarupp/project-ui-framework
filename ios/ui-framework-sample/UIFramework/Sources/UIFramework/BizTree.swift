import SwiftUI

/**
 * BizTree - SwiftUI component matching Web UI-Framework `PPTree.vue`.
 */
public struct BizTree: View {
    public var data: [String]
    public var expandAll: Bool
    public var selectable: Bool
    public var variant: String
    public var action: () -> Void

    public init(
        data: [String] = [],
        expandAll: Bool = false,
        selectable: Bool = false,
        variant: String = "",
        action: @escaping () -> Void = {}
    ) {
        self.data = data
        self.expandAll = expandAll
        self.selectable = selectable
        self.variant = variant
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Tree")
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
 * Web UI-Framework parity alias for [BizTree].
 */
public typealias PPTree = BizTree
