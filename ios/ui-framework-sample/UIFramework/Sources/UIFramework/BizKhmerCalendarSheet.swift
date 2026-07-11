import SwiftUI

public struct BizKhmerCalendarSheetModifier: ViewModifier {
    @Binding var isPresented: Bool
    var title: String?
    var config: CalendarConfig
    var initialDate: Date?
    var showActionButtons: Bool
    var onDateSelected: ((KhmerCalendarSelection) -> Void)?
    var onRangeSelected: ((KhmerCalendarSelection?, KhmerCalendarSelection?) -> Void)?
    var onMonthChanged: ((Int, Int) -> Void)?
    var onConfirm: ((KhmerCalendarSelection?, KhmerCalendarSelection?) -> Void)?
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
                BizKhmerCalendar(
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
                .padding(.bottom, 24)
            }
        )
    }
}

public extension View {
    func bizKhmerCalendarSheet(
        isPresented: Binding<Bool>,
        title: String? = nil,
        config: CalendarConfig = CalendarConfig(),
        initialDate: Date? = nil,
        showActionButtons: Bool = true,
        onDateSelected: ((KhmerCalendarSelection) -> Void)? = nil,
        onRangeSelected: ((KhmerCalendarSelection?, KhmerCalendarSelection?) -> Void)? = nil,
        onMonthChanged: ((Int, Int) -> Void)? = nil,
        onConfirm: ((KhmerCalendarSelection?, KhmerCalendarSelection?) -> Void)? = nil,
        onCancel: (() -> Void)? = nil
    ) -> some View {
        self.modifier(BizKhmerCalendarSheetModifier(
            isPresented: isPresented,
            title: title,
            config: config,
            initialDate: initialDate,
            showActionButtons: showActionButtons,
            onDateSelected: onDateSelected,
            onRangeSelected: onRangeSelected,
            onMonthChanged: onMonthChanged,
            onConfirm: onConfirm,
            onCancel: onCancel
        ))
    }
}
