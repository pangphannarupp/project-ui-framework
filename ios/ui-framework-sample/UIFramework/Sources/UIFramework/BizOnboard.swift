import SwiftUI

/**
 * BizOnboard - SwiftUI component matching Web UI-Framework `PPOnboard.vue`.
 */
public struct BizOnboard: View {
    public var steps: [String]
    public var skippable: Bool
    public var doneText: String
    public var action: () -> Void

    public init(
        steps: [String] = [],
        skippable: Bool = false,
        doneText: String = "",
        action: @escaping () -> Void = {}
    ) {
        self.steps = steps
        self.skippable = skippable
        self.doneText = doneText
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Onboard")
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
 * Web UI-Framework parity alias for [BizOnboard].
 */
public typealias PPOnboard = BizOnboard
