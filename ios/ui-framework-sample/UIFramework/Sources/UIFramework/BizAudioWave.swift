import SwiftUI

/**
 * BizAudioWave - SwiftUI component matching Web UI-Framework `PPAudioWave.vue`.
 */
public struct BizAudioWave: View {
    public var bars: Int
    public var action: () -> Void

    public init(
        bars: Int = 30,
        action: @escaping () -> Void = {}
    ) {
        self.bars = bars
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("AudioWave")
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
 * Web UI-Framework parity alias for [BizAudioWave].
 */
public typealias PPAudioWave = BizAudioWave
