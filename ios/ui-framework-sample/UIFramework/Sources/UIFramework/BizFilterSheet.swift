import SwiftUI

public struct BizFilterSheetModifier: ViewModifier {
    @Binding var isPresented: Bool
    @Binding var selectedFacilities: [String]
    var onApply: (([String]) -> Void)?
    
    let facilities = ["Korea Desk", "Japan Desk", "China Desk", "SME Center", "Coffee"]
    
    public func body(content: Content) -> some View {
        content.bizBottomSheet(
            isPresented: $isPresented,
            header: { EmptyView() },
            footer: {
                VStack(spacing: 12) {
                    BizButton("Apply", variant: .primary, action: {
                        onApply?(selectedFacilities)
                        isPresented = false
                    })
                    
                    BizButton("Close", variant: .outline, action: {
                        isPresented = false
                    })
                }
            },
            content: {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Filter")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color(hex: "#1A2A5E"))
                        .padding(.bottom, 8)
                    
                    Text("Search branch you wish to visit faster.")
                        .font(.system(size: 14))
                        .foregroundColor(Color(hex: "#555555"))
                        .padding(.bottom, 32)
                    
                    Text("BRANCH FACILITY")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(Color(hex: "#1A2A5E"))
                        .tracking(0.5)
                        .padding(.bottom, 16)
                    
                    // Simple wrapping layout for chips (FlowLayout replacement)
                    // In a production iOS app, this would use a custom layout or UICollectionView
                    // For this framework sample, we will use a LazyVGrid or wrapped HStacks
                    ScrollView {
                        // Wrapping HStack simulation
                        let chunked = facilities.chunked(into: 3)
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(0..<chunked.count, id: \.self) { rowIndex in
                                HStack(spacing: 12) {
                                    ForEach(chunked[rowIndex], id: \.self) { facility in
                                        FilterChip(
                                            title: facility,
                                            isSelected: selectedFacilities.contains(facility),
                                            action: {
                                                if selectedFacilities.contains(facility) {
                                                    selectedFacilities.removeAll { $0 == facility }
                                                } else {
                                                    selectedFacilities.append(facility)
                                                }
                                            }
                                        )
                                    }
                                }
                            }
                        }
                    }
                    .frame(maxHeight: 150)
                }
                .padding(.horizontal, 24)
                .padding(.top, 8)
            }
        )
    }
}

private struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 13, weight: .semibold))
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .foregroundColor(isSelected ? .white : Color(hex: "#111111"))
                .background(isSelected ? Color(hex: "#1A2A5E") : Color.white)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(isSelected ? Color(hex: "#1A2A5E") : Color(hex: "#EAEAEA"), lineWidth: 1)
                )
        }
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

public extension View {
    func bizFilterSheet(
        isPresented: Binding<Bool>,
        selectedFacilities: Binding<[String]>,
        onApply: (([String]) -> Void)? = nil
    ) -> some View {
        self.modifier(BizFilterSheetModifier(
            isPresented: isPresented,
            selectedFacilities: selectedFacilities,
            onApply: onApply
        ))
    }
}
