import SwiftUI

/**
 * BizRadarChart - SwiftUI component matching Web UI-Framework `PPRadarChart.vue`.
 */
public struct BizRadarChart: View {
    public var data: Int
    public var labels: String
    public var size: Int
    public var color: String
    public var levels: Int
    public var action: () -> Void

    public init(
        data: Int = 0,
        labels: String = "",
        size: Int = 240,
        color: String = "var(--pp-primary-light",
        levels: Int = 4,
        action: @escaping () -> Void = {}
    ) {
        self.data = data
        self.labels = labels
        self.size = size
        self.color = color
        self.levels = levels
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("RadarChart")
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
 * Web UI-Framework parity alias for [BizRadarChart].
 */
public typealias PPRadarChart = BizRadarChart
