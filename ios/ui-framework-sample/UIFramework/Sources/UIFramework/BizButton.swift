import SwiftUI

public enum BizButtonVariant {
    case primary
    case secondary
    case outline
    case ghost
    case outlineDanger
}

public struct BizButtonStyle: ButtonStyle {
    public var variant: BizButtonVariant
    public var isBlock: Bool
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.bizButtonGroupIsVertical) private var isVerticalGroup

    public init(variant: BizButtonVariant = .primary, isBlock: Bool = false) {
        self.variant = variant
        self.isBlock = isBlock
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 16, weight: .semibold))
            .padding(.vertical, variant == .ghost ? 0 : 16)
            .padding(.horizontal, variant == .ghost ? 0 : 24)
            .frame(maxWidth: isBlock ? .infinity : nil)
            .background(background(isPressed: configuration.isPressed))
            .foregroundColor(foregroundColor)
            .cornerRadius(isVerticalGroup != nil ? 0 : 12)
            .overlay(
                Group {
                    if isVerticalGroup == nil {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(borderColor, lineWidth: 1)
                    } else {
                        Rectangle()
                            .stroke(borderColor, lineWidth: 1)
                    }
                }
            )
            .opacity(!isEnabled ? 0.8 : (configuration.isPressed && variant != .ghost ? 0.8 : 1.0))
    }

    private func background(isPressed: Bool) -> Color {
        if !isEnabled {
            return variant == .outline || variant == .outlineDanger || variant == .ghost ? .clear : Color(red: 192/255, green: 192/255, blue: 192/255)
        }
        switch variant {
        case .primary: return isPressed ? Color(red: 18/255, green: 30/255, blue: 66/255) : Color(red: 26/255, green: 42/255, blue: 94/255)
        case .secondary: return Color(red: 224/255, green: 224/255, blue: 224/255)
        case .outline, .outlineDanger, .ghost: return .clear
        }
    }

    private var foregroundColor: Color {
        if !isEnabled && variant != .outline && variant != .outlineDanger && variant != .ghost {
            return .white
        }
        switch variant {
        case .primary: return .white
        case .secondary: return Color(red: 51/255, green: 51/255, blue: 51/255)
        case .outline: return Color(red: 59/255, green: 99/255, blue: 204/255)
        case .outlineDanger: return Color(red: 211/255, green: 47/255, blue: 47/255)
        case .ghost: return Color(red: 0, green: 102/255, blue: 204/255)
        }
    }

    private var borderColor: Color {
        switch variant {
        case .outline: return Color(red: 204/255, green: 204/255, blue: 204/255)
        case .outlineDanger: return Color(red: 211/255, green: 47/255, blue: 47/255)
        default: return .clear
        }
    }
}

public struct BizButton: View {
    public let title: String
    public let variant: BizButtonVariant
    public let isBlock: Bool
    public let action: () -> Void
    public let leftIcon: Image?
    public let rightIcon: Image?

    public init(
        _ title: String,
        variant: BizButtonVariant = .primary,
        isBlock: Bool = false,
        leftIcon: Image? = nil,
        rightIcon: Image? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.variant = variant
        self.isBlock = isBlock
        self.leftIcon = leftIcon
        self.rightIcon = rightIcon
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if let leftIcon = leftIcon {
                    leftIcon.resizable().scaledToFit().frame(width: 20, height: 20)
                }
                Text(title)
                if let rightIcon = rightIcon {
                    rightIcon.resizable().scaledToFit().frame(width: 20, height: 20)
                }
            }
        }
        .buttonStyle(BizButtonStyle(variant: variant, isBlock: isBlock))
    }
}
