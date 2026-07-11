import SwiftUI

public struct BizHideAppBar<Header: View, Content: View>: View {
    var headerHeight: CGFloat
    var header: () -> Header
    var content: () -> Content
    
    @State private var headerOffset: CGFloat = 0
    @State private var lastScrollOffset: CGFloat = 0
    @State private var isInitialScroll: Bool = true
    
    public init(
        headerHeight: CGFloat = 56,
        @ViewBuilder header: @escaping () -> Header,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.headerHeight = headerHeight
        self.header = header
        self.content = content
    }
    
    public var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                VStack(spacing: 0) {
                    Spacer().frame(height: headerHeight)
                    
                    GeometryReader { proxy in
                        Color.clear.preference(key: BizScrollOffsetPreferenceKey.self, value: proxy.frame(in: .named("biz_scroll")).minY)
                    }
                    .frame(height: 0)
                    
                    content()
                }
            }
            .coordinateSpace(name: "biz_scroll")
            .onPreferenceChange(BizScrollOffsetPreferenceKey.self) { currentScrollOffset in
                if isInitialScroll {
                    lastScrollOffset = currentScrollOffset
                    isInitialScroll = false
                    return
                }
                
                let delta = currentScrollOffset - lastScrollOffset
                
                if currentScrollOffset > headerHeight {
                    // Pulling down past top (elastic bounce)
                    headerOffset = 0
                } else if delta > 0 {
                    // Scrolling up (content goes down) -> Show Header
                    headerOffset = min(0, headerOffset + delta)
                } else if delta < 0 {
                    // Scrolling down (content goes up) -> Hide Header
                    headerOffset = max(-headerHeight, headerOffset + delta)
                }
                
                lastScrollOffset = currentScrollOffset
            }
            
            header()
                .frame(height: headerHeight)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 2)
                .offset(y: headerOffset)
                .zIndex(1)
        }
        .background(Color(red: 244/255, green: 245/255, blue: 248/255))
    }
}

public struct BizScrollOffsetPreferenceKey: PreferenceKey {
    public static var defaultValue: CGFloat = 0
    public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
