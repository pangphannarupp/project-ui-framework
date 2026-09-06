import SwiftUI

/**
 * BizReactionPicker - SwiftUI component matching Web UI-Framework `PPReactionPicker.vue`.
 */
public struct BizReactionPicker: View {
    public var modelValue: String
    public var reactions: [String]
    public var action: () -> Void

    public init(
        modelValue: String = "null",
        reactions: [String] = [],
        action: @escaping () -> Void = {}
    ) {
        self.modelValue = modelValue
        self.reactions = reactions
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("ReactionPicker")
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
 * Web UI-Framework parity alias for [BizReactionPicker].
 */
public typealias PPReactionPicker = BizReactionPicker
