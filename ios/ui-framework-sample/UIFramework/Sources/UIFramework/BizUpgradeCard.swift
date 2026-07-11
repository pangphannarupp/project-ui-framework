import SwiftUI

public struct BizUpgradeCard<IconContent: View>: View {
    var title: String
    var description: String?
    var iconContent: () -> IconContent
    
    public init(
        title: String,
        description: String? = nil,
        @ViewBuilder iconContent: @escaping () -> IconContent
    ) {
        self.title = title
        self.description = description
        self.iconContent = iconContent
    }
    
    public var body: some View {
        HStack(alignment: .top, spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color(hex: "#3B63CC"))
                    .frame(width: 40, height: 40)
                
                iconContent()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(Color(hex: "#1A2A5E"))
                    .padding(.top, 2)
                
                if let description = description, !description.isEmpty {
                    Text(description)
                        .font(.system(size: 13))
                        .foregroundColor(Color(hex: "#555555"))
                        .lineSpacing(2)
                }
            }
        }
        .padding(.bottom, 8)
    }
}
