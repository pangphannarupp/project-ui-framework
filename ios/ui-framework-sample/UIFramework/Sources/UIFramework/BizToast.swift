import SwiftUI

public struct BizToastModifier: ViewModifier {
    @Binding var isPresented: Bool
    let message: String
    let duration: TimeInterval
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            
            if isPresented {
                VStack {
                    Spacer()
                    
                    HStack(spacing: 8) {
                        Image(systemName: "info.circle")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                        
                        Text(message)
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .medium))
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(Color(hex: "#D92D20"))
                    .clipShape(Capsule())
                    .shadow(color: Color.black.opacity(0.15), radius: 12, x: 0, y: 4)
                    .padding(.bottom, 80)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                            withAnimation {
                                isPresented = false
                            }
                        }
                    }
                }
                .zIndex(9999)
            }
        }
    }
}

public extension View {
    func bizToast(isPresented: Binding<Bool>, message: String, duration: TimeInterval = 3.0) -> some View {
        self.modifier(BizToastModifier(isPresented: isPresented, message: message, duration: duration))
    }
}
