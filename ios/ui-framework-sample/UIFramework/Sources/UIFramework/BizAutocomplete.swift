import SwiftUI

public struct BizAutocompleteOption: Hashable {
    public let label: String
    public let value: String
    
    public init(label: String, value: String) {
        self.label = label
        self.value = value
    }
}

public struct BizAutocomplete: View {
    @Binding public var text: String
    public var label: String?
    public var placeholder: String
    public var options: [BizAutocompleteOption]
    public var filter: Bool
    public var onSelect: ((BizAutocompleteOption) -> Void)?
    
    @State private var isEditing = false
    @State private var isOpen = false
    
    public init(
        text: Binding<String>,
        label: String? = nil,
        placeholder: String = "",
        options: [BizAutocompleteOption],
        filter: Bool = true,
        onSelect: ((BizAutocompleteOption) -> Void)? = nil
    ) {
        self._text = text
        self.label = label
        self.placeholder = placeholder
        self.options = options
        self.filter = filter
        self.onSelect = onSelect
    }
    
    private var filteredOptions: [BizAutocompleteOption] {
        if !filter || text.isEmpty {
            return options
        }
        return options.filter { $0.label.lowercased().contains(text.lowercased()) }
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let lbl = label {
                Text(lbl)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color(red: 51/255, green: 51/255, blue: 51/255))
            }
            
            HStack {
                TextField(placeholder, text: $text, onEditingChanged: { editing in
                    isEditing = editing
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isOpen = editing
                    }
                })
                .font(.system(size: 16))
                .foregroundColor(Color(red: 51/255, green: 51/255, blue: 51/255))
                
                if !text.isEmpty {
                    Button(action: {
                        text = ""
                        isOpen = true
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(Color(red: 153/255, green: 153/255, blue: 153/255))
                            .font(.system(size: 14, weight: .bold))
                            .padding(4)
                    }
                }
                
                Image(systemName: "chevron.down")
                    .foregroundColor(Color(red: 153/255, green: 153/255, blue: 153/255))
                    .rotationEffect(.degrees(isOpen ? 180 : 0))
                    .animation(.easeInOut(duration: 0.2), value: isOpen)
            }
            .padding(.horizontal, 16)
            .frame(height: 52)
            .background(Color.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isEditing ? Color(red: 26/255, green: 42/255, blue: 94/255) : Color(red: 204/255, green: 204/255, blue: 204/255), lineWidth: 1)
            )
            // Dropdown Menu using overlay so it can break bounds
            .overlay(
                Group {
                    if isOpen {
                        dropdownView
                            .offset(y: 56)
                    }
                },
                alignment: .top
            )
            // Need a high zIndex so the overlay dropdown goes over following views
            .zIndex(isOpen ? 1 : 0)
        }
    }
    
    private var dropdownView: some View {
        VStack(spacing: 0) {
            let opts = filteredOptions
            if opts.isEmpty {
                Text("No results found.")
                    .font(.system(size: 14))
                    .foregroundColor(Color(red: 153/255, green: 153/255, blue: 153/255))
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .center)
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(opts, id: \.self) { option in
                            Button(action: {
                                text = option.label
                                onSelect?(option)
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    isOpen = false
                                }
                                // Ideally dismiss keyboard here
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }) {
                                Text(option.label)
                                    .font(.system(size: 15))
                                    .foregroundColor(Color(red: 51/255, green: 51/255, blue: 51/255))
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 12)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .frame(maxHeight: 240)
            }
        }
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(red: 224/255, green: 224/255, blue: 224/255), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.1), radius: 12, x: 0, y: 4)
    }
}
