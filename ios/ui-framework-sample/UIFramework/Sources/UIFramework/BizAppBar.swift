import SwiftUI

public struct BizAppBar<Content: View>: View {
    public var title: String
    public var backgroundColor: Color
    public var foregroundColor: Color
    public var showBackButton: Bool
    public var onBackClick: (() -> Void)?
    public var actions: () -> Content

    public init(
        title: String,
        backgroundColor: Color = Color(hex: "#003399"),
        foregroundColor: Color = .white,
        showBackButton: Bool = true,
        onBackClick: (() -> Void)? = nil,
        @ViewBuilder actions: @escaping () -> Content = { EmptyView() }
    ) {
        self.title = title
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.showBackButton = showBackButton
        self.onBackClick = onBackClick
        self.actions = actions
    }

    public var body: some View {
        HStack {
            if showBackButton {
                Button(action: {
                    onBackClick?()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(foregroundColor)
                }
            }
            
            Text(title)
                .font(.headline)
                .foregroundColor(foregroundColor)
            
            Spacer()
            
            actions()
        }
        .padding()
        .background(backgroundColor)
    }
}
