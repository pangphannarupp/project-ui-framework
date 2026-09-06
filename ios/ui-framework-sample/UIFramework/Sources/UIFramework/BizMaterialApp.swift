import SwiftUI

/**
 * BizMaterialApp - SwiftUI component matching Web UI-Framework `PPMaterialApp.vue`.
 */
public struct BizMaterialApp: View {
    public var theme: String
    public var drawerOverlay: Bool
    public var drawerOpen: Bool
    public var responsive: Bool
    public var drawerVariant: String
    public var hideAppBarOnScroll: Bool
    public var hideBottomNavOnScroll: Bool
    public var fabPosition: String
    public var action: () -> Void

    public init(
        theme: String = "light",
        drawerOverlay: Bool = true,
        drawerOpen: Bool = false,
        responsive: Bool = false,
        drawerVariant: String = "default",
        hideAppBarOnScroll: Bool = false,
        hideBottomNavOnScroll: Bool = false,
        fabPosition: String = "bottom-right",
        action: @escaping () -> Void = {}
    ) {
        self.theme = theme
        self.drawerOverlay = drawerOverlay
        self.drawerOpen = drawerOpen
        self.responsive = responsive
        self.drawerVariant = drawerVariant
        self.hideAppBarOnScroll = hideAppBarOnScroll
        self.hideBottomNavOnScroll = hideBottomNavOnScroll
        self.fabPosition = fabPosition
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("MaterialApp")
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
 * Web UI-Framework parity alias for [BizMaterialApp].
 */
public typealias PPMaterialApp = BizMaterialApp
