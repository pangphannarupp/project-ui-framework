import SwiftUI

public enum BizSelectVariant {
    case outlined
    case filled
    case underlined
}

public struct BizSelectOption: Hashable {
    public let label: String
    public let value: String
    
    public init(label: String, value: String) {
        self.label = label
        self.value = value
    }
}

public struct BizSelect: View {
    @Binding public var selectedValue: String
    public var options: [BizSelectOption]
    public var label: String?
    public var placeholder: String?
    public var variant: BizSelectVariant
    public var isDisabled: Bool
    public var error: String?
    public var helperText: String?
    public var isRequired: Bool
    
    public init(
        selectedValue: Binding<String>,
        options: [BizSelectOption],
        label: String? = nil,
        placeholder: String? = nil,
        variant: BizSelectVariant = .outlined,
        isDisabled: Bool = false,
        error: String? = nil,
        helperText: String? = nil,
        isRequired: Bool = false
    ) {
        self._selectedValue = selectedValue
        self.options = options
        self.label = label
        self.placeholder = placeholder
        self.variant = variant
        self.isDisabled = isDisabled
        self.error = error
        self.helperText = helperText
        self.isRequired = isRequired
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            if let lbl = label {
                HStack(spacing: 4) {
                    Text(lbl)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(error != nil ? Color(red: 220/255, green: 53/255, blue: 69/255) : Color(red: 51/255, green: 51/255, blue: 51/255))
                    if isRequired {
                        Text("*")
                            .foregroundColor(Color(red: 220/255, green: 53/255, blue: 69/255))
                    }
                }
            }
            
            Menu {
                ForEach(options, id: \.value) { option in
                    Button(action: {
                        selectedValue = option.value
                    }) {
                        Text(option.label)
                    }
                }
            } label: {
                HStack {
                    if let selectedOption = options.first(where: { $0.value == selectedValue }) {
                        Text(selectedOption.label)
                            .foregroundColor(isDisabled ? Color(red: 153/255, green: 153/255, blue: 153/255) : Color(red: 51/255, green: 51/255, blue: 51/255))
                    } else {
                        Text(placeholder ?? "")
                            .foregroundColor(Color(red: 153/255, green: 153/255, blue: 153/255))
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .foregroundColor(Color(red: 153/255, green: 153/255, blue: 153/255))
                }
                .font(.system(size: 16))
                .padding(.horizontal, variant == .underlined ? 4 : 16)
                .frame(height: 52)
                .background(backgroundView)
                .overlay(borderView)
                .opacity(isDisabled ? 0.6 : 1.0)
            }
            .disabled(isDisabled)
            
            if let msg = error ?? helperText {
                Text(msg)
                    .font(.system(size: 12))
                    .foregroundColor(error != nil ? Color(red: 220/255, green: 53/255, blue: 69/255) : Color(red: 102/255, green: 102/255, blue: 102/255))
                    .padding(.top, 2)
            }
        }
    }
    
    @ViewBuilder
    private var backgroundView: some View {
        if variant == .filled {
            Color(red: 245/255, green: 245/255, blue: 245/255)
                .cornerRadius(8, corners: [.topLeft, .topRight])
        } else if variant == .outlined {
            Color.white
                .cornerRadius(12)
        } else {
            Color.clear
        }
    }
    
    @ViewBuilder
    private var borderView: some View {
        let borderColor = error != nil ? Color(red: 220/255, green: 53/255, blue: 69/255) : Color(red: 204/255, green: 204/255, blue: 204/255)
        
        if variant == .outlined {
            RoundedRectangle(cornerRadius: 12)
                .stroke(borderColor, lineWidth: 1)
        } else if variant == .filled {
            VStack {
                Spacer()
                Rectangle()
                    .fill(error != nil ? Color(red: 220/255, green: 53/255, blue: 69/255) : Color(red: 153/255, green: 153/255, blue: 153/255))
                    .frame(height: 1)
            }
        } else if variant == .underlined {
            VStack {
                Spacer()
                Rectangle()
                    .fill(borderColor)
                    .frame(height: 1)
            }
        }
    }
}
