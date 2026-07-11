import SwiftUI

public struct BizCalendarAlertModifier: ViewModifier {
    @Binding var isPresented: Bool
    var config: CalendarConfig
    var initialDate: Date?
    var showActionButtons: Bool
    var dismissOnOverlayClick: Bool
    var onDateSelected: ((CalendarSelection) -> Void)?
    var onRangeSelected: ((CalendarSelection?, CalendarSelection?) -> Void)?
    var onMonthChanged: ((Int, Int) -> Void)?
    var onConfirm: ((CalendarSelection?, CalendarSelection?) -> Void)?
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
                    BizCalendar(
                        config: config,
                        initialDate: initialDate ?? Date(),
                        showActionButtons: showActionButtons,
                        onDateSelected: onDateSelected,
                        onRangeSelected: onRangeSelected,
                        onMonthChanged: onMonthChanged,
                        onConfirm: { start, end in
                            onConfirm?(start, end)
                            isPresented = false
                        },
                        onCancel: {
                            onCancel?()
                            isPresented = false
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
    func bizCalendarAlert(
        isPresented: Binding<Bool>,
        config: CalendarConfig = CalendarConfig(),
        initialDate: Date? = nil,
        showActionButtons: Bool = true,
        dismissOnOverlayClick: Bool = true,
        onDateSelected: ((CalendarSelection) -> Void)? = nil,
        onRangeSelected: ((CalendarSelection?, CalendarSelection?) -> Void)? = nil,
        onMonthChanged: ((Int, Int) -> Void)? = nil,
        onConfirm: ((CalendarSelection?, CalendarSelection?) -> Void)? = nil,
        onCancel: (() -> Void)? = nil
    ) -> some View {
        self.modifier(BizCalendarAlertModifier(
            isPresented: isPresented,
            config: config,
            initialDate: initialDate,
            showActionButtons: showActionButtons,
            dismissOnOverlayClick: dismissOnOverlayClick,
            onDateSelected: onDateSelected,
            onRangeSelected: onRangeSelected,
            onMonthChanged: onMonthChanged,
            onConfirm: onConfirm,
            onCancel: onCancel
        ))
    }
}
