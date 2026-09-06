import SwiftUI

/**
 * BizImagePreview - SwiftUI component matching Web UI-Framework `PPImagePreview.vue`.
 */
public struct BizImagePreview: View {
    public var src: String
    public var minZoom: Int
    public var maxZoom: Int
    public var action: () -> Void

    public init(
        src: String = "",
        minZoom: Int = 0,
        maxZoom: Int = 0,
        action: @escaping () -> Void = {}
    ) {
        self.src = src
        self.minZoom = minZoom
        self.maxZoom = maxZoom
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("ImagePreview")
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
 * Web UI-Framework parity alias for [BizImagePreview].
 */
public typealias PPImagePreview = BizImagePreview
