import SwiftUI

public struct BizTimePickerSheetModifier: ViewModifier {
    @Binding var isPresented: Bool
    @Binding var timeValue: String
    var title: String?
    var showActionButtons: Bool
    var onChange: ((String) -> Void)?
    var onConfirm: ((String) -> Void)?
    var onCancel: (() -> Void)?
    
    public func body(content: Content) -> some View {
        content.bizBottomSheet(
            isPresented: $isPresented,
            header: {
                if let title = title {
                    Text(title)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color(hex: "#1A2A5E"))
                        .padding(.top, 8)
                } else {
                    EmptyView()
                }
            },
            footer: { EmptyView() },
            content: {
                BizTimePicker(
                    time: $timeValue,
                    showActionButtons: showActionButtons,
                    onCancel: {
                        onCancel?()
                        isPresented = false
                    },
                    onConfirm: { val in
                        onConfirm?(val)
                        isPresented = false
                    }
                )
                .padding(.bottom, 24)
            }
        )
    }
}

public extension View {
    func bizTimePickerSheet(
        isPresented: Binding<Bool>,
        timeValue: Binding<String>,
        title: String? = nil,
        showActionButtons: Bool = true,
        onChange: ((String) -> Void)? = nil,
        onConfirm: ((String) -> Void)? = nil,
        onCancel: (() -> Void)? = nil
    ) -> some View {
        self.modifier(BizTimePickerSheetModifier(
            isPresented: isPresented,
            timeValue: timeValue,
            title: title,
            showActionButtons: showActionButtons,
            onChange: onChange,
            onConfirm: onConfirm,
            onCancel: onCancel
        ))
    }
}
