import SwiftUI

public struct MonthSelection: Equatable {
    public var year: Int
    public var month: Int // 1-12
    
    public init(year: Int, month: Int) {
        self.year = year
        self.month = month
    }
}

public struct BizMonthPicker: View {
    public var config: CalendarConfig
    public var initialDate: Date
    public var showActionButtons: Bool
    public var onMonthSelected: ((MonthSelection) -> Void)?
    public var onRangeSelected: ((MonthSelection?, MonthSelection?) -> Void)?
    public var onYearChanged: ((Int) -> Void)?
    public var onCancel: (() -> Void)?
    public var onConfirm: ((MonthSelection?, MonthSelection?) -> Void)?
    
    @State private var currentYear: Int
    @State private var selectedMonth: MonthSelection?
    @State private var rangeStartMonth: MonthSelection?
    @State private var rangeEndMonth: MonthSelection?
    
    private let monthNames = [
        "Jan", "Feb", "Mar", "Apr", "May", "Jun",
        "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ]
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    public init(
        config: CalendarConfig = CalendarConfig(),
        initialDate: Date = Date(),
        showActionButtons: Bool = false,
        onMonthSelected: ((MonthSelection) -> Void)? = nil,
        onRangeSelected: ((MonthSelection?, MonthSelection?) -> Void)? = nil,
        onYearChanged: ((Int) -> Void)? = nil,
        onCancel: (() -> Void)? = nil,
        onConfirm: ((MonthSelection?, MonthSelection?) -> Void)? = nil
    ) {
        self.config = config
        self.initialDate = initialDate
        self.showActionButtons = showActionButtons
        self.onMonthSelected = onMonthSelected
        self.onRangeSelected = onRangeSelected
        self.onYearChanged = onYearChanged
        self.onCancel = onCancel
        self.onConfirm = onConfirm
        
        let cal = Calendar.current
        _currentYear = State(initialValue: cal.component(.year, from: initialDate))
        _selectedMonth = State(initialValue: MonthSelection(
            year: cal.component(.year, from: initialDate),
            month: cal.component(.month, from: initialDate)
        ))
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            headerView
            
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(1...12, id: \.self) { monthIndex in
                    monthCell(for: monthIndex)
                }
            }
            .padding(.top, 16)
            
            if showActionButtons {
                actionsView
            }
        }
        .padding(16)
        .background(Color.white)
        .onChange(of: initialDate) { newDate in
            let cal = Calendar.current
            currentYear = cal.component(.year, from: newDate)
            selectedMonth = MonthSelection(year: currentYear, month: cal.component(.month, from: newDate))
        }
    }
    
    private var headerView: some View {
        HStack {
            Text("\(String(currentYear))")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(Color(red: 26/255, green: 42/255, blue: 94/255))
            
            Spacer()
            
            HStack(spacing: 8) {
                Button(action: {
                    currentYear -= 1
                    onYearChanged?(currentYear)
                }) {
                    Image(systemName: "chevron.left")
                        .frame(width: 32, height: 32)
                        .foregroundColor(Color(red: 26/255, green: 42/255, blue: 94/255))
                }
                
                Button(action: {
                    currentYear = Calendar.current.component(.year, from: Date())
                    onYearChanged?(currentYear)
                }) {
                    Image(systemName: "calendar")
                        .frame(width: 32, height: 32)
                        .foregroundColor(Color(red: 0, green: 51/255, blue: 153/255))
                }
                
                Button(action: {
                    currentYear += 1
                    onYearChanged?(currentYear)
                }) {
                    Image(systemName: "chevron.right")
                        .frame(width: 32, height: 32)
                        .foregroundColor(Color(red: 26/255, green: 42/255, blue: 94/255))
                }
            }
        }
    }
    
    private func monthCell(for monthIndex: Int) -> some View {
        let m = MonthSelection(year: currentYear, month: monthIndex)
        let isEn = isEnabled(month: m)
        let isSel = isSelected(month: m)
        let isRangeStart = self.isRangeStart(month: m)
        let isRangeEnd = self.isRangeEnd(month: m)
        let inRange = isInRange(month: m)
        let isCur = isCurrent(month: m)
        
        return Button(action: {
            if isEn { onMonthClick(month: m) }
        }) {
            ZStack {
                // Background for range
                if inRange {
                    Color(red: 255/255, green: 77/255, blue: 79/255, opacity: 0.1)
                } else if isRangeStart && rangeEndMonth != nil {
                    HStack(spacing: 0) {
                        Color.clear.frame(maxWidth: .infinity)
                        Color(red: 255/255, green: 77/255, blue: 79/255, opacity: 0.1).frame(maxWidth: .infinity)
                    }
                } else if isRangeEnd && rangeStartMonth != nil {
                    HStack(spacing: 0) {
                        Color(red: 255/255, green: 77/255, blue: 79/255, opacity: 0.1).frame(maxWidth: .infinity)
                        Color.clear.frame(maxWidth: .infinity)
                    }
                }
                
                // Content
                Text(monthNames[monthIndex - 1])
                    .font(.system(size: 15, weight: .medium))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.vertical, 14)
                    .background(isSel ? Color.red : Color.clear)
                    .foregroundColor(isSel ? .white : (isCur ? .red : Color(red: 26/255, green: 42/255, blue: 94/255)))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isCur && !isSel ? Color.red : Color.clear, lineWidth: 1)
                    )
            }
        }
        .buttonStyle(PlainButtonStyle())
        .opacity(isEn ? 1.0 : 0.3)
        .disabled(!isEn)
    }
    
    private var actionsView: some View {
        HStack(spacing: 12) {
            Spacer()
            Button(action: {
                onCancel?()
            }) {
                Text("Cancel")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color(red: 102/255, green: 102/255, blue: 102/255))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color(red: 244/255, green: 245/255, blue: 248/255))
                    .cornerRadius(8)
            }
            
            Button(action: {
                if config.selectionMode == .single {
                    onConfirm?(selectedMonth, nil)
                } else {
                    onConfirm?(rangeStartMonth, rangeEndMonth)
                }
            }) {
                Text("Confirm")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color(red: 0, green: 51/255, blue: 153/255))
                    .cornerRadius(8)
            }
        }
        .padding(.top, 16)
    }
    
    // MARK: - Logic
    
    private func isEnabled(month: MonthSelection) -> Bool {
        if let min = config.minDate {
            let cal = Calendar.current
            let minYear = cal.component(.year, from: min)
            let minMonth = cal.component(.month, from: min)
            if month.year < minYear || (month.year == minYear && month.month < minMonth) {
                return false
            }
        }
        if let max = config.maxDate {
            let cal = Calendar.current
            let maxYear = cal.component(.year, from: max)
            let maxMonth = cal.component(.month, from: max)
            if month.year > maxYear || (month.year == maxYear && month.month > maxMonth) {
                return false
            }
        }
        return true
    }
    
    private func isSelected(month: MonthSelection) -> Bool {
        if config.selectionMode == .single {
            return isSameMonth(selectedMonth, month)
        }
        return isSameMonth(rangeStartMonth, month) || isSameMonth(rangeEndMonth, month)
    }
    
    private func isRangeStart(month: MonthSelection) -> Bool {
        if config.selectionMode == .single { return false }
        return isSameMonth(rangeStartMonth, month)
    }
    
    private func isRangeEnd(month: MonthSelection) -> Bool {
        if config.selectionMode == .single { return false }
        return isSameMonth(rangeEndMonth, month)
    }
    
    private func isInRange(month: MonthSelection) -> Bool {
        if config.selectionMode == .single { return false }
        guard let s = rangeStartMonth, let e = rangeEndMonth else { return false }
        return isMonthAfter(month, s) && isMonthBefore(month, e)
    }
    
    private func isCurrent(month: MonthSelection) -> Bool {
        let cal = Calendar.current
        let today = Date()
        return month.year == cal.component(.year, from: today) && month.month == cal.component(.month, from: today)
    }
    
    private func isSameMonth(_ m1: MonthSelection?, _ m2: MonthSelection?) -> Bool {
        guard let m1 = m1, let m2 = m2 else { return false }
        return m1.year == m2.year && m1.month == m2.month
    }
    
    private func isMonthBefore(_ m1: MonthSelection, _ m2: MonthSelection) -> Bool {
        return m1.year < m2.year || (m1.year == m2.year && m1.month < m2.month)
    }
    
    private func isMonthAfter(_ m1: MonthSelection, _ m2: MonthSelection) -> Bool {
        return m1.year > m2.year || (m1.year == m2.year && m1.month > m2.month)
    }
    
    private func onMonthClick(month: MonthSelection) {
        if config.selectionMode == .single {
            selectedMonth = month
            onMonthSelected?(month)
        } else {
            if rangeStartMonth == nil || (rangeStartMonth != nil && rangeEndMonth != nil) {
                rangeStartMonth = month
                rangeEndMonth = nil
            } else if let s = rangeStartMonth, rangeEndMonth == nil {
                if isMonthBefore(month, s) {
                    rangeStartMonth = month
                } else {
                    rangeEndMonth = month
                    onRangeSelected?(rangeStartMonth, rangeEndMonth)
                }
            }
        }
    }
}
