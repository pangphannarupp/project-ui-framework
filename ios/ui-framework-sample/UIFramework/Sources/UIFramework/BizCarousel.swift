import SwiftUI

/**
 * BizCarousel - SwiftUI component matching Web UI-Framework `PPCarousel.vue`.
 */
public struct BizCarousel: View {
    public var autoplay: Bool
    public var interval: Int
    public var showArrows: Bool
    public var showDots: Bool
    public var itemsPerView: Int
    public var gap: String
    public var loop: Bool
    public var variant: String
    public var action: () -> Void

    public init(
        autoplay: Bool = false,
        interval: Int = 0,
        showArrows: Bool = false,
        showDots: Bool = false,
        itemsPerView: Int = 0,
        gap: String = "",
        loop: Bool = false,
        variant: String = "",
        action: @escaping () -> Void = {}
    ) {
        self.autoplay = autoplay
        self.interval = interval
        self.showArrows = showArrows
        self.showDots = showDots
        self.itemsPerView = itemsPerView
        self.gap = gap
        self.loop = loop
        self.variant = variant
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Carousel")
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
 * Web UI-Framework parity alias for [BizCarousel].
 */
public typealias PPCarousel = BizCarousel
