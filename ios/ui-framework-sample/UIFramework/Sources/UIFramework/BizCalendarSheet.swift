import SwiftUI

public struct BizCalendarSheetModifier: ViewModifier {
    @Binding var isPresented: Bool
    var title: String?
    var config: CalendarConfig
    var initialDate: Date?
    var showActionButtons: Bool
    var onDateSelected: ((CalendarSelection) -> Void)?
    var onRangeSelected: ((CalendarSelection?, CalendarSelection?) -> Void)?
    var onMonthChanged: ((Int, Int) -> Void)?
    var onConfirm: ((CalendarSelection?, CalendarSelection?) -> Void)?
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
                .padding(.bottom, 24)
            }
        )
    }
}

public extension View {
    func bizCalendarSheet(
        isPresented: Binding<Bool>,
        title: String? = nil,
        config: CalendarConfig = CalendarConfig(),
        initialDate: Date? = nil,
        showActionButtons: Bool = true,
        onDateSelected: ((CalendarSelection) -> Void)? = nil,
        onRangeSelected: ((CalendarSelection?, CalendarSelection?) -> Void)? = nil,
        onMonthChanged: ((Int, Int) -> Void)? = nil,
        onConfirm: ((CalendarSelection?, CalendarSelection?) -> Void)? = nil,
        onCancel: (() -> Void)? = nil
    ) -> some View {
        self.modifier(BizCalendarSheetModifier(
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
