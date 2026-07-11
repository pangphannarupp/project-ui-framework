import SwiftUI

public struct BizSlider: View {
    @Binding public var value: Double
    public var bounds: ClosedRange<Double>
    public var step: Double?
    public var label: String?
    public var showValue: Bool
    public var formatValue: ((Double) -> String)?
    public var color: Color
    
    public init(
        value: Binding<Double>,
        bounds: ClosedRange<Double> = 0...100,
        step: Double? = nil,
        label: String? = nil,
        showValue: Bool = false,
        formatValue: ((Double) -> String)? = nil,
        color: Color = Color(hex: "#003399")
    ) {
        self._value = value
        self.bounds = bounds
        self.step = step
        self.label = label
        self.showValue = showValue
        self.formatValue = formatValue
        self.color = color
    }
    
    public var body: some View {
        VStack(spacing: 4) {
            if label != nil || showValue {
                HStack {
                    if let label = label {
                        Text(label)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color(hex: "#1A2A5E"))
                    }
                    Spacer()
                    if showValue {
                        let displayValue = formatValue?(value) ?? String(format: "%.0f", value)
                        Text(displayValue)
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(color)
                    }
                }
                .padding(.horizontal, 4)
            }
            
            if let step = step {
                Slider(value: $value, in: bounds, step: step)
                    .accentColor(color)
            } else {
                Slider(value: $value, in: bounds)
                    .accentColor(color)
            }
        }
    }
}
