import SwiftUI

public struct BizSkeletonDetail: View {
    public var paragraphs: Int
    
    public init(paragraphs: Int = 3) {
        self.paragraphs = paragraphs
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            BizSkeletonItem(variant: .image)
            
            VStack(alignment: .leading, spacing: 24) {
                // Title & Meta
                VStack(alignment: .leading, spacing: 8) {
                    BizSkeletonItem(variant: .text, width: UIScreen.main.bounds.width * 0.75, height: 28)
                    
                    HStack(spacing: 16) {
                        BizSkeletonItem(variant: .text, width: UIScreen.main.bounds.width * 0.3, height: 12)
                        BizSkeletonItem(variant: .text, width: UIScreen.main.bounds.width * 0.2, height: 12)
                    }
                }
                
                // Paragraphs
                ForEach(0..<paragraphs, id: \.self) { _ in
                    VStack(alignment: .leading, spacing: 8) {
                        BizSkeletonItem(variant: .text, width: UIScreen.main.bounds.width - 32, height: 12)
                        BizSkeletonItem(variant: .text, width: (UIScreen.main.bounds.width - 32) * 0.95, height: 12)
                        BizSkeletonItem(variant: .text, width: (UIScreen.main.bounds.width - 32) * 0.98, height: 12)
                        BizSkeletonItem(variant: .text, width: (UIScreen.main.bounds.width - 32) * CGFloat.random(in: 0.4...0.8), height: 12)
                    }
                }
            }
            .padding(24)
        }
        .background(Color.white)
    }
}
