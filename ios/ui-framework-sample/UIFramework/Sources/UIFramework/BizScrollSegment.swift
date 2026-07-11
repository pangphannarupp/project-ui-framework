import SwiftUI

public struct BizScrollSegmentOption: Hashable {
    public let id: String
    public let label: String
    
    public init(id: String, label: String) {
        self.id = id
        self.label = label
    }
}

public struct BizScrollSegment: View {
    @Binding public var selectedId: String
    public var options: [BizScrollSegmentOption]
    
    public init(selectedId: Binding<String>, options: [BizScrollSegmentOption]) {
        self._selectedId = selectedId
        self.options = options
    }
    
    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(options, id: \.id) { option in
                    let isSelected = selectedId == option.id
                    Button(action: {
                        selectedId = option.id
                    }) {
                        Text(option.label)
                            .font(.system(size: 14, weight: isSelected ? .bold : .medium))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(isSelected ? Color(red: 26/255, green: 42/255, blue: 94/255) : Color(red: 244/255, green: 245/255, blue: 248/255))
                            .foregroundColor(isSelected ? .white : Color(red: 102/255, green: 102/255, blue: 102/255))
                            .cornerRadius(20)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
    }
}
