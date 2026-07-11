import SwiftUI

public struct BizKeypad: View {
    public var onPress: (String) -> Void
    
    let lettersMap: [String: String] = [
        "1": "", "2": "ABC", "3": "DEF",
        "4": "GHI", "5": "JKL", "6": "MNO",
        "7": "PQRS", "8": "TUV", "9": "WXYZ"
    ]
    
    public init(onPress: @escaping (String) -> Void) {
        self.onPress = onPress
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 3), spacing: 12) {
                ForEach(1...9, id: \.self) { num in
                    let numStr = "\(num)"
                    KeypadButton(
                        primaryText: numStr,
                        secondaryText: lettersMap[numStr] ?? "",
                        action: { onPress(numStr) }
                    )
                }
                
                // Empty Space
                Color.clear.frame(height: 54)
                
                // Zero
                KeypadButton(
                    primaryText: "0",
                    secondaryText: "+",
                    action: { onPress("0") }
                )
                
                // Backspace
                Button(action: { onPress("backspace") }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 1)
                        
                        Image(systemName: "delete.left")
                            .font(.system(size: 24))
                            .foregroundColor(Color(hex: "#333333"))
                    }
                }
                .frame(height: 54)
                .buttonStyle(KeypadButtonStyle())
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 32)
        }
        .background(Color(hex: "#E5E7EB"))
        .cornerRadius(24, corners: [.topLeft, .topRight])
    }
}

private struct KeypadButton: View {
    let primaryText: String
    let secondaryText: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 1)
                
                VStack(spacing: 2) {
                    Text(primaryText)
                        .font(.system(size: 26))
                        .foregroundColor(Color(hex: "#111111"))
                    
                    Text(secondaryText)
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(Color(hex: "#718096"))
                        .tracking(1)
                        .frame(minHeight: 10)
                }
            }
        }
        .frame(height: 54)
        .buttonStyle(KeypadButtonStyle())
    }
}

private struct KeypadButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.black.opacity(configuration.isPressed ? 0.05 : 0))
            )
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
    }
}


