import SwiftUI

public struct BizTimePickerAlertModifier: ViewModifier {
    @Binding var isPresented: Bool
    @Binding var timeValue: String
    var title: String?
    var dismissOnOverlayClick: Bool
    var onConfirm: ((String) -> Void)?
    var onCancel: (() -> Void)?
    
    @State private var internalTime = ""
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            
            if isPresented {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        if dismissOnOverlayClick {
                            isPresented = false
                        }
                    }
                    .transition(.opacity)
                    .zIndex(1)
                
                VStack(spacing: 0) {
                    if let title = title {
                        Text(title)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Color(hex: "#333333"))
                            .padding(.top, 20)
                            .padding(.bottom, 10)
                    }
                    
                    BizTimePicker(
                        time: $internalTime,
                        showActionButtons: false
                    )
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                    
                    HStack(spacing: 0) {
                        Button(action: {
                            onCancel?()
                            isPresented = false
                        }) {
                            Text("Cancel")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color(hex: "#999999"))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        
                        Divider()
                            .background(Color(hex: "#EEEEEE"))
                        
                        Button(action: {
                            timeValue = internalTime
                            onConfirm?(internalTime)
                            isPresented = false
                        }) {
                            Text("OK")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color(hex: "#007AFF"))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    }
                    .frame(height: 52)
                    .background(Color.white)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color(hex: "#EEEEEE")),
                        alignment: .top
                    )
                }
                .background(Color.white)
                .cornerRadius(16)
                .frame(maxWidth: 340)
                .shadow(color: Color.black.opacity(0.15), radius: 32, x: 0, y: 12)
                .transition(.scale(scale: 0.9).combined(with: .opacity))
                .zIndex(2)
                .onAppear {
                    internalTime = timeValue
                }
                .onChange(of: timeValue) { newValue in
                    internalTime = newValue
                }
            }
        }
    }
}

public extension View {
    func bizTimePickerAlert(
        isPresented: Binding<Bool>,
        timeValue: Binding<String>,
        title: String? = nil,
        dismissOnOverlayClick: Bool = true,
        onConfirm: ((String) -> Void)? = nil,
        onCancel: (() -> Void)? = nil
    ) -> some View {
        self.modifier(BizTimePickerAlertModifier(
            isPresented: isPresented,
            timeValue: timeValue,
            title: title,
            dismissOnOverlayClick: dismissOnOverlayClick,
            onConfirm: onConfirm,
            onCancel: onCancel
        ))
    }
}
