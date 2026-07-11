import SwiftUI

public enum BizButtonVariant {
    case primary, secondary, outline, ghost, outlineDanger
}

public struct BizButton<LeftIcon: View, RightIcon: View>: View {
    public var text: String
    public var variant: BizButtonVariant
    public var block: Bool
    public var enabled: Bool
    public var iconLeft: LeftIcon?
    public var iconRight: RightIcon?
    public var onClick: () -> Void
    
    public init(
        text: String,
        variant: BizButtonVariant = .primary,
        block: Bool = false,
        enabled: Bool = true,
        @ViewBuilder iconLeft: () -> LeftIcon = { EmptyView() },
        @ViewBuilder iconRight: () -> RightIcon = { EmptyView() },
        onClick: @escaping () -> Void
    ) {
        self.text = text
        self.variant = variant
        self.block = block
        self.enabled = enabled
        self.iconLeft = iconLeft()
        self.iconRight = iconRight()
        self.onClick = onClick
    }
    
    public var body: some View {
        Button(action: onClick) {
            HStack(spacing: 8) {
                if let left = iconLeft {
                    left
                }
                
                Text(text)
                    .font(.system(size: 16, weight: .semibold))
                
                if let right = iconRight {
                    right
                }
            }
            .frame(maxWidth: block ? .infinity : nil, minHeight: 56)
            .padding(.horizontal, block ? 0 : 24)
            .background(backgroundView)
            .foregroundColor(foregroundColor)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
        }
        .disabled(!enabled)
        .opacity(enabled ? 1.0 : 0.8)
    }
    
    @ViewBuilder
    private var backgroundView: some View {
        if !enabled {
            Color(hex: "#C0C0C0")
        } else {
            switch variant {
            case .primary:
                Color(hex: "#1A2A5E")
            case .secondary:
                Color(hex: "#E0E0E0")
            case .outline, .outlineDanger, .ghost:
                Color.clear
            }
        }
    }
    
    private var foregroundColor: Color {
        if !enabled {
            return .white
        }
        switch variant {
        case .primary:
            return .white
        case .secondary:
            return Color(hex: "#333333")
        case .outline:
            return Color(hex: "#3B63CC")
        case .outlineDanger:
            return Color(hex: "#D32F2F")
        case .ghost:
            return Color(hex: "#0066CC")
        }
    }
    
    private var borderColor: Color {
        if !enabled {
            return .clear
        }
        switch variant {
        case .outline:
            return Color(hex: "#CCCCCC")
        case .outlineDanger:
            return Color(hex: "#D32F2F")
        default:
            return .clear
        }
    }
    
    private var borderWidth: CGFloat {
        switch variant {
        case .outline, .outlineDanger:
            return 1
        default:
            return 0
        }
    }
}

// Extension to allow init without icons
public extension BizButton where LeftIcon == EmptyView, RightIcon == EmptyView {
    init(
        text: String,
        variant: BizButtonVariant = .primary,
        block: Bool = false,
        enabled: Bool = true,
        onClick: @escaping () -> Void
    ) {
        self.init(
            text: text,
            variant: variant,
            block: block,
            enabled: enabled,
            iconLeft: { EmptyView() },
            iconRight: { EmptyView() },
            onClick: onClick
        )
    }
}
