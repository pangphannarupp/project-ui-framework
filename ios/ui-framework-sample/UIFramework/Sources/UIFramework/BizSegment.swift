import SwiftUI

public struct BizSegment: View {
    public var items: [String]
    @Binding public var selectedIndex: Int
    
    public init(items: [String], selectedIndex: Binding<Int>) {
        self.items = items
        self._selectedIndex = selectedIndex
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<items.count, id: \.self) { index in
                let isSelected = selectedIndex == index
                
                Text(items[index])
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(isSelected ? .white : Color(hex: "#666666"))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                    .background(isSelected ? Color(hex: "#1A2A5E") : Color.clear)
                    .cornerRadius(26)
                    .onTapGesture {
                        withAnimation {
                            selectedIndex = index
                        }
                    }
            }
        }
        .padding(4)
        .background(Color.white)
        .cornerRadius(30)
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(Color(hex: "#E0E0E0"), lineWidth: 1)
        )
    }
}
