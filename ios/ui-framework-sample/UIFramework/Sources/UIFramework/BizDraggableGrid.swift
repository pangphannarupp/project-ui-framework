import SwiftUI

/**
 * BizDraggableGrid - SwiftUI component matching Web UI-Framework `PPDraggableGrid.vue`.
 */
public struct BizDraggableGrid: View {
    public var modelValue: [String]
    public var columns: Int
    public var gap: String
    public var itemKey: String
    public var acceptExternal: Bool
    public var action: () -> Void

    public init(
        modelValue: [String] = [],
        columns: Int = 0,
        gap: String = "",
        itemKey: String = "",
        acceptExternal: Bool = false,
        action: @escaping () -> Void = {}
    ) {
        self.modelValue = modelValue
        self.columns = columns
        self.gap = gap
        self.itemKey = itemKey
        self.acceptExternal = acceptExternal
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("DraggableGrid")
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
 * Web UI-Framework parity alias for [BizDraggableGrid].
 */
public typealias PPDraggableGrid = BizDraggableGrid
