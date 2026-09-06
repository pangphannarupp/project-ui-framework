import SwiftUI

/**
 * BizFilePreview - SwiftUI component matching Web UI-Framework `PPFilePreview.vue`.
 */
public struct BizFilePreview: View {
    public var modelValue: Bool
    public var file: String
    public var sidebarPosition: String
    public var action: () -> Void

    public init(
        modelValue: Bool = false,
        file: String = "",
        sidebarPosition: String = "",
        action: @escaping () -> Void = {}
    ) {
        self.modelValue = modelValue
        self.file = file
        self.sidebarPosition = sidebarPosition
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("FilePreview")
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
 * Web UI-Framework parity alias for [BizFilePreview].
 */
public typealias PPFilePreview = BizFilePreview
