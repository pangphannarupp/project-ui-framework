import SwiftUI

public struct BizLineChart: View {
    public var data: [Double]
    public var labels: [String]?
    public var color: Color
    public var strokeWidth: CGFloat
    public var showPoints: Bool
    public var showGrid: Bool
    
    public init(
        data: [Double],
        labels: [String]? = nil,
        color: Color = Color(hex: "#3880FF"),
        strokeWidth: CGFloat = 2,
        showPoints: Bool = true,
        showGrid: Bool = true
    ) {
        self.data = data
        self.labels = labels
        self.color = color
        self.strokeWidth = strokeWidth
        self.showPoints = showPoints
        self.showGrid = showGrid
    }
    
    public var body: some View {
        VStack(spacing: 8) {
            GeometryReader { geometry in
                let maxVal = Swift.max(data.max() ?? 1, 0.001)
                let minVal = Swift.min(data.min() ?? 0, 0)
                let range = maxVal - minVal
                
                ZStack {
                    // Grid
                    if showGrid {
                        ForEach(0..<5) { i in
                            let y = geometry.size.height * CGFloat(i) / 4.0
                            Path { path in
                                path.move(to: CGPoint(x: 0, y: y))
                                path.addLine(to: CGPoint(x: geometry.size.width, y: y))
                            }
                            .stroke(Color(hex: "#F0F0F0"), lineWidth: 1)
                        }
                    }
                    
                    if !data.isEmpty {
                        // Line
                        Path { path in
                            for (index, value) in data.enumerated() {
                                let xRatio = data.count > 1 ? CGFloat(index) / CGFloat(data.count - 1) : 0.5
                                let yRatio = CGFloat(1.0 - ((value - minVal) / range))
                                
                                let pt = CGPoint(
                                    x: geometry.size.width * xRatio,
                                    y: geometry.size.height * yRatio
                                )
                                
                                if index == 0 {
                                    path.move(to: pt)
                                } else {
                                    path.addLine(to: pt)
                                }
                            }
                        }
                        .stroke(color, style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round, lineJoin: .round))
                        
                        // Points
                        if showPoints {
                            ForEach(0..<data.count, id: \.self) { index in
                                let value = data[index]
                                let xRatio = data.count > 1 ? CGFloat(index) / CGFloat(data.count - 1) : 0.5
                                let yRatio = CGFloat(1.0 - ((value - minVal) / range))
                                
                                let pt = CGPoint(
                                    x: geometry.size.width * xRatio,
                                    y: geometry.size.height * yRatio
                                )
                                
                                Circle()
                                    .fill(color)
                                    .frame(width: 8, height: 8)
                                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                    .position(pt)
                            }
                        }
                    }
                }
            }
            .padding(.vertical, 16)
            
            // X-Axis Labels
            if let labels = labels, !labels.isEmpty {
                HStack {
                    ForEach(0..<labels.count, id: \.self) { index in
                        Text(labels[index])
                            .font(.system(size: 12))
                            .foregroundColor(Color(hex: "#999999"))
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
        }
    }
}
