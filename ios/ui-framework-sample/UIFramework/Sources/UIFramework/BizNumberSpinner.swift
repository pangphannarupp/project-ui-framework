import SwiftUI

public struct BizNumberSpinner: View {
    @Binding public var value: Int
    public var min: Int?
    public var max: Int?
    public var step: Int
    public var disabled: Bool
    
    @State private var isFocused: Bool = false
    
    public init(
        value: Binding<Int>,
        min: Int? = nil,
        max: Int? = nil,
        step: Int = 1,
        disabled: Bool = false
    ) {
        self._value = value
        self.min = min
        self.max = max
        self.step = step
        self.disabled = disabled
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            Button(action: decrement) {
                Image(systemName: "minus")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(decrementDisabled ? Color(hex: "#BDBDBD") : Color(hex: "#333333"))
                    .frame(width: 48, height: 48)
                    .background(Color.white.opacity(0.001)) // To make entire area clickable
            }
            .disabled(decrementDisabled)
            
            Divider()
                .frame(width: 1, height: 48)
                .background(Color(hex: "#E0E0E0"))
            
            TextField("", value: $value, formatter: NumberFormatter(), onEditingChanged: { editing in
                isFocused = editing
            })
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(disabled ? Color(hex: "#888888") : Color(hex: "#333333"))
                .disabled(disabled)
                .frame(width: 60, height: 48)
                .onChange(of: value) { newValue in
                    validate(newValue)
                }
            
            Divider()
                .frame(width: 1, height: 48)
                .background(Color(hex: "#E0E0E0"))
            
            Button(action: increment) {
                Image(systemName: "plus")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(incrementDisabled ? Color(hex: "#BDBDBD") : Color(hex: "#333333"))
                    .frame(width: 48, height: 48)
                    .background(Color.white.opacity(0.001))
            }
            .disabled(incrementDisabled)
        }
        .background(disabled ? Color(hex: "#F5F5F5") : Color.white)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(isFocused ? Color(hex: "#1A2A5E") : Color(hex: "#E0E0E0"), lineWidth: 1)
        )
        .animation(.easeInOut(duration: 0.2), value: isFocused)
        .frame(height: 48)
    }
    
    private var decrementDisabled: Bool {
        if disabled { return true }
        if let min = min, value <= min { return true }
        return false
    }
    
    private var incrementDisabled: Bool {
        if disabled { return true }
        if let max = max, value >= max { return true }
        return false
    }
    
    private func increment() {
        validate(value + step)
    }
    
    private func decrement() {
        validate(value - step)
    }
    
    private func validate(_ newValue: Int) {
        var validValue = newValue
        if let min = min, validValue < min { validValue = min }
        if let max = max, validValue > max { validValue = max }
        if value != validValue {
            value = validValue
        }
    }
}
