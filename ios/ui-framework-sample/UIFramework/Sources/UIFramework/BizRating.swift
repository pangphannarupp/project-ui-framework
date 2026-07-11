import SwiftUI

public struct BizRating: View {
    @Binding public var rating: Int
    public var max: Int
    public var readonly: Bool
    public var activeColor: Color
    public var inactiveColor: Color

    public init(
        rating: Binding<Int>,
        max: Int = 5,
        readonly: Bool = false,
        activeColor: Color = Color(hex: "#FFC107"),
        inactiveColor: Color = Color(hex: "#E0E0E0")
    ) {
        self._rating = rating
        self.max = max
        self.readonly = readonly
        self.activeColor = activeColor
        self.inactiveColor = inactiveColor
    }

    public var body: some View {
        HStack(spacing: 4) {
            ForEach(1...max, id: \.self) { index in
                Image(systemName: index <= rating ? "star.fill" : "star")
                    .foregroundColor(index <= rating ? activeColor : inactiveColor)
                    .font(.system(size: 24))
                    .onTapGesture {
                        if !readonly {
                            withAnimation {
                                rating = index
                            }
                        }
                    }
            }
        }
    }
}
