import SwiftUI

public struct BizBottomMenuItem: Identifiable {
    public let id = UUID()
    public let title: String
    public let iconSystemName: String
    public let selectedIconSystemName: String
    
    public init(title: String, iconSystemName: String, selectedIconSystemName: String? = nil) {
        self.title = title
        self.iconSystemName = iconSystemName
        self.selectedIconSystemName = selectedIconSystemName ?? iconSystemName
    }
}

public struct BizBottomMenu: View {
    public let items: [BizBottomMenuItem]
    @Binding public var selectedIndex: Int
    
    public init(items: [BizBottomMenuItem], selectedIndex: Binding<Int>) {
        self.items = items
        self._selectedIndex = selectedIndex
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<items.count, id: \.self) { index in
                let item = items[index]
                let isSelected = selectedIndex == index
                
                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        selectedIndex = index
                    }
                }) {
                    VStack(spacing: 4) {
                        // Icon with Pill background when selected
                        Image(systemName: isSelected ? item.selectedIconSystemName : item.iconSystemName)
                            .font(.system(size: 24))
                            .foregroundColor(isSelected ? .black : .primary.opacity(0.6))
                            .frame(width: 64, height: 32)
                            .background(
                                isSelected ? Color.blue.opacity(0.2) : Color.clear
                            )
                            .clipShape(Capsule())
                        
                        // Label
                        Text(item.title)
                            .font(.system(size: 12, weight: isSelected ? .semibold : .regular))
                            .foregroundColor(isSelected ? .primary : .primary.opacity(0.6))
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.vertical, 12)
        .background(Color(UIColor.systemBackground))
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -2)
    }
}

// MARK: - Preview Wrapper for Demo
public struct BizBottomMenuDemo: View {
    @State private var selectedIndex = 0
    
    let items = [
        BizBottomMenuItem(title: "Home", iconSystemName: "house", selectedIconSystemName: "house.fill"),
        BizBottomMenuItem(title: "Search", iconSystemName: "magnifyingglass"),
        BizBottomMenuItem(title: "Profile", iconSystemName: "person", selectedIconSystemName: "person.fill"),
        BizBottomMenuItem(title: "Settings", iconSystemName: "gearshape", selectedIconSystemName: "gearshape.fill")
    ]
    
    public init() {}
    
    public var body: some View {
        VStack {
            Spacer()
            Text("Selected Index: \(selectedIndex)")
                .font(.largeTitle)
                .foregroundColor(.secondary)
            Spacer()
            BizBottomMenu(items: items, selectedIndex: $selectedIndex)
        }
    }
}

struct BizBottomMenu_Previews: PreviewProvider {
    static var previews: some View {
        BizBottomMenuDemo()
    }
}
