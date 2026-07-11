import SwiftUI

public struct BizConfirmSheetModifier: ViewModifier {
    @Binding var isPresented: Bool
    var title: String
    var subtitle: String?
    var confirmText: String?
    var cancelText: String?
    var onConfirm: (() -> Void)?
    
    public func body(content: Content) -> some View {
        content.bizBottomSheet(
            isPresented: $isPresented,
            header: { EmptyView() },
            footer: {
                VStack(spacing: 16) {
                    if let confirm = confirmText {
                        BizButton(confirm, variant: .outline, action: {
                            // Vue uses outline-danger, but BizButton might not have danger variant yet. Using primary or outline.
                            // We will use standard action
                            onConfirm?()
                        })
                    }
                    if let cancel = cancelText {
                        BizButton(cancel, variant: .outline, action: {
                            isPresented = false
                        })
                    }
                }
            },
            content: {
                VStack(spacing: 0) {
                    // Warning Icon matching the Vue implementation
                    ZStack {
                        Circle()
                            .fill(Color(hex: "#FFF8E6"))
                            .frame(width: 90, height: 90)
                        
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(Color(hex: "#F5A623"))
                    }
                    .padding(.bottom, 24)
                    
                    Text(title)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color(hex: "#1A2A5E"))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 8)
                    
                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(.system(size: 15))
                            .foregroundColor(Color(hex: "#666666"))
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 16) // Padding before footer takes over
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
            }
        )
    }
}

public extension View {
    func bizConfirmSheet(
        isPresented: Binding<Bool>,
        title: String,
        subtitle: String? = nil,
        confirmText: String? = "Confirm",
        cancelText: String? = "Cancel",
        onConfirm: (() -> Void)? = nil
    ) -> some View {
        self.modifier(BizConfirmSheetModifier(
            isPresented: isPresented,
            title: title,
            subtitle: subtitle,
            confirmText: confirmText,
            cancelText: cancelText,
            onConfirm: onConfirm
        ))
    }
}
