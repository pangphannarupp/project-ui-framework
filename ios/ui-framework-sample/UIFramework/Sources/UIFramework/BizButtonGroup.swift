import SwiftUI

public struct BizButtonGroupIsVerticalKey: EnvironmentKey {
    public static let defaultValue: Bool? = nil
}

public extension EnvironmentValues {
    var bizButtonGroupIsVertical: Bool? {
        get { self[BizButtonGroupIsVerticalKey.self] }
        set { self[BizButtonGroupIsVerticalKey.self] = newValue }
    }
}

public struct BizButtonGroup<Content: View>: View {
    public var isVertical: Bool
    public var content: Content
    
    public init(isVertical: Bool = false, @ViewBuilder content: () -> Content) {
        self.isVertical = isVertical
        self.content = content()
    }
    
    public var body: some View {
        Group {
            if isVertical {
                VStack(spacing: 0) {
                    content
                }
            } else {
                HStack(spacing: 0) {
                    content
                }
            }
        }
        .environment(\.bizButtonGroupIsVertical, isVertical)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
