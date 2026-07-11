import SwiftUI

public struct BizActionCard: View {
    var title: String
    var subtitle: String?
    var badgeCount: String?
    var badgeColor: BizBadgeColor
    var iconName: String?
    var onClick: (() -> Void)?
    
    public enum BizBadgeColor {
        case pink
        case orange
        case teal
        case blue
        
        var backgroundColor: Color {
            switch self {
            case .pink: return Color(hex: "#FFE6EB")
            case .orange: return Color(hex: "#FFF3E0")
            case .teal: return Color(hex: "#E0F2F1")
            case .blue: return Color(hex: "#E6F0FF")
            }
        }
        
        var foregroundColor: Color {
            switch self {
            case .pink: return Color(hex: "#FF4D6D")
            case .orange: return Color(hex: "#FF9800")
            case .teal: return Color(hex: "#009688")
            case .blue: return Color(hex: "#0066CC")
            }
        }
    }
    
    public init(
        title: String,
        subtitle: String? = nil,
        badgeCount: String? = nil,
        badgeColor: BizBadgeColor = .pink,
        iconName: String? = nil,
        onClick: (() -> Void)? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.badgeCount = badgeCount
        self.badgeColor = badgeColor
        self.iconName = iconName
        self.onClick = onClick
    }
    
    public var body: some View {
        Button(action: {
            onClick?()
        }) {
            VStack(alignment: .leading, spacing: 0) {
                if let badgeCount = badgeCount {
                    Text(badgeCount)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(badgeColor.foregroundColor)
                        .frame(width: 32, height: 32)
                        .background(badgeColor.backgroundColor)
                        .clipShape(Circle())
                        .padding(.bottom, 12)
                } else {
                    ZStack {
                        if let iconName = iconName {
                            Image(systemName: iconName)
                                .font(.system(size: 24))
                                .foregroundColor(badgeColor.foregroundColor)
                        } else {
                            Image(systemName: "star.fill")
                                .font(.system(size: 24))
                                .foregroundColor(badgeColor.foregroundColor)
                        }
                    }
                    .frame(width: 40, height: 40)
                    .background(Color.clear)
                    .padding(.bottom, 12)
                }
                
                Text(title)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(Color(hex: "#1A2A5E"))
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, subtitle != nil ? 2 : 0)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.system(size: 12))
                        .foregroundColor(Color(hex: "#666666"))
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }
                
                Spacer(minLength: 0)
            }
            .padding(EdgeInsets(top: 16, leading: 12, bottom: 16, trailing: 12))
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.03), radius: 6, x: 0, y: 4)
        }
        .buttonStyle(BizCardButtonStyle())
    }
}

private struct BizCardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
