import SwiftUI

public struct BizNoResult<Graphic: View, ActionView: View>: View {
    public var title: String
    public var subtitle: String?
    public var graphic: (() -> Graphic)?
    public var action: (() -> ActionView)?
    
    public init(
        title: String = "No results found",
        subtitle: String? = "Try changing your search or filter.",
        @ViewBuilder graphic: @escaping () -> Graphic,
        @ViewBuilder action: @escaping () -> ActionView
    ) {
        self.title = title
        self.subtitle = subtitle
        self.graphic = graphic
        self.action = action
    }
    
    public init(
        title: String = "No results found",
        subtitle: String? = "Try changing your search or filter.",
        @ViewBuilder graphic: @escaping () -> Graphic
    ) where ActionView == EmptyView {
        self.title = title
        self.subtitle = subtitle
        self.graphic = graphic
        self.action = nil
    }
}

public extension BizNoResult where Graphic == AnyView {
    init(
        title: String = "No results found",
        subtitle: String? = "Try changing your search or filter.",
        @ViewBuilder action: @escaping () -> ActionView
    ) {
        self.title = title
        self.subtitle = subtitle
        self.graphic = nil
        self.action = action
    }
}

public extension BizNoResult where Graphic == AnyView, ActionView == EmptyView {
    init(
        title: String = "No results found",
        subtitle: String? = "Try changing your search or filter."
    ) {
        self.title = title
        self.subtitle = subtitle
        self.graphic = nil
        self.action = nil
    }
}

extension BizNoResult {
    public var body: some View {
        VStack(spacing: 24) {
            if let customGraphic = graphic {
                customGraphic()
            } else {
                defaultGraphic
            }
            
            VStack(spacing: 8) {
                Text(title)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color(red: 51/255, green: 51/255, blue: 51/255))
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.system(size: 14))
                        .foregroundColor(Color(red: 119/255, green: 119/255, blue: 119/255))
                        .multilineTextAlignment(.center)
                }
            }
            
            if let actionView = action {
                actionView()
            }
        }
        .padding(40)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    @ViewBuilder
    private var defaultGraphic: some View {
        ZStack {
            Circle()
                .fill(Color(red: 158/255, green: 158/255, blue: 158/255))
                .frame(width: 60, height: 60)
            
            Image(systemName: "questionmark")
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.white)
            
            Image(systemName: "magnifyingglass")
                .font(.system(size: 34, weight: .bold))
                .foregroundColor(Color(red: 96/255, green: 103/255, blue: 117/255))
                .background(
                    Circle()
                        .fill(Color(red: 216/255, green: 216/255, blue: 216/255).opacity(0.9))
                        .frame(width: 40, height: 40)
                )
                .offset(x: 20, y: 20)
        }
        .frame(width: 120, height: 120)
    }
}
