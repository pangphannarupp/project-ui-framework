import SwiftUI

/**
 * BizDonutChart - SwiftUI component matching Web UI-Framework `PPDonutChart.vue`.
 */
public struct BizDonutChart: View {
    public var data: [String]
    public var size: Int
    public var thickness: Int
    public var trackColor: String
    public var label: String
    public var value: String
    public var rounded: Bool
    public var action: () -> Void

    public init(
        data: [String] = [],
        size: Int = 200,
        thickness: Int = 16,
        trackColor: String = "#f0f0f0",
        label: String = "",
        value: String = "",
        rounded: Bool = false,
        action: @escaping () -> Void = {}
    ) {
        self.data = data
        self.size = size
        self.thickness = thickness
        self.trackColor = trackColor
        self.label = label
        self.value = value
        self.rounded = rounded
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("DonutChart")
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
 * Web UI-Framework parity alias for [BizDonutChart].
 */
public typealias PPDonutChart = BizDonutChart
