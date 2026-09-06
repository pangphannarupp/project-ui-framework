import SwiftUI

/**
 * BizCompanySelector - SwiftUI component matching Web UI-Framework `PPCompanySelector.vue`.
 */
public struct BizCompanySelector: View {
    public var companyName: String
    public var companyType: String
    public var logoUrl: String
    public var action: () -> Void

    public init(
        companyName: String = "",
        companyType: String = "",
        logoUrl: String = "",
        action: @escaping () -> Void = {}
    ) {
        self.companyName = companyName
        self.companyType = companyType
        self.logoUrl = logoUrl
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("CompanySelector")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color(hex: "#1A2A5E"))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .background(Color.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(hex: "#CBD5E1"), lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

/**
 * Web UI-Framework parity alias for [BizCompanySelector].
 */
public typealias PPCompanySelector = BizCompanySelector
