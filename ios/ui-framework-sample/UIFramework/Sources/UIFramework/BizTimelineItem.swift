import SwiftUI

/**
 * BizTimelineItem - SwiftUI component matching Web UI-Framework `PPTimelineItem.vue`.
 */
public struct BizTimelineItem: View {
    public var timestamp: String
    public var timestampPlacement: String
    public var type: String
    public var size: String
    public var variant: String
    public var dashed: Bool
    public var active: Bool
    public var action: () -> Void

    public init(
        timestamp: String = "",
        timestampPlacement: String = "",
        type: String = "",
        size: String = "",
        variant: String = "",
        dashed: Bool = false,
        active: Bool = false,
        action: @escaping () -> Void = {}
    ) {
        self.timestamp = timestamp
        self.timestampPlacement = timestampPlacement
        self.type = type
        self.size = size
        self.variant = variant
        self.dashed = dashed
        self.active = active
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("TimelineItem")
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
 * Web UI-Framework parity alias for [BizTimelineItem].
 */
public typealias PPTimelineItem = BizTimelineItem
