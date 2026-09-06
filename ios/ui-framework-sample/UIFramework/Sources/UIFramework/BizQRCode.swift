import SwiftUI

/**
 * BizQRCode - SwiftUI component matching Web UI-Framework `PPQRCode.vue`.
 */
public struct BizQRCode: View {
    public var value: String
    public var size: Int
    public var logo: String
    public var downloadable: Bool
    public var action: () -> Void

    public init(
        value: String = "",
        size: Int = 200,
        logo: String = "",
        downloadable: Bool = false,
        action: @escaping () -> Void = {}
    ) {
        self.value = value
        self.size = size
        self.logo = logo
        self.downloadable = downloadable
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("QRCode")
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
 * Web UI-Framework parity alias for [BizQRCode].
 */
public typealias PPQRCode = BizQRCode
