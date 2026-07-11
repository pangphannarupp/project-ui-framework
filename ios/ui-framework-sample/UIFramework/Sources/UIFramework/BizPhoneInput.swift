import SwiftUI

public struct BizPhoneInput: View {
    @Binding public var text: String
    public var countryCode: String
    public var label: String?
    public var placeholder: String?
    public var clearable: Bool
    public var onSelectCountry: (() -> Void)?
    
    @State private var isFocused: Bool = false
    
    public init(
        text: Binding<String>,
        countryCode: String = "+855",
        label: String? = nil,
        placeholder: String? = nil,
        clearable: Bool = true,
        onSelectCountry: (() -> Void)? = nil
    ) {
        self._text = text
        self.countryCode = countryCode
        self.label = label
        self.placeholder = placeholder
        self.clearable = clearable
        self.onSelectCountry = onSelectCountry
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let label = label {
                Text(label)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(Color(hex: "#333333"))
            }
            
            HStack(spacing: 0) {
                Button(action: {
                    onSelectCountry?()
                }) {
                    HStack(spacing: 4) {
                        Text(countryCode)
                            .font(.system(size: 15, weight: .semibold))
                            .tracking(0.5)
                        
                        Image(systemName: "chevron.down")
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .foregroundColor(Color(hex: "#1A2A5E"))
                    .padding(.horizontal, 16)
                    .frame(height: 50)
                }
                
                Divider()
                    .frame(width: 1, height: 24)
                    .background(Color(hex: "#E0E0E0"))
                
                TextField(placeholder ?? "", text: $text, onEditingChanged: { editing in
                    isFocused = editing
                })
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(Color(hex: "#1A2A5E"))
                    .keyboardType(.phonePad)
                    .padding(.horizontal, 16)
                    .frame(height: 50)
                
                if clearable && !text.isEmpty {
                    Button(action: {
                        text = ""
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(Color(hex: "#A0A0A0"))
                            .padding(.horizontal, 16)
                            .frame(height: 50)
                    }
                }
            }
            .background(Color.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isFocused ? Color(hex: "#1A2A5E") : Color(hex: "#0066CC"), lineWidth: 1) // Using 0066CC for active blue based on web design
            )
        }
    }
}
