import SwiftUI

/**
 * BizRichTextEditor - SwiftUI component matching Web UI-Framework `PPRichTextEditor.vue`.
 */
public struct BizRichTextEditor: View {
    public var modelValue: String
    public var placeholder: String
    public var minHeight: String
    public var customButtons: [String]
    public var showModeToggle: Bool
    public var availableModes: [String]
    public var action: () -> Void

    public init(
        modelValue: String = "",
        placeholder: String = "",
        minHeight: String = "",
        customButtons: [String] = [],
        showModeToggle: Bool = false,
        availableModes: [String] = [],
        action: @escaping () -> Void = {}
    ) {
        self.modelValue = modelValue
        self.placeholder = placeholder
        self.minHeight = minHeight
        self.customButtons = customButtons
        self.showModeToggle = showModeToggle
        self.availableModes = availableModes
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("RichTextEditor")
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
 * Web UI-Framework parity alias for [BizRichTextEditor].
 */
public typealias PPRichTextEditor = BizRichTextEditor
