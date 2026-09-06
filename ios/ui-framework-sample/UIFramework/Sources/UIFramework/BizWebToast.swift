import SwiftUI

/**
 * BizWebToast - SwiftUI component matching Web UI-Framework `PPWebToast.vue`.
 */
public struct BizWebToast: View {
    public var modelValue: Bool
    public var message: String
    public var title: String
    public var type: String
    public var position: String
    public var duration: Int
    public var closable: Bool
    public var action: () -> Void

    public init(
        modelValue: Bool = false,
        message: String = "",
        title: String = "",
        type: String = "",
        position: String = "",
        duration: Int = 0,
        closable: Bool = false,
        action: @escaping () -> Void = {}
    ) {
        self.modelValue = modelValue
        self.message = message
        self.title = title
        self.type = type
        self.position = position
        self.duration = duration
        self.closable = closable
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("WebToast")
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
 * Web UI-Framework parity alias for [BizWebToast].
 */
public typealias PPWebToast = BizWebToast
