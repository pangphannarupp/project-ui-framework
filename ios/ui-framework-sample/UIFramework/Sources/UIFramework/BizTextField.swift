import SwiftUI

public struct BizTextField: View {
    @Binding public var text: String
    public var placeholder: String
    public var isSecure: Bool

    public init(text: Binding<String>, placeholder: String = "", isSecure: Bool = false) {
        self._text = text
        self.placeholder = placeholder
        self.isSecure = isSecure
    }

    public var body: some View {
        Group {
            if isSecure {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
        }
        .padding()
        .background(Color.clear)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(hex: "#003399"), lineWidth: 1)
        )
    }
}
