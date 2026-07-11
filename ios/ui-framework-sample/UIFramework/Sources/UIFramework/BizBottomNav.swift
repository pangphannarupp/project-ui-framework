import SwiftUI

public struct BizBottomNavItem: Identifiable {
    public let id = UUID()
    public var label: String
    public var value: String
    public var icon: String
    public var activeIcon: String?
    
    public init(label: String, value: String, icon: String, activeIcon: String? = nil) {
        self.label = label
        self.value = value
        self.icon = icon
        self.activeIcon = activeIcon
    }
}

public struct BizBottomNav: View {
    @Binding public var selectedValue: String
    public var items: [BizBottomNavItem]
    public var onChange: ((String) -> Void)?
    
    public init(selectedValue: Binding<String>, items: [BizBottomNavItem], onChange: ((String) -> Void)? = nil) {
        self._selectedValue = selectedValue
        self.items = items
        self.onChange = onChange
    }
    
    public var body: some View {
        HStack {
            ForEach(items) { item in
                let isActive = selectedValue == item.value
                
                Button(action: {
                    selectedValue = item.value
                    onChange?(item.value)
                }) {
                    VStack(spacing: 4) {
                        ZStack {
                            if isActive {
                                Capsule()
                                    .fill(Color(hex: "#D3E3FD"))
                                    .frame(width: 64, height: 32)
                            }
                            
                            Image(systemName: isActive ? (item.activeIcon ?? item.icon) : item.icon)
                                .font(.system(size: 24))
                                .foregroundColor(isActive ? Color(hex: "#041E49") : Color(hex: "#5F6368"))
                        }
                        .frame(height: 32)
                        
                        Text(item.label)
                            .font(.system(size: 12, weight: isActive ? .bold : .medium))
                            .foregroundColor(isActive ? Color(hex: "#1A1A1A") : Color(hex: "#5F6368"))
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .frame(height: 80)
        .padding(.bottom, safeAreaBottom)
        .background(Color(hex: "#F4F5F8"))
        .shadow(color: Color.black.opacity(0.03), radius: 2, x: 0, y: -1)
    }
    
    private var safeAreaBottom: CGFloat {
        if let window = UIApplication.shared.windows.first {
            return window.safeAreaInsets.bottom
        }
        return 0
    }
}
