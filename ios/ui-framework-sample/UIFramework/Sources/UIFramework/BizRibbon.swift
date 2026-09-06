import SwiftUI

/**
 * BizRibbon - SwiftUI component matching Web UI-Framework `PPRibbon.vue`.
 */
public struct BizRibbon: View {
    public var modelValue: String
    public var variant: String
    public var collapsible: Bool
    public var action: () -> Void

    public init(
        modelValue: String = "",
        variant: String = "classic",
        collapsible: Bool = true,
        action: @escaping () -> Void = {}
    ) {
        self.modelValue = modelValue
        self.variant = variant
        self.collapsible = collapsible
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Ribbon")
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
 * Web UI-Framework parity alias for [BizRibbon].
 */
public typealias PPRibbon = BizRibbon
