import SwiftUI

public struct BizProgressGauge: View {
    public var value: Double
    public var max: Double
    public var thickness: CGFloat
    public var color: Color
    public var trackColor: Color
    public var label: String?
    public var format: ((Double) -> String)?
    
    @State private var animatedPercentage: Double = 0.0
    
    public init(
        value: Double,
        max: Double = 100,
        thickness: CGFloat = 8,
        color: Color = Color(hex: "#3880FF"),
        trackColor: Color = Color(hex: "#E0E0E0"),
        label: String? = nil,
        format: ((Double) -> String)? = nil
    ) {
        self.value = value
        self.max = max
        self.thickness = thickness
        self.color = color
        self.trackColor = trackColor
        self.label = label
        self.format = format
    }
    
    public var body: some View {
        let percentage = min(Swift.max(value / max, 0), 1)
        
        GeometryReader { geometry in
            let width = geometry.size.width
            let radius = width / 2
            let center = CGPoint(x: width / 2, y: width / 2) // We draw in a square bounds, but frame is height = width/2
            
            ZStack(alignment: .bottom) {
                // Background Track
                Path { path in
                    path.addArc(
                        center: center,
                        radius: radius - (thickness / 2),
                        startAngle: .degrees(180),
                        endAngle: .degrees(0),
                        clockwise: false
                    )
                }
                .stroke(trackColor, style: StrokeStyle(lineWidth: thickness, lineCap: .round))
                
                // Progress Track
                Path { path in
                    path.addArc(
                        center: center,
                        radius: radius - (thickness / 2),
                        startAngle: .degrees(180),
                        endAngle: .degrees(180 + (animatedPercentage * 180)),
                        clockwise: false
                    )
                }
                .stroke(color, style: StrokeStyle(lineWidth: thickness, lineCap: .round))
                
                // Text
                VStack(spacing: 4) {
                    let textValue = format?(value) ?? String(format: "%.0f", value)
                    Text(textValue)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(color)
                    
                    if let label = label {
                        Text(label)
                            .font(.system(size: 12))
                            .foregroundColor(Color(hex: "#999999"))
                    }
                }
                .padding(.bottom, 8)
                .position(x: center.x, y: center.y - 10)
            }
        }
        .aspectRatio(2, contentMode: .fit) // height is half of width
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.timingCurve(0.34, 1.56, 0.64, 1, duration: 1.5)) {
                    animatedPercentage = percentage
                }
            }
        }
    }
}
