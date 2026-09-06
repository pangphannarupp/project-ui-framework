import SwiftUI

/**
 * BizMarquee - SwiftUI component matching Web UI-Framework `PPMarquee.vue`.
 */
public struct BizMarquee: View {
    public var direction: String
    public var duration: String
    public var pauseOnHover: Bool
    public var fade: Bool
    public var vertical: Bool
    public var action: () -> Void

    public init(
        direction: String = "",
        duration: String = "",
        pauseOnHover: Bool = false,
        fade: Bool = false,
        vertical: Bool = false,
        action: @escaping () -> Void = {}
    ) {
        self.direction = direction
        self.duration = duration
        self.pauseOnHover = pauseOnHover
        self.fade = fade
        self.vertical = vertical
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Marquee")
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
 * Web UI-Framework parity alias for [BizMarquee].
 */
public typealias PPMarquee = BizMarquee
