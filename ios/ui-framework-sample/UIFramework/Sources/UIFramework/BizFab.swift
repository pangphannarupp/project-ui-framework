import SwiftUI

public struct BizFab: View {
    public var iconName: String
    public var backgroundColor: Color
    public var foregroundColor: Color
    public var action: () -> Void

    public init(
        iconName: String,
        backgroundColor: Color = Color(hex: "#003399"),
        foregroundColor: Color = .white,
        action: @escaping () -> Void
    ) {
        self.iconName = iconName
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Image(systemName: iconName)
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(foregroundColor)
                .frame(width: 56, height: 56)
                .background(backgroundColor)
                .clipShape(Circle())
                .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 4)
        }
    }
}
