import SwiftUI

public struct BizNotificationItem<IconContent: View>: View {
    var title: String
    var description: String
    var timestamp: String
    var unread: Bool
    var onClick: (() -> Void)?
    var onDetailClick: (() -> Void)?
    var iconContent: () -> IconContent
    
    public init(
        title: String,
        description: String,
        timestamp: String,
        unread: Bool = false,
        onClick: (() -> Void)? = nil,
        onDetailClick: (() -> Void)? = nil,
        @ViewBuilder iconContent: @escaping () -> IconContent
    ) {
        self.title = title
        self.description = description
        self.timestamp = timestamp
        self.unread = unread
        self.onClick = onClick
        self.onDetailClick = onDetailClick
        self.iconContent = iconContent
    }
    
    public var body: some View {
        Button(action: {
            onClick?()
        }) {
            HStack(alignment: .top, spacing: 16) {
                // Icon Wrapper
                ZStack(alignment: .topLeading) {
                    ZStack {
                        Circle()
                            .fill(Color(hex: "#F4F6FC"))
                            .frame(width: 40, height: 40)
                        
                        iconContent()
                            .foregroundColor(Color(hex: "#1A2A5E"))
                            .frame(width: 20, height: 20)
                    }
                    
                    if unread {
                        Circle()
                            .fill(Color(hex: "#E03B41"))
                            .frame(width: 8, height: 8)
                            .offset(x: 0, y: 0)
                    }
                }
                
                // Content
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(Color(hex: "#1A2A5E"))
                    
                    Text(description)
                        .font(.system(size: 14))
                        .foregroundColor(Color(hex: "#555555"))
                        .lineSpacing(2)
                        .padding(.bottom, 8)
                    
                    HStack(alignment: .center) {
                        Text(timestamp)
                            .font(.system(size: 12))
                            .foregroundColor(Color(hex: "#888888"))
                        
                        Spacer()
                        
                        Button(action: {
                            onDetailClick?()
                        }) {
                            HStack(spacing: 2) {
                                Text("Detail")
                                    .font(.system(size: 13))
                                    .foregroundColor(Color(hex: "#666666"))
                                
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(Color(hex: "#666666"))
                            }
                        }
                    }
                }
            }
            .padding(16)
            .background(Color.white)
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color(hex: "#F0F0F0")),
                alignment: .bottom
            )
        }
        .buttonStyle(BizNotificationButtonStyle())
    }
}

private struct BizNotificationButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? Color(hex: "#F9F9F9") : Color.white)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
