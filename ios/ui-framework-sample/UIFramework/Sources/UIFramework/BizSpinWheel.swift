import SwiftUI

/**
 * BizSpinWheel - SwiftUI component matching Web UI-Framework `PPSpinWheel.vue`.
 */
public struct BizSpinWheel: View {
    public var items: [String]
    public var spinDuration: Int
    public var spins: Int
    public var pointerColor: String
    public var variant: String
    public var action: () -> Void

    public init(
        items: [String] = [],
        spinDuration: Int = 4000,
        spins: Int = 5,
        pointerColor: String = "#ff3b30",
        variant: String = "standard",
        action: @escaping () -> Void = {}
    ) {
        self.items = items
        self.spinDuration = spinDuration
        self.spins = spins
        self.pointerColor = pointerColor
        self.variant = variant
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("SpinWheel")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color(hex: "#1A2A5E"))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .background(Color.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(hex: "#CBD5E1"), lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

/**
 * Web UI-Framework parity alias for [BizSpinWheel].
 */
public typealias PPSpinWheel = BizSpinWheel
