import SwiftUI

public struct BizVerificationCard<IconContent: View>: View {
    var title: String
    var description: String
    var iconContent: () -> IconContent
    
    public init(
        title: String,
        description: String,
        @ViewBuilder iconContent: @escaping () -> IconContent
    ) {
        self.title = title
        self.description = description
        self.iconContent = iconContent
    }
    
    public var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ZStack {
                Circle()
                    .fill(Color(hex: "#F0F5FF"))
                    .frame(width: 24, height: 24)
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 4)
                    )
                
                iconContent()
                    .frame(width: 12, height: 12)
                    .foregroundColor(Color(hex: "#3B63CC"))
            }
            // In Vue, left was absolute -41px, implying it's positioned on a timeline.
            // For a standalone SwiftUI component, we will just lay it out normally.
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color(hex: "#1A2A5E"))
                
                Text(description)
                    .font(.system(size: 13))
                    .foregroundColor(Color(hex: "#555555"))
                    .lineSpacing(2)
            }
        }
    }
}
