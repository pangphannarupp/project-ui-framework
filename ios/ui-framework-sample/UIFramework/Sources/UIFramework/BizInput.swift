import SwiftUI

public struct BizInput: View {
    @Binding public var text: String
    public var placeholder: String

    public init(text: Binding<String>, placeholder: String = "") {
        self._text = text
        self.placeholder = placeholder
    }

    public var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .background(Color(hex: "#F5F5F5"))
            .cornerRadius(8)
    }
}
