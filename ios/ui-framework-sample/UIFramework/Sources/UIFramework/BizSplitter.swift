import SwiftUI

/**
 * BizSplitter - SwiftUI component matching Web UI-Framework `PPSplitter.vue`.
 */
public struct BizSplitter: View {
    public var direction: String
    public var initialSplit: Int
    public var min: Int
    public var action: () -> Void

    public init(
        direction: String = "horizontal",
        initialSplit: Int = 50,
        min: Int = 10,
        action: @escaping () -> Void = {}
    ) {
        self.direction = direction
        self.initialSplit = initialSplit
        self.min = min
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Splitter")
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
 * Web UI-Framework parity alias for [BizSplitter].
 */
public typealias PPSplitter = BizSplitter
