import SwiftUI

public struct BizSortSheetModifier: ViewModifier {
    @Binding var isPresented: Bool
    @Binding var selectedSort: String
    var onChange: ((String) -> Void)?
    
    let options = [
        ("distance", "By Distance"),
        ("name", "By Name")
    ]
    
    public func body(content: Content) -> some View {
        content.bizBottomSheet(
            isPresented: $isPresented,
            content: {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Sort")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color(hex: "#1A2A5E"))
                        .padding(.bottom, 8)
                    
                    Text("More convenient to locate the branch you wish to visit.")
                        .font(.system(size: 14))
                        .foregroundColor(Color(hex: "#555555"))
                        .padding(.bottom, 24)
                    
                    VStack(spacing: 16) {
                        ForEach(options, id: \.0) { option in
                            SortOptionRow(
                                label: option.1,
                                isSelected: selectedSort == option.0,
                                action: {
                                    selectedSort = option.0
                                    onChange?(option.0)
                                    // Auto close after small delay
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                        isPresented = false
                                    }
                                }
                            )
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 8)
                .padding(.bottom, 32)
            }
        )
    }
}

private struct SortOptionRow: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(label)
                    .font(.system(size: 15, weight: isSelected ? .bold : .regular))
                    .foregroundColor(Color(hex: "#111111"))
                
                Spacer()
                
                ZStack {
                    Circle()
                        .stroke(isSelected ? Color(hex: "#1A2A5E") : Color(hex: "#EAEAEA"), lineWidth: isSelected ? 2.5 : 1.5)
                        .frame(width: 22, height: 22)
                    
                    if isSelected {
                        Circle()
                            .fill(Color(hex: "#1A2A5E"))
                            .frame(width: 10, height: 10)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, isSelected ? 15 : 16)
            .background(Color.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color(hex: "#1A2A5E") : Color(hex: "#EAEAEA"), lineWidth: isSelected ? 2 : 1)
            )
        }
    }
}

public extension View {
    func bizSortSheet(
        isPresented: Binding<Bool>,
        selectedSort: Binding<String>,
        onChange: ((String) -> Void)? = nil
    ) -> some View {
        self.modifier(BizSortSheetModifier(
            isPresented: isPresented,
            selectedSort: selectedSort,
            onChange: onChange
        ))
    }
}
