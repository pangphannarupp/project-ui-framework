import SwiftUI

public struct BizCountryCodeSheetModifier: ViewModifier {
    @Binding var isPresented: Bool
    @Binding var selectedCode: String
    var onChange: ((String) -> Void)?
    
    @State private var searchQuery = ""
    @State private var activeTabIndex = 0
    
    let popularCountries = [
        ("KH", "Cambodia", "+855"),
        ("KR", "Republic of Korea", "+82"),
        ("CN", "China", "+86"),
        ("JP", "Japan", "+81")
    ]
    
    let allCountries = [
        ("KH", "Cambodia", "+855"),
        ("KR", "Republic of Korea", "+82"),
        ("CN", "China", "+86"),
        ("JP", "Japan", "+81"),
        ("US", "United States", "+1"),
        ("GB", "United Kingdom", "+44"),
        ("TH", "Thailand", "+66"),
        ("VN", "Vietnam", "+84"),
        ("SG", "Singapore", "+65")
    ]
    
    var filteredCountries: [(String, String, String)] {
        let list = activeTabIndex == 0 ? popularCountries : allCountries
        if searchQuery.isEmpty { return list }
        let query = searchQuery.lowercased()
        return list.filter {
            $0.1.lowercased().contains(query) || $0.2.contains(query)
        }
    }
    
    public func body(content: Content) -> some View {
        content.bizBottomSheet(
            isPresented: $isPresented,
            content: {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Select Your Country Code")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color(hex: "#1A2A5E"))
                        .padding(.bottom, 20)
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color(hex: "#999999"))
                            .font(.system(size: 16))
                        
                        TextField("Search", text: $searchQuery)
                            .font(.system(size: 16))
                            .foregroundColor(Color(hex: "#1A2A5E"))
                    }
                    .padding()
                    .background(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(hex: "#E0E0E0"), lineWidth: 1)
                    )
                    .padding(.bottom, 16)
                    
                    BizSegment(
                        items: ["Popular", "All Country"],
                        selectedIndex: $activeTabIndex
                    )
                    .padding(.bottom, 16)
                    
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(filteredCountries, id: \.0) { country in
                                CountryOptionRow(
                                    name: country.1,
                                    dialCode: country.2,
                                    isSelected: selectedCode == country.2,
                                    action: {
                                        selectedCode = country.2
                                        onChange?(country.2)
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                            isPresented = false
                                        }
                                    }
                                )
                            }
                        }
                    }
                    .frame(maxHeight: 350)
                }
                .padding(.horizontal, 24)
                .padding(.top, 8)
                .padding(.bottom, 20)
            }
        )
    }
}

private struct CountryOptionRow: View {
    let name: String
    let dialCode: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text("\(name) (\(dialCode))")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(isSelected ? Color(hex: "#0066CC") : Color(hex: "#111111"))
                
                Spacer()
                
                ZStack {
                    Circle()
                        .stroke(isSelected ? Color(hex: "#0066CC") : Color(hex: "#EAEAEA"), lineWidth: 2)
                        .frame(width: 20, height: 20)
                    
                    if isSelected {
                        Circle()
                            .fill(Color(hex: "#0066CC"))
                            .frame(width: 10, height: 10)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(Color.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color(hex: "#0066CC") : Color(hex: "#EAEAEA"), lineWidth: 1.5)
            )
        }
    }
}

public extension View {
    func bizCountryCodeSheet(
        isPresented: Binding<Bool>,
        selectedCode: Binding<String>,
        onChange: ((String) -> Void)? = nil
    ) -> some View {
        self.modifier(BizCountryCodeSheetModifier(
            isPresented: isPresented,
            selectedCode: selectedCode,
            onChange: onChange
        ))
    }
}
