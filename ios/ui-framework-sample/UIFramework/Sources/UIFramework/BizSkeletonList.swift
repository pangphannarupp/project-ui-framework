import SwiftUI

public struct BizSkeletonList: View {
    public var count: Int
    public var avatar: Bool
    
    public init(count: Int = 5, avatar: Bool = true) {
        self.count = count
        self.avatar = avatar
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<count, id: \.self) { _ in
                HStack(spacing: 16) {
                    if avatar {
                        BizSkeletonItem(variant: .circle, width: 48, height: 48)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        BizSkeletonItem(variant: .text, width: randomWidth(min: 40, max: 70), height: 16)
                        BizSkeletonItem(variant: .text, width: randomWidth(min: 60, max: 90), height: 12)
                    }
                }
                .padding(16)
                .background(Color.white)
                
                Divider().padding(.leading, avatar ? 80 : 16)
            }
        }
    }
    
    private func randomWidth(min: CGFloat, max: CGFloat) -> CGFloat {
        // Returns a percentage width approximation, we'll use a GeometryReader for actual percentage or just hardcode some fixed widths
        // Actually, since we don't know the exact parent width, we can use a relative frame with GeometryReader, or just use a fixed rough size.
        // Let's use an exact pixel width as a fallback, or we can use fixed numbers between 120 and 200 for simplicity.
        return CGFloat.random(in: min...max) * 3 // Roughly 120-270px
    }
}
