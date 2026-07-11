import SwiftUI

public struct BizMonthPickerSheetModifier: ViewModifier {
    @Binding var isPresented: Bool
    var title: String?
    var config: CalendarConfig
    var initialDate: Date?
    var showActionButtons: Bool
    var onMonthSelected: ((MonthSelection) -> Void)?
    var onRangeSelected: ((MonthSelection?, MonthSelection?) -> Void)?
    var onYearChanged: ((Int) -> Void)?
    var onConfirm: ((MonthSelection?, MonthSelection?) -> Void)?
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
                BizMonthPicker(
                    config: config,
                    initialDate: initialDate ?? Date(),
                    showActionButtons: showActionButtons,
                    onMonthSelected: onMonthSelected,
                    onRangeSelected: onRangeSelected,
                    onYearChanged: onYearChanged,
                    onCancel: {
                        onCancel?()
                        isPresented = false
                    },
                    onConfirm: { start, end in
                        onConfirm?(start, end)
                        isPresented = false
                    }
                )
                .padding(.bottom, 24)
            }
        )
    }
}

public extension View {
    func bizMonthPickerSheet(
        isPresented: Binding<Bool>,
        title: String? = nil,
        config: CalendarConfig = CalendarConfig(),
        initialDate: Date? = nil,
        showActionButtons: Bool = true,
        onMonthSelected: ((MonthSelection) -> Void)? = nil,
        onRangeSelected: ((MonthSelection?, MonthSelection?) -> Void)? = nil,
        onYearChanged: ((Int) -> Void)? = nil,
        onConfirm: ((MonthSelection?, MonthSelection?) -> Void)? = nil,
        onCancel: (() -> Void)? = nil
    ) -> some View {
        self.modifier(BizMonthPickerSheetModifier(
            isPresented: isPresented,
            title: title,
            config: config,
            initialDate: initialDate,
            showActionButtons: showActionButtons,
            onMonthSelected: onMonthSelected,
            onRangeSelected: onRangeSelected,
            onYearChanged: onYearChanged,
            onConfirm: onConfirm,
            onCancel: onCancel
        ))
    }
}
