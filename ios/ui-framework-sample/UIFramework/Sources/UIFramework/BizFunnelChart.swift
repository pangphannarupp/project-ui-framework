import SwiftUI

/**
 * BizFunnelChart - SwiftUI component matching Web UI-Framework `PPFunnelChart.vue`.
 */
public struct BizFunnelChart: View {
    public var data: [String]
    public var height: Int
    public var colors: String
    public var action: () -> Void

    public init(
        data: [String] = [],
        height: Int = 240,
        colors: String = "() => ['var(--pp-primary-light",
        action: @escaping () -> Void = {}
    ) {
        self.data = data
        self.height = height
        self.colors = colors
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("FunnelChart")
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
 * Web UI-Framework parity alias for [BizFunnelChart].
 */
public typealias PPFunnelChart = BizFunnelChart
