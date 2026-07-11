import SwiftUI

public struct BizSwitch: View {
    @Binding public var isOn: Bool
    public var label: String?
    public var onTint: Color

    public init(isOn: Binding<Bool>, label: String? = nil, onTint: Color = Color(hex: "#003399")) {
        self._isOn = isOn
        self.label = label
        self.onTint = onTint
    }

    public var body: some View {
        HStack {
            if let label = label {
                Text(label)
                    .font(.system(size: 16))
                    .foregroundColor(Color(hex: "#1A2A5E"))
                Spacer()
            }
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .toggleStyle(SwitchToggleStyle(tint: onTint))
        }
    }
}
