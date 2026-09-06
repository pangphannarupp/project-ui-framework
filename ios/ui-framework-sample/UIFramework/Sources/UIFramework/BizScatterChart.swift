import SwiftUI

/**
 * BizScatterChart - SwiftUI component matching Web UI-Framework `PPScatterChart.vue`.
 */
public struct BizScatterChart: View {
    public var data: [String]
    public var height: Int
    public var color: String
    public var defaultRadius: Int
    public var showGrid: Bool
    public var maxX: Int
    public var maxY: Int
    public var action: () -> Void

    public init(
        data: [String] = [],
        height: Int = 240,
        color: String = "var(--pp-primary-light",
        defaultRadius: Int = 6,
        showGrid: Bool = true,
        maxX: Int = 0,
        maxY: Int = 0,
        action: @escaping () -> Void = {}
    ) {
        self.data = data
        self.height = height
        self.color = color
        self.defaultRadius = defaultRadius
        self.showGrid = showGrid
        self.maxX = maxX
        self.maxY = maxY
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("ScatterChart")
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
 * Web UI-Framework parity alias for [BizScatterChart].
 */
public typealias PPScatterChart = BizScatterChart
