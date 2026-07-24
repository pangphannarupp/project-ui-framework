import SwiftUI

public enum BizUserStatus: String {
    case active = "Active"
    case inactive = "Inactive"
    case pending = "Pending"
    case locked = "Locked"
}

public struct BizUserCard: View {
    public let name: String
    public let phone: String
    public let status: BizUserStatus
    public let isMaster: Bool


    public let onMoreTap: (() -> Void)?
    
    public init(
        name: String,
        phone: String,
        status: BizUserStatus = .active,
        isMaster: Bool = false,
        onMoreTap: (() -> Void)? = nil
    ) {
        self.name = name
        self.phone = phone
        self.status = status
        self.isMaster = isMaster


        self.onMoreTap = onMoreTap
    }
    
    private var initials: String {
        let parts = name.split(separator: " ")
        if parts.count >= 2 {
            return String(parts[0].first!).uppercased() + String(parts[1].first!).uppercased()
        }
        return String(name.prefix(2)).uppercased()
    }
    
    public var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Avatar
            Text(initials)
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(Color(red: 26/255, green: 42/255, blue: 94/255))
                .frame(width: 44, height: 44)
                .background(Color(red: 230/255, green: 240/255, blue: 255/255))
                .clipShape(Circle())
            
            // Info
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 6) {
                    Text(name)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(Color(red: 17/255, green: 17/255, blue: 17/255))
                        .lineLimit(1)
                    
                    if isMaster {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(Color(red: 59/255, green: 99/255, blue: 204/255))
                            .font(.system(size: 14))
                    }
                }
                
                HStack(spacing: 6) {
                    Image(systemName: "phone")
                        .foregroundColor(Color(red: 102/255, green: 102/255, blue: 102/255))
                        .font(.system(size: 12))
                    Text(phone)
                        .font(.system(size: 13))
                        .foregroundColor(Color(red: 102/255, green: 102/255, blue: 102/255))
                }
                .padding(.bottom, 4)
                
                HStack(spacing: 8) {


                }
            }
            
            Spacer(minLength: 0)
            
            // Actions
            VStack(alignment: .trailing, spacing: 24) {
                statusChip
                
                Button(action: {
                    onMoreTap?()
                }) {
                    Image(systemName: "ellipsis")
                        .foregroundColor(Color(red: 136/255, green: 136/255, blue: 136/255))
                        .font(.system(size: 20))
                        .rotationEffect(.degrees(90))
                }
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(red: 238/255, green: 241/255, blue: 246/255), lineWidth: 1)
        )
    }
    
    @ViewBuilder
    private func badgeView(text: String, icon: String, bgColor: Color) -> some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 10))
            Text(text)
        }
        .font(.system(size: 11, weight: .semibold))
        .foregroundColor(.white)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(bgColor)
        .cornerRadius(6)
    }
    
    @ViewBuilder
    private var statusChip: some View {
        Text(status.rawValue)
            .font(.system(size: 12, weight: .semibold))
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(statusBgColor)
            .foregroundColor(statusTextColor)
            .cornerRadius(12)
    }
    
    private var statusBgColor: Color {
        switch status {
        case .active: return Color(red: 240/255, green: 245/255, blue: 255/255)
        case .inactive: return Color(red: 245/255, green: 245/255, blue: 245/255)
        case .pending: return Color(red: 255/255, green: 248/255, blue: 229/255)
        case .locked: return Color(red: 255/255, green: 235/255, blue: 235/255)
        }
    }
    
    private var statusTextColor: Color {
        switch status {
        case .active: return Color(red: 59/255, green: 99/255, blue: 204/255)
        case .inactive: return Color(red: 136/255, green: 136/255, blue: 136/255)
        case .pending: return Color(red: 229/255, green: 159/255, blue: 0)
        case .locked: return Color(red: 255/255, green: 59/255, blue: 48/255)
        }
    }
}
