import SwiftUI

/**
 * BizAvatar - SwiftUI component matching Web UI-Framework `PPAvatar.vue`.
 */
public struct BizAvatar: View {
    public var src: String
    public var name: String
    public var alt: String
    public var icon: String
    public var size: String
    public var shape: String
    public var bgColor: String
    public var textColor: String
    public var action: () -> Void

    public init(
        src: String = "",
        name: String = "",
        alt: String = "",
        icon: String = "",
        size: String = "md",
        shape: String = "circle",
        bgColor: String = "",
        textColor: String = "",
        action: @escaping () -> Void = {}
    ) {
        self.src = src
        self.name = name
        self.alt = alt
        self.icon = icon
        self.size = size
        self.shape = shape
        self.bgColor = bgColor
        self.textColor = textColor
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Avatar")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color(hex: "#1A2A5E"))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .background(Color.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(hex: "#CBD5E1"), lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

/**
 * Web UI-Framework parity alias for [BizAvatar].
 */
public typealias PPAvatar = BizAvatar
