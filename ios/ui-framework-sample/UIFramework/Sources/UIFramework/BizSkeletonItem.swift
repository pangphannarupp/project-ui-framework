import SwiftUI

public enum BizSkeletonVariant {
    case text
    case rect
    case circle
    case image
}

public struct BizSkeletonItem: View {
    public var variant: BizSkeletonVariant
    public var width: CGFloat?
    public var height: CGFloat?
    
    @State private var isAnimating = false
    
    public init(variant: BizSkeletonVariant = .text, width: CGFloat? = nil, height: CGFloat? = nil) {
        self.variant = variant
        self.width = width
        self.height = height
    }
    
    public var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 240/255, green: 240/255, blue: 240/255),
                            Color(red: 224/255, green: 224/255, blue: 224/255),
                            Color(red: 240/255, green: 240/255, blue: 240/255)
                        ]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(width: geometry.size.width * 2)
                .offset(x: isAnimating ? geometry.size.width : -geometry.size.width)
                .animation(
                    Animation.linear(duration: 1.5).repeatForever(autoreverses: false),
                    value: isAnimating
                )
        }
        .frame(
            width: width ?? defaultWidth,
            height: height ?? defaultHeight
        )
        .background(Color(red: 240/255, green: 240/255, blue: 240/255))
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .onAppear {
            isAnimating = true
        }
    }
    
    private var defaultWidth: CGFloat? {
        switch variant {
        case .text, .rect, .image: return nil
        case .circle: return 48
        }
    }
    
    private var defaultHeight: CGFloat? {
        switch variant {
        case .text: return 16
        case .rect: return nil
        case .circle: return 48
        case .image: return 240
        }
    }
    
    private var cornerRadius: CGFloat {
        switch variant {
        case .text:
            return 4
        case .rect:
            return 8
        case .circle:
            return .infinity
        case .image:
            return 0
        }
    }
}
