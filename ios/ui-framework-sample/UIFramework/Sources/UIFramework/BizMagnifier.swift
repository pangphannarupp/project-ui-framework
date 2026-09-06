import SwiftUI

/**
 * BizMagnifier - SwiftUI component matching Web UI-Framework `PPMagnifier.vue`.
 */
public struct BizMagnifier: View {
    public var src: String
    public var alt: String
    public var zoom: Int
    public var lensSize: Int
    public var action: () -> Void

    public init(
        src: String = "",
        alt: String = "",
        zoom: Int = 0,
        lensSize: Int = 120,
        action: @escaping () -> Void = {}
    ) {
        self.src = src
        self.alt = alt
        self.zoom = zoom
        self.lensSize = lensSize
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Magnifier")
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
 * Web UI-Framework parity alias for [BizMagnifier].
 */
public typealias PPMagnifier = BizMagnifier
