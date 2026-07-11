import SwiftUI

public struct BizSwipeItem<Content: View, LeftActions: View, RightActions: View>: View {
    var content: () -> Content
    var leftActions: (() -> LeftActions)?
    var rightActions: (() -> RightActions)?
    
    @State private var offset: CGFloat = 0
    @State private var leftWidth: CGFloat = 0
    @State private var rightWidth: CGFloat = 0
    @State private var isSwiping = false
    
    public init(
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder leftActions: @escaping () -> LeftActions,
        @ViewBuilder rightActions: @escaping () -> RightActions
    ) {
        self.content = content
        self.leftActions = leftActions
        self.rightActions = rightActions
    }
    
    public init(
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder rightActions: @escaping () -> RightActions
    ) where LeftActions == EmptyView {
        self.content = content
        self.leftActions = nil
        self.rightActions = rightActions
    }
    
    public init(
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder leftActions: @escaping () -> LeftActions
    ) where RightActions == EmptyView {
        self.content = content
        self.leftActions = leftActions
        self.rightActions = nil
    }
    
    public var body: some View {
        ZStack {
            HStack(spacing: 0) {
                if let left = leftActions {
                    left()
                        .background(GeometryReader { proxy in
                            Color.clear.preference(key: BizSwipeWidthKey.self, value: proxy.size.width)
                        })
                        .onPreferenceChange(BizSwipeWidthKey.self) { width in
                            leftWidth = width
                        }
                }
                Spacer()
                if let right = rightActions {
                    right()
                        .background(GeometryReader { proxy in
                            Color.clear.preference(key: BizSwipeWidthKey.self, value: proxy.size.width)
                        })
                        .onPreferenceChange(BizSwipeWidthKey.self) { width in
                            rightWidth = width
                        }
                }
            }
            
            content()
                .offset(x: offset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            isSwiping = true
                            let translation = value.translation.width
                            // Basic snapping/resistance logic
                            if translation > 0 && leftActions != nil {
                                offset = min(translation, leftWidth + (translation - leftWidth) * 0.2)
                            } else if translation < 0 && rightActions != nil {
                                offset = max(translation, -rightWidth + (translation + rightWidth) * 0.2)
                            } else {
                                offset = translation * 0.1
                            }
                        }
                        .onEnded { value in
                            isSwiping = false
                            let threshold: CGFloat = 40
                            withAnimation(.spring()) {
                                if offset > threshold && leftActions != nil {
                                    offset = leftWidth
                                } else if offset < -threshold && rightActions != nil {
                                    offset = -rightWidth
                                } else {
                                    offset = 0
                                }
                            }
                        }
                )
        }
        .clipped()
    }
}

struct BizSwipeWidthKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
