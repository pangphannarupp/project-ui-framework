import SwiftUI

public struct BizPinDots: View {
    public var length: Int
    public var value: String
    public var error: Bool
    public var errorText: String
    public var success: Bool
    
    @State private var shakeOffset: CGFloat = 0
    @State private var successScale: CGFloat = 1.0
    
    public init(
        length: Int = 6,
        value: String = "",
        error: Bool = false,
        errorText: String = "PIN does not match. Please try again.",
        success: Bool = false
    ) {
        self.length = length
        self.value = value
        self.error = error
        self.errorText = errorText
        self.success = success
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                ForEach(0..<length, id: \.self) { index in
                    PinDot(
                        isFilled: index < value.count,
                        isError: error,
                        isSuccess: success,
                        delay: Double(index) * 0.05
                    )
                }
            }
            .offset(x: shakeOffset)
            .onChange(of: error) { isError in
                if isError {
                    triggerShake()
                }
            }
            
            if error && !errorText.isEmpty {
                HStack(spacing: 6) {
                    Image(systemName: "exclamationmark.circle")
                        .font(.system(size: 14))
                    Text(errorText)
                        .font(.system(size: 13, weight: .medium))
                }
                .foregroundColor(Color(hex: "#FF4D4F"))
            }
        }
    }
    
    private func triggerShake() {
        withAnimation(.linear(duration: 0.1).repeatCount(4, autoreverses: true)) {
            shakeOffset = 8
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            shakeOffset = 0
        }
    }
}

private struct PinDot: View {
    var isFilled: Bool
    var isError: Bool
    var isSuccess: Bool
    var delay: Double
    
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        Circle()
            .fill(fillColor)
            .overlay(
                Circle().stroke(strokeColor, lineWidth: 1.5)
            )
            .frame(width: 16, height: 16)
            .scaleEffect(scale)
            .onChange(of: isSuccess) { success in
                if success {
                    triggerSuccessAnimation()
                }
            }
    }
    
    private var fillColor: Color {
        if isError && isFilled { return Color(hex: "#FF4D4F") }
        if isSuccess { return Color(hex: "#52C41A") }
        if isFilled { return Color(hex: "#003399") }
        return Color.clear
    }
    
    private var strokeColor: Color {
        if isError { return Color(hex: "#FF4D4F") }
        if isSuccess { return Color(hex: "#52C41A") }
        return Color(hex: "#003399")
    }
    
    private func triggerSuccessAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            withAnimation(.easeInOut(duration: 0.2)) {
                scale = 1.25
            }
            withAnimation(.easeInOut(duration: 0.2).delay(0.2)) {
                scale = 1.0
            }
        }
    }
}
