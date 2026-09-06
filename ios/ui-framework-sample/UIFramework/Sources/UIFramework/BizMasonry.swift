import SwiftUI

/**
 * BizMasonry - SwiftUI component matching Web UI-Framework `PPMasonry.vue`.
 */
public struct BizMasonry: View {
    public var columns: Int
    public var gap: Int
    public var action: () -> Void

    public init(
        columns: Int = 3,
        gap: Int = 16,
        action: @escaping () -> Void = {}
    ) {
        self.columns = columns
        self.gap = gap
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Masonry")
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
 * Web UI-Framework parity alias for [BizMasonry].
 */
public typealias PPMasonry = BizMasonry
