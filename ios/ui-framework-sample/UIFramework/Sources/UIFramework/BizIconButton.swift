import SwiftUI

public struct BizIconButton: View {
    public var iconName: String
    public var tint: Color
    public var action: () -> Void

    public init(iconName: String, tint: Color = Color(hex: "#1A2A5E"), action: @escaping () -> Void) {
        self.iconName = iconName
        self.tint = tint
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Image(systemName: iconName)
                .font(.system(size: 24))
                .foregroundColor(tint)
        }
    }
}
