import SwiftUI

public enum BizInfoCardType {
    case warning
    case info
}

public struct BizInfoCard: View {
    public var text: String
    public var type: BizInfoCardType

    public init(text: String, type: BizInfoCardType = .warning) {
        self.text = text
        self.type = type
    }

    public var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: type == .warning ? "exclamationmark.triangle" : "info.circle")
                .foregroundColor(Color(hex: "#1A2A5E"))
                .font(.system(size: 20))
            
            Text(text)
                .font(.system(size: 13))
                .foregroundColor(Color(hex: "#333333"))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(16)
        .background(Color(hex: "#F8F9FA"))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(hex: "#F1F3F5"), lineWidth: 1)
        )
    }
}
