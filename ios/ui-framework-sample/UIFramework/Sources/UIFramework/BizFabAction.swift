import SwiftUI

public struct BizFabAction<Content: View>: View {
    var color: ActionColor
    var onClick: (() -> Void)?
    var content: () -> Content
    
    public enum ActionColor {
        case light
        case primary
        case secondary
        case danger
        
        var backgroundColor: Color {
            switch self {
            case .light: return Color.white
            case .primary: return Color(hex: "#1A2A5E")
            case .secondary: return Color(hex: "#E0E0E0")
            case .danger: return Color(hex: "#D32F2F")
            }
        }
        
        var foregroundColor: Color {
            switch self {
            case .light, .secondary: return Color(hex: "#333333")
            case .primary, .danger: return Color.white
            }
        }
    }
    
    public init(
        color: ActionColor = .light,
        onClick: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.color = color
        self.onClick = onClick
        self.content = content
    }
    
    public var body: some View {
        Button(action: {
            onClick?()
        }) {
            content()
                .font(.system(size: 16))
                .foregroundColor(color.foregroundColor)
                .frame(width: 40, height: 40)
                .background(color.backgroundColor)
                .clipShape(Circle())
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        }
        .buttonStyle(BizFabActionButtonStyle())
    }
}

private struct BizFabActionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
