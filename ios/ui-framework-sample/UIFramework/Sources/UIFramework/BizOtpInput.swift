import SwiftUI

public struct BizOtpInput: View {
    @Binding public var value: String
    public var length: Int
    public var onComplete: ((String) -> Void)?
    
    @State private var isFocused: Bool = false
    
    public init(value: Binding<String>, length: Int = 6, onComplete: ((String) -> Void)? = nil) {
        self._value = value
        self.length = length
        self.onComplete = onComplete
    }
    
    public var body: some View {
        ZStack {
            // Hidden text field for input
            TextField("", text: $value, onEditingChanged: { editing in
                isFocused = editing
            })
            .keyboardType(.numberPad)
            .textContentType(.oneTimeCode)
            .opacity(0) // Hide it completely
            .onChange(of: value) { newValue in
                if newValue.count > length {
                    value = String(newValue.prefix(length))
                }
                if value.count == length {
                    onComplete?(value)
                }
            }
            
            // Visual boxes
            HStack(spacing: 8) {
                ForEach(0..<length, id: \.self) { index in
                    OtpBox(
                        char: charAt(index),
                        isFocused: isFocused && value.count == index || (isFocused && value.count == length && index == length - 1)
                    )
                }
            }
            .allowsHitTesting(false) // Let taps pass through to the hidden TextField
        }
    }
    
    private func charAt(_ index: Int) -> String {
        if index < value.count {
            let charIndex = value.index(value.startIndex, offsetBy: index)
            return String(value[charIndex])
        }
        return ""
    }
}

private struct OtpBox: View {
    var char: String
    var isFocused: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .stroke(isFocused ? Color(hex: "#003399") : Color(hex: "#E0E0E0"), lineWidth: isFocused ? 2 : 1)
                .background(char.isEmpty ? Color.white : Color(hex: "#2954D6"))
                .cornerRadius(12)
                .shadow(color: isFocused ? Color(hex: "#003399").opacity(0.1) : Color.clear, radius: 0, x: 0, y: 0)
                .aspectRatio(1, contentMode: .fit)
                .frame(maxWidth: 50)
            
            Text(char)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(char.isEmpty ? Color(hex: "#1A2A5E") : .white)
        }
        .animation(.easeInOut(duration: 0.2), value: char.isEmpty)
        .animation(.easeInOut(duration: 0.2), value: isFocused)
    }
}
