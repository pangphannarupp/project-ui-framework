import SwiftUI

/// A custom collapsing toolbar implementation for SwiftUI.
/// This mimics the behavior of a web-like collapsing header or Android's CollapsingToolbar.
public struct BizCollapsingToolbar<Content: View, Header: View>: View {
    private let title: String
    private let collapsedHeight: CGFloat
    private let expandedHeight: CGFloat
    private let header: Header
    private let content: Content
    private let onBackClick: (() -> Void)?
    
    public init(
        title: String,
        collapsedHeight: CGFloat = 44,
        expandedHeight: CGFloat = 200,
        onBackClick: (() -> Void)? = nil,
        @ViewBuilder header: () -> Header,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.collapsedHeight = collapsedHeight
        self.expandedHeight = expandedHeight
        self.onBackClick = onBackClick
        self.header = header()
        self.content = content()
    }
    
    public var body: some View {
        GeometryReader { geometry in
            let safeAreaTop = geometry.safeAreaInsets.top
            let minHeight = collapsedHeight + safeAreaTop
            
            ScrollView {
                VStack(spacing: 0) {
                    GeometryReader { headerGeometry in
                        let scrollOffset = headerGeometry.frame(in: .global).minY
                        let height = max(minHeight, expandedHeight + scrollOffset)
                        // Calculate opacity based on how close we are to minHeight
                        let opacityRange = expandedHeight - minHeight
                        let currentProgress = (height - minHeight) / opacityRange
                        let titleOpacity = 1.0 - Double(currentProgress)
                        
                        ZStack(alignment: .bottomLeading) {
                            header
                                .frame(width: geometry.size.width, height: height)
                                .clipped()
                            
                            // Collapsed App Bar Overlay
                            HStack {
                                if let onBackClick = onBackClick {
                                    Button(action: onBackClick) {
                                        Image(systemName: "chevron.left")
                                            .font(.system(size: 20, weight: .semibold))
                                            .foregroundColor(.primary)
                                            .padding()
                                    }
                                }
                                Text(title)
                                    .font(.headline)
                                    .opacity(titleOpacity)
                                Spacer()
                            }
                            .frame(height: collapsedHeight)
                            .padding(.top, safeAreaTop)
                            .background(
                                Color(UIColor.systemBackground)
                                    .opacity(titleOpacity)
                                    .shadow(radius: titleOpacity > 0.8 ? 2 : 0)
                            )
                            .frame(maxHeight: .infinity, alignment: .top)
                        }
                        .frame(width: geometry.size.width, height: height)
                        .offset(y: -scrollOffset) // Keep header at the top
                    }
                    .frame(height: expandedHeight) // Initial reserved space
                    .zIndex(1)
                    
                    content
                        .background(Color(UIColor.systemBackground))
                        .zIndex(0)
                }
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}
