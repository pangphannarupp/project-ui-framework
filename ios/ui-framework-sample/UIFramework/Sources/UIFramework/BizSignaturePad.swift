import SwiftUI

/**
 * BizSignaturePad - SwiftUI component matching Web UI-Framework `PPSignaturePad.vue`.
 */
public struct BizSignaturePad: View {
    public var strokeColor: String
    public var lineWidth: Int
    public var placeholder: String
    public var readonly: Bool
    public var backgroundColor: String
    public var action: () -> Void

    public init(
        strokeColor: String = "",
        lineWidth: Int = 0,
        placeholder: String = "",
        readonly: Bool = false,
        backgroundColor: String = "",
        action: @escaping () -> Void = {}
    ) {
        self.strokeColor = strokeColor
        self.lineWidth = lineWidth
        self.placeholder = placeholder
        self.readonly = readonly
        self.backgroundColor = backgroundColor
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("SignaturePad")
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
 * Web UI-Framework parity alias for [BizSignaturePad].
 */
public typealias PPSignaturePad = BizSignaturePad
