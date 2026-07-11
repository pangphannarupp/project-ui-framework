import SwiftUI

public struct BizBarChartData: Identifiable {
    public let id = UUID()
    public var label: String?
    public var value: Double
    public var color: Color?
    
    public init(label: String? = nil, value: Double, color: Color? = nil) {
        self.label = label
        self.value = value
        self.color = color
    }
}

public struct BizBarChart: View {
    public var data: [BizBarChartData]
    public var color: Color
    public var showValues: Bool
    public var barRadius: CGFloat
    
    public init(
        data: [BizBarChartData],
        color: Color = Color(hex: "#3880FF"),
        showValues: Bool = true,
        barRadius: CGFloat = 6
    ) {
        self.data = data
        self.color = color
        self.showValues = showValues
        self.barRadius = barRadius
    }
    
    public var body: some View {
        let maxValue = Swift.max(data.map { $0.value }.max() ?? 1, 0.001)
        
        GeometryReader { geometry in
            HStack(alignment: .bottom, spacing: 8) {
                ForEach(data) { item in
                    VStack(spacing: 0) {
                        Spacer(minLength: 0)
                        
                        if showValues {
                            Text("\(Int(item.value))")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(Color(hex: "#666666"))
                                .padding(.bottom, 8)
                        }
                        
                        let fraction = CGFloat(min(max(item.value / maxValue, 0), 1))
                        let availableHeight = geometry.size.height - (showValues ? 24 : 0) - (item.label != nil ? 24 : 0)
                        let barHeight = max(availableHeight * fraction, 4)
                        
                        Rectangle()
                            .fill(item.color ?? color)
                            .frame(width: max(geometry.size.width / CGFloat(data.count) - 16, 10), height: barHeight)
                            .cornerRadius(barRadius, corners: [.topLeft, .topRight])
                        
                        if let label = item.label {
                            Text(label)
                                .font(.system(size: 12))
                                .foregroundColor(Color(hex: "#999999"))
                                .padding(.top, 12)
                                .lineLimit(1)
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
            }
        }
    }
}


