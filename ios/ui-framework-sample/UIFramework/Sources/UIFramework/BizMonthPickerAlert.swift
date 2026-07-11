import SwiftUI

public struct BizMonthPickerAlertModifier: ViewModifier {
    @Binding var isPresented: Bool
    var config: CalendarConfig
    var initialDate: Date?
    var showActionButtons: Bool
    var dismissOnOverlayClick: Bool
    var onMonthSelected: ((MonthSelection) -> Void)?
    var onRangeSelected: ((MonthSelection?, MonthSelection?) -> Void)?
    var onYearChanged: ((Int) -> Void)?
    var onConfirm: ((MonthSelection?, MonthSelection?) -> Void)?
    var onCancel: (() -> Void)?
    
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
                
                VStack {
                    BizMonthPicker(
                        config: config,
                        initialDate: initialDate ?? Date(),
                        showActionButtons: showActionButtons,
                        onMonthSelected: onMonthSelected,
                        onRangeSelected: onRangeSelected,
                        onYearChanged: onYearChanged,
                        onCancel: {
                            isPresented = false
                            onCancel?()
                        },
                        onConfirm: { sel1, sel2 in
                            isPresented = false
                            onConfirm?(sel1, sel2)
                        }
                    )
                    .background(Color.white)
                    .cornerRadius(16)
                    .padding(16)
                    .shadow(color: Color.black.opacity(0.15), radius: 32, x: 0, y: 12)
                }
                .frame(maxWidth: 400)
                .transition(.scale(scale: 0.9).combined(with: .opacity))
                .zIndex(2)
            }
        }
    }
}

public extension View {
    func bizMonthPickerAlert(
        isPresented: Binding<Bool>,
        config: CalendarConfig = CalendarConfig(),
        initialDate: Date? = nil,
        showActionButtons: Bool = true,
        dismissOnOverlayClick: Bool = true,
        onMonthSelected: ((MonthSelection) -> Void)? = nil,
        onRangeSelected: ((MonthSelection?, MonthSelection?) -> Void)? = nil,
        onYearChanged: ((Int) -> Void)? = nil,
        onConfirm: ((MonthSelection?, MonthSelection?) -> Void)? = nil,
        onCancel: (() -> Void)? = nil
    ) -> some View {
        self.modifier(BizMonthPickerAlertModifier(
            isPresented: isPresented,
            config: config,
            initialDate: initialDate,
            showActionButtons: showActionButtons,
            dismissOnOverlayClick: dismissOnOverlayClick,
            onMonthSelected: onMonthSelected,
            onRangeSelected: onRangeSelected,
            onYearChanged: onYearChanged,
            onConfirm: onConfirm,
            onCancel: onCancel
        ))
    }
}
