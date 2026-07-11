import SwiftUI

public struct BizLanguageSheetModifier: ViewModifier {
    @Binding var isPresented: Bool
    @Binding var selectedLanguage: String
    var onChange: ((String) -> Void)?
    
    let languages = [
        ("km", "ភាសាខ្មែរ", "🇰🇭"),
        ("en", "English", "🇬🇧"),
        ("ko", "한국어", "🇰🇷"),
        ("ja", "日本語", "🇯🇵"),
        ("zh", "漢語", "🇨🇳")
    ]
    
    public func body(content: Content) -> some View {
        content.bizBottomSheet(
            isPresented: $isPresented,
            content: {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Please Select Your Language")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color(hex: "#1A2A5E"))
                        .padding(.bottom, 8)
                    
                    Text("Choose the language and region you want to use in smartBiz app")
                        .font(.system(size: 12))
                        .foregroundColor(Color(hex: "#555555"))
                        .lineSpacing(4)
                        .padding(.bottom, 24)
                    
                    VStack(spacing: 12) {
                        ForEach(languages, id: \.0) { lang in
                            LanguageOptionRow(
                                code: lang.0,
                                name: lang.1,
                                flag: lang.2,
                                isSelected: selectedLanguage == lang.0,
                                action: {
                                    selectedLanguage = lang.0
                                    onChange?(lang.0)
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

private struct LanguageOptionRow: View {
    let code: String
    let name: String
    let flag: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                HStack(spacing: 12) {
                    Text(flag)
                        .font(.system(size: 20))
                    
                    Text(name)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color(hex: "#111111"))
                }
                
                Spacer()
                
                ZStack {
                    Circle()
                        .stroke(isSelected ? Color(hex: "#1A2A5E") : Color(hex: "#EAEAEA"), lineWidth: 2)
                        .frame(width: 20, height: 20)
                    
                    if isSelected {
                        Circle()
                            .fill(Color(hex: "#1A2A5E"))
                            .frame(width: 10, height: 10)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color(hex: "#1A2A5E") : Color(hex: "#EAEAEA"), lineWidth: 1.5)
            )
        }
    }
}

public extension View {
    func bizLanguageSheet(
        isPresented: Binding<Bool>,
        selectedLanguage: Binding<String>,
        onChange: ((String) -> Void)? = nil
    ) -> some View {
        self.modifier(BizLanguageSheetModifier(
            isPresented: isPresented,
            selectedLanguage: selectedLanguage,
            onChange: onChange
        ))
    }
}
