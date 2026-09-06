import SwiftUI

/**
 * BizImageCropper - SwiftUI component matching Web UI-Framework `PPImageCropper.vue`.
 */
public struct BizImageCropper: View {
    public var src: String
    public var aspectRatio: Int
    public var action: () -> Void

    public init(
        src: String = "",
        aspectRatio: Int = 0,
        action: @escaping () -> Void = {}
    ) {
        self.src = src
        self.aspectRatio = aspectRatio
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("ImageCropper")
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
 * Web UI-Framework parity alias for [BizImageCropper].
 */
public typealias PPImageCropper = BizImageCropper
