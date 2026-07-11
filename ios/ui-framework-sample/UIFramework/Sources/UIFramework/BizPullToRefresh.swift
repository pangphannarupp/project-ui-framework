import SwiftUI

public struct BizPullToRefresh<Content: View>: View {
    var content: () -> Content
    var onRefresh: () async -> Void
    
    @State private var pullDistance: CGFloat = 0
    @State private var isRefreshing = false
    
    private let threshold: CGFloat = 60
    private let maxPull: CGFloat = 100
    
    public init(
        onRefresh: @escaping () async -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.onRefresh = onRefresh
        self.content = content
    }
    
    public var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                VStack(spacing: 0) {
                    GeometryReader { proxy in
                        Color.clear.preference(
                            key: BizPullOffsetPreferenceKey.self,
                            value: proxy.frame(in: .named("pull_scroll")).minY
                        )
                    }
                    .frame(height: 0)
                    
                    content()
                }
            }
            .coordinateSpace(name: "pull_scroll")
            .onPreferenceChange(BizPullOffsetPreferenceKey.self) { minY in
                guard !isRefreshing else { return }
                
                if minY > 0 {
                    pullDistance = min(minY * 0.5, maxPull)
                } else {
                    pullDistance = 0
                }
            }
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onEnded { _ in
                        if pullDistance >= threshold && !isRefreshing {
                            Task {
                                await startRefresh()
                            }
                        }
                    }
            )
            
            // Indicator
            if pullDistance > 0 || isRefreshing {
                let height = isRefreshing ? threshold : pullDistance
                let progress = min(pullDistance / threshold, 1.0)
                
                VStack {
                    Spacer()
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 32, height: 32)
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                        
                        if isRefreshing {
                            ProgressView()
                        } else {
                            Image(systemName: "arrow.down")
                                .foregroundColor(Color(red: 26/255, green: 42/255, blue: 94/255))
                                .rotationEffect(.degrees(progress >= 1 ? 180 : 0))
                                .animation(.easeOut(duration: 0.2), value: progress)
                        }
                    }
                    .opacity(progress)
                    .padding(.bottom, 14)
                }
                .frame(height: height)
                .frame(maxWidth: .infinity)
                .animation(isRefreshing ? .easeOut(duration: 0.3) : .none, value: height)
            }
        }
    }
    
    @MainActor
    private func startRefresh() async {
        isRefreshing = true
        withAnimation(.easeOut(duration: 0.3)) {
            pullDistance = threshold
        }
        
        await onRefresh()
        
        withAnimation(.easeOut(duration: 0.3)) {
            isRefreshing = false
            pullDistance = 0
        }
    }
}

public struct BizPullOffsetPreferenceKey: PreferenceKey {
    public static var defaultValue: CGFloat = 0
    public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
