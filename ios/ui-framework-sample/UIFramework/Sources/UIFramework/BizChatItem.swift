import SwiftUI

/**
 * BizChatItem - SwiftUI component matching Web UI-Framework `PPChatItem.vue`.
 */
public struct BizChatItem: View {
    public var name: String
    public var avatar: String
    public var time: String
    public var message: String
    public var unread: Int
    public var action: () -> Void

    public init(
        name: String = "",
        avatar: String = "",
        time: String = "",
        message: String = "",
        unread: Int = 0,
        action: @escaping () -> Void = {}
    ) {
        self.name = name
        self.avatar = avatar
        self.time = time
        self.message = message
        self.unread = unread
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("ChatItem")
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
 * Web UI-Framework parity alias for [BizChatItem].
 */
public typealias PPChatItem = BizChatItem
