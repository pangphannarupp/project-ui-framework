import SwiftUI

public struct BizBiometricSheetModifier: ViewModifier {
    @Binding var isPresented: Bool
    var type: String // "both", "face", "fingerprint"
    var onSetup: ((String) -> Void)?
    var onLater: (() -> Void)?
    
    public func body(content: Content) -> some View {
        content.bizBottomSheet(
            isPresented: $isPresented,
            content: {
                VStack(spacing: 0) {
                    // Shield Icon
                    ZStack {
                        Circle()
                            .fill(Color(hex: "#E6F0FF"))
                            .frame(width: 72, height: 72)
                        
                        Circle()
                            .fill(Color(hex: "#003399"))
                            .frame(width: 48, height: 48)
                        
                        Image(systemName: "checkmark.shield.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                    }
                    .padding(.top, 8)
                    .padding(.bottom, 24)
                    
                    // Text
                    Text("Unlock faster with \(titleName)")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color(hex: "#1A2A5E"))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 12)
                    
                    Text("Skip PIN entry and securely access your account using \(subtitleName).")
                        .font(.system(size: 13))
                        .foregroundColor(Color(hex: "#555555"))
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 32)
                    
                    // Cards
                    ZStack {
                        HStack(spacing: 16) {
                            if type == "both" || type == "face" {
                                BiometricCard(
                                    icon: "faceid",
                                    title: "Face ID",
                                    desc: "Use facial recognition"
                                )
                            }
                            
                            if type == "both" || type == "fingerprint" {
                                BiometricCard(
                                    icon: "touchid",
                                    title: "Fingerprint ID",
                                    desc: "Use your fingerprint"
                                )
                            }
                        }
                        
                        if type == "both" {
                            Circle()
                                .fill(Color(hex: "#F8F9FA"))
                                .frame(width: 32, height: 32)
                                .shadow(color: Color.black.opacity(0.06), radius: 4, x: 0, y: 2)
                                .overlay(
                                    Text("Or")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(Color(hex: "#1A2A5E"))
                                )
                        }
                    }
                    .padding(.bottom, 32)
                    
                    // Info Banner
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(Color(hex: "#0066CC"))
                            .font(.system(size: 20))
                            .padding(.top, 2)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Face / Fingerprint ID")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(Color(hex: "#1A2A5E"))
                            
                            Text("Link your Face or Fingerprint ID for quick and easy access to your account. Enjoy seamless logins and hassle-free payments by setting it up now.")
                                .font(.system(size: 11))
                                .foregroundColor(Color(hex: "#666666"))
                                .lineSpacing(2)
                        }
                    }
                    .padding(.bottom, 32)
                    
                    // Actions
                    VStack(spacing: 12) {
                        BizButton("Set \(buttonName) ID", variant: .primary, action: {
                            onSetup?(type)
                            isPresented = false
                        })
                        
                        BizButton("Maybe Later", variant: .outline, action: {
                            onLater?()
                            isPresented = false
                        })
                    }
                    .padding(.bottom, 32)
                }
                .padding(.horizontal, 24)
            }
        )
    }
    
    private var titleName: String {
        if type == "both" { return "Biometrics" }
        if type == "face" { return "Face ID" }
        return "Fingerprint ID"
    }
    
    private var subtitleName: String {
        if type == "both" { return "Face ID or Fingerprint" }
        if type == "face" { return "Face ID" }
        return "Fingerprint"
    }
    
    private var buttonName: String {
        if type == "both" { return "Biometrics" }
        if type == "face" { return "Face" }
        return "Fingerprint"
    }
}

private struct BiometricCard: View {
    let icon: String
    let title: String
    let desc: String
    
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: icon)
                .font(.system(size: 40))
                .foregroundColor(Color(hex: "#0066CC"))
                .padding(.bottom, 16)
            
            Text(title)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(Color(hex: "#1A2A5E"))
                .padding(.bottom, 6)
            
            Text(desc)
                .font(.system(size: 11))
                .foregroundColor(Color(hex: "#777777"))
                .multilineTextAlignment(.center)
                .lineSpacing(2)
        }
        .padding(.vertical, 24)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(hex: "#EAEAEA"), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.03), radius: 6, x: 0, y: 4)
    }
}

public extension View {
    func bizBiometricSheet(
        isPresented: Binding<Bool>,
        type: String = "both",
        onSetup: ((String) -> Void)? = nil,
        onLater: (() -> Void)? = nil
    ) -> some View {
        self.modifier(BizBiometricSheetModifier(
            isPresented: isPresented,
            type: type,
            onSetup: onSetup,
            onLater: onLater
        ))
    }
}
