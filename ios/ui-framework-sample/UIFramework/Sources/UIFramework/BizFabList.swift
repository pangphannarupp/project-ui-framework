import SwiftUI

public struct BizFabList<Content: View>: View {
    var side: Side
    var isActive: Bool
    var content: () -> Content
    
    public enum Side {
        case top
        case bottom
        case left
        case right
    }
    
    public init(
        side: Side = .top,
        isActive: Bool,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.side = side
        self.isActive = isActive
        self.content = content
    }
    
    public var body: some View {
        Group {
            if side == .top || side == .bottom {
                VStack(spacing: 12) {
                    if side == .top {
                        content()
                    } else {
                        content()
                    }
                }
            } else {
                HStack(spacing: 12) {
                    if side == .left {
                        content()
                    } else {
                        content()
                    }
                }
            }
        }
        .opacity(isActive ? 1.0 : 0.0)
        .scaleEffect(isActive ? 1.0 : 0.9)
        .offset(
            x: xOffset,
            y: yOffset
        )
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isActive)
    }
    
    private var xOffset: CGFloat {
        if isActive { return 0 }
        switch side {
        case .left: return 20
        case .right: return -20
        default: return 0
        }
    }
    
    private var yOffset: CGFloat {
        if isActive { return 0 }
        switch side {
        case .top: return 20
        case .bottom: return -20
        default: return 0
        }
    }
}
