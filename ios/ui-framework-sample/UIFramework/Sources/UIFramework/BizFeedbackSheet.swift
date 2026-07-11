import SwiftUI

public struct BizFeedbackSheetModifier<CustomContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    var icon: String // "error", "success", "locked"
    var title: String
    var description: String?
    var buttonText: String
    var onAction: (() -> Void)?
    var customContent: (() -> CustomContent)?
    
    public func body(content: Content) -> some View {
        content.bizBottomSheet(
            isPresented: $isPresented,
            content: {
                VStack(spacing: 0) {
                    // Icon
                    ZStack {
                        if icon == "error" || icon == "locked" {
                            Circle()
                                .fill(Color(hex: "#FFEDED"))
                                .frame(width: 72, height: 72)
                            
                            Circle()
                                .fill(Color(hex: "#D93025"))
                                .frame(width: 48, height: 48)
                            
                            if icon == "error" {
                                Image(systemName: "shield.lefthalf.filled")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                            } else {
                                Image(systemName: "lock.shield.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                            }
                        } else if icon == "success" {
                            Circle()
                                .fill(Color(hex: "#E6F4EA"))
                                .frame(width: 72, height: 72)
                            
                            Circle()
                                .fill(Color(hex: "#1E8E3E"))
                                .frame(width: 48, height: 48)
                            
                            Image(systemName: "checkmark.shield.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.top, 8)
                    .padding(.bottom, 20)
                    
                    // Text
                    Text(title)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color(hex: "#1A2A5E"))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 10)
                    
                    if let desc = description {
                        Text(desc)
                            .font(.system(size: 13))
                            .foregroundColor(Color(hex: "#555555"))
                            .multilineTextAlignment(.center)
                            .lineSpacing(4)
                            .padding(.horizontal, 16)
                            .padding(.bottom, 24)
                    }
                    
                    if let customContent = customContent {
                        customContent()
                            .padding(.bottom, 24)
                    }
                    
                    // Action
                    BizButton(buttonText, variant: .primary, action: {
                        onAction?()
                        isPresented = false
                    })
                    .padding(.bottom, 32)
                }
                .padding(.horizontal, 24)
            }
        )
    }
}

public extension View {
    func bizFeedbackSheet<CustomContent: View>(
        isPresented: Binding<Bool>,
        icon: String = "error",
        title: String = "Action Required",
        description: String? = nil,
        buttonText: String = "Okay",
        onAction: (() -> Void)? = nil,
        @ViewBuilder customContent: @escaping () -> CustomContent
    ) -> some View {
        self.modifier(BizFeedbackSheetModifier(
            isPresented: isPresented,
            icon: icon,
            title: title,
            description: description,
            buttonText: buttonText,
            onAction: onAction,
            customContent: customContent
        ))
    }
    
    func bizFeedbackSheet(
        isPresented: Binding<Bool>,
        icon: String = "error",
        title: String = "Action Required",
        description: String? = nil,
        buttonText: String = "Okay",
        onAction: (() -> Void)? = nil
    ) -> some View {
        self.modifier(BizFeedbackSheetModifier<EmptyView>(
            isPresented: isPresented,
            icon: icon,
            title: title,
            description: description,
            buttonText: buttonText,
            onAction: onAction,
            customContent: nil
        ))
    }
}
