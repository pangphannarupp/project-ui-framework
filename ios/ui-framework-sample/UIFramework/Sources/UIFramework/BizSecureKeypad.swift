import SwiftUI

public struct BizSecureKeypad: View {
    public var showHeader: Bool
    public var onPress: (String) -> Void
    
    @State private var shuffledKeys: [String] = []
    
    let lettersMap: [String: String] = [
        "1": "", "2": "ABC", "3": "DEF",
        "4": "GHI", "5": "JKL", "6": "MNO",
        "7": "PQRS", "8": "TUV", "9": "WXYZ",
        "0": "+"
    ]
    
    public init(showHeader: Bool = true, onPress: @escaping (String) -> Void) {
        self.showHeader = showHeader
        self.onPress = onPress
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            if showHeader {
                HStack(spacing: 8) {
                    Image(systemName: "checkmark.shield.fill")
                        .foregroundColor(Color(hex: "#3880FF"))
                    Text("Secure Keypad Active")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color(hex: "#003399"))
                }
                .padding(.bottom, 16)
            }
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 3), spacing: 12) {
                ForEach(Array(shuffledKeys.enumerated()), id: \.offset) { index, item in
                    if item != "shield" {
                        SecureKeypadButton(
                            primaryText: item,
                            secondaryText: lettersMap[item] ?? " ",
                            action: { onPress(item) }
                        )
                    } else {
                        // Shield Indicator
                        ZStack {
                            Color.clear
                            Image(systemName: "shield.lefthalf.filled")
                                .font(.system(size: 20))
                                .foregroundColor(Color(hex: "#A0AEC0"))
                        }
                        .frame(height: 56)
                    }
                }
                
                // Backspace
                Button(action: { onPress("backspace") }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(hex: "#E2E8F0"), lineWidth: 1))
                            .shadow(color: Color.black.opacity(0.02), radius: 2, x: 0, y: 2)
                        
                        Image(systemName: "delete.left")
                            .font(.system(size: 26))
                            .foregroundColor(Color(hex: "#1A2A5E"))
                    }
                }
                .frame(height: 56)
                .buttonStyle(SecureKeypadButtonStyle())
            }
            .padding(.horizontal, 20)
            .padding(.top, showHeader ? 0 : 12)
            .padding(.bottom, 32)
        }
        .background(Color(hex: "#F4F6FA"))
        .cornerRadius(24, corners: [.topLeft, .topRight])
        .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: -4)
        .onAppear {
            randomizeKeys()
        }
    }
    
    public func randomizeKeys() {
        var nums = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
        nums.shuffle()
        let shieldIndex = Int.random(in: 0...10)
        nums.insert("shield", at: shieldIndex)
        shuffledKeys = nums
    }
}

private struct SecureKeypadButton: View {
    let primaryText: String
    let secondaryText: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(hex: "#E2E8F0"), lineWidth: 1))
                    .shadow(color: Color.black.opacity(0.02), radius: 2, x: 0, y: 2)
                
                VStack(spacing: 2) {
                    Text(primaryText)
                        .font(.system(size: 26, weight: .semibold))
                    
                    Text(secondaryText)
                        .font(.system(size: 10, weight: .semibold))
                        .tracking(1)
                        .frame(minHeight: 10)
                }
            }
        }
        .frame(height: 56)
        .buttonStyle(SecureKeypadButtonStyle())
    }
}

private struct SecureKeypadButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            configuration.label
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(configuration.isPressed ? Color(hex: "#003399") : Color.clear)
                )
                .foregroundColor(configuration.isPressed ? .white : Color(hex: "#1A2A5E"))
            
            // Pop-up effect on press
            if configuration.isPressed {
                // Not fully implementing the popup for simplicity, just change colors
            }
        }
    }
}
