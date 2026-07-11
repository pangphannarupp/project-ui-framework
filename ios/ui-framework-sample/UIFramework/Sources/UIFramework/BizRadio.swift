import SwiftUI

public struct BizRadio: View {
    public var isSelected: Bool
    public var label: String?
    public var selectedColor: Color
    public var action: () -> Void

    public init(isSelected: Bool, label: String? = nil, selectedColor: Color = Color(hex: "#1A2A5E"), action: @escaping () -> Void) {
        self.isSelected = isSelected
        self.label = label
        self.selectedColor = selectedColor
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            HStack(alignment: .center, spacing: 8) {
                ZStack {
                    Circle()
                        .stroke(isSelected ? selectedColor : Color(hex: "#CCCCCC"), lineWidth: 1.5)
                        .frame(width: 20, height: 20)
                        .background(Circle().fill(Color.white))
                    
                    if isSelected {
                        Circle()
                            .fill(selectedColor)
                            .frame(width: 10, height: 10)
                    }
                }
                
                if let label = label {
                    Text(label)
                        .font(.system(size: 14))
                        .foregroundColor(Color(hex: "#333333"))
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
