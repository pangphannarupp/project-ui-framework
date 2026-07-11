import SwiftUI

public struct BizUserProfile: View {
    var userName: String
    var role: String
    var avatarUrl: String?
    var isVerified: Bool
    
    public init(
        userName: String,
        role: String = "User",
        avatarUrl: String? = nil,
        isVerified: Bool = false
    ) {
        self.userName = userName
        self.role = role
        self.avatarUrl = avatarUrl
        self.isVerified = isVerified
    }
    
    public var body: some View {
        HStack(alignment: .center, spacing: 12) {
            ZStack {
                Circle()
                    .fill(Color(hex: "#E0E0E0"))
                    .frame(width: 44, height: 44)
                    .overlay(
                        Circle().stroke(Color.white.opacity(0.2), lineWidth: 2)
                    )
                
                if let avatarUrl = avatarUrl, !avatarUrl.isEmpty, let url = URL(string: avatarUrl) {
                    if #available(iOS 15.0, *) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 44, height: 44)
                                .clipShape(Circle())
                        } placeholder: {
                            Text(initials)
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(Color(hex: "#666666"))
                        }
                    } else {
                        // Fallback for iOS 14
                        Text(initials)
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(Color(hex: "#666666"))
                    }
                } else {
                    Text(initials)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color(hex: "#666666"))
                }
            }
            
            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 4) {
                    if isVerified {
                        Image(systemName: "checkmark.shield.fill")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                    }
                    
                    Text(role)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(Color.white.opacity(0.8))
                }
                
                Text(userName.uppercased())
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.white)
                    .tracking(0.5)
            }
        }
    }
    
    private var initials: String {
        let parts = userName.split(separator: " ")
        let initialString = parts.compactMap { $0.first }.map { String($0) }.joined()
        return String(initialString.prefix(2)).uppercased()
    }
}
