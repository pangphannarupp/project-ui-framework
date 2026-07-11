import SwiftUI

public struct BizCheckbox: View {
    @Binding public var isChecked: Bool
    public var label: String?
    public var checkedColor: Color

    public init(isChecked: Binding<Bool>, label: String? = nil, checkedColor: Color = Color(hex: "#1A2A5E")) {
        self._isChecked = isChecked
        self.label = label
        self.checkedColor = checkedColor
    }

    public var body: some View {
        Button(action: {
            isChecked.toggle()
        }) {
            HStack(alignment: .center, spacing: 8) {
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(isChecked ? checkedColor : Color(hex: "#CCCCCC"), lineWidth: 1.5)
                        .frame(width: 20, height: 20)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .fill(isChecked ? checkedColor : Color.white)
                        )
                    
                    if isChecked {
                        Image(systemName: "checkmark")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                
                if let label = label {
                    Text(label)
                        .font(.system(size: 14))
                        .foregroundColor(Color(hex: "#333333"))
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

extension Color {
    public init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
