import SwiftUI

public struct BizPieSegment {
    public var value: Double
    public var color: Color
    
    public init(value: Double, color: Color) {
        self.value = value
        self.color = color
    }
}

public struct BizPieChart: View {
    public var data: [BizPieSegment]
    
    public init(data: [BizPieSegment]) {
        self.data = data
    }
    
    public var body: some View {
        let total = max(data.reduce(0) { $0 + $1.value }, 0.001)
        
        GeometryReader { geometry in
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
            let radius = min(geometry.size.width, geometry.size.height) / 2
            
            ZStack {
                var startAngle: Double = 0
                
                ForEach(0..<data.count, id: \.self) { index in
                    let segment = data[index]
                    let sweepAngle = (segment.value / total) * 360
                    let endAngle = startAngle + sweepAngle
                    
                    Path { path in
                        path.move(to: center)
                        path.addArc(
                            center: center,
                            radius: radius,
                            startAngle: .degrees(startAngle),
                            endAngle: .degrees(endAngle),
                            clockwise: false
                        )
                        path.closeSubpath()
                    }
                    .fill(segment.color)
                    .overlay(
                        Path { path in
                            path.move(to: center)
                            path.addArc(
                                center: center,
                                radius: radius,
                                startAngle: .degrees(startAngle),
                                endAngle: .degrees(endAngle),
                                clockwise: false
                            )
                            path.closeSubpath()
                        }
                        .stroke(Color.white, lineWidth: 1)
                    )
                    
                    // We must update the start angle inline or use a calculation.
                    // In SwiftUI we calculate it in a let instead of mutating a var inside the view builder loop,
                    // but since we need cumulative:
                    let _ = { startAngle = endAngle }()
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}
