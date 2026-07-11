import SwiftUI

public struct KhmerCalendarSelection {
    public let date: Date
    public let khmerDate: IKhmerDate
    public let fullText: String
}

public struct BizKhmerCalendar: View {
    public var config: CalendarConfig
    @State public var initialDate: Date
    public var showActionButtons: Bool
    
    public var onDateSelected: ((KhmerCalendarSelection) -> Void)?
    public var onRangeSelected: ((KhmerCalendarSelection?, KhmerCalendarSelection?) -> Void)?
    public var onMonthChanged: ((Int, Int) -> Void)?
    public var onConfirm: ((KhmerCalendarSelection?, KhmerCalendarSelection?) -> Void)?
    public var onCancel: (() -> Void)?
    
    @State private var selectedDate: Date?
    @State private var rangeStartDate: Date?
    @State private var rangeEndDate: Date?
    
    @State private var currentMonth: Int
    @State private var currentYear: Int
    @State private var showMonthPicker = false
    
    @State private var dragOffset: CGFloat = 0
    @State private var isLoading: Bool = false
    
    @State private var days: [CalendarDay] = []
    @State private var firstDayKhmer: IKhmerDate?
    
    private let calendarState: CalendarState
    private let monthNames = ["មករា", "កុម្ភៈ", "មីនា", "មេសា", "ឧសភា", "មិថុនា", "កក្កដា", "សីហា", "កញ្ញា", "តុលា", "វិច្ឆិកា", "ធ្នូ"]
    
    public init(
        config: CalendarConfig = CalendarConfig(),
        initialDate: Date = Date(),
        showActionButtons: Bool = false,
        onDateSelected: ((KhmerCalendarSelection) -> Void)? = nil,
        onRangeSelected: ((KhmerCalendarSelection?, KhmerCalendarSelection?) -> Void)? = nil,
        onMonthChanged: ((Int, Int) -> Void)? = nil,
        onConfirm: ((KhmerCalendarSelection?, KhmerCalendarSelection?) -> Void)? = nil,
        onCancel: (() -> Void)? = nil
    ) {
        self.config = config
        self._initialDate = State(initialValue: initialDate)
        self.showActionButtons = showActionButtons
        
        self.onDateSelected = onDateSelected
        self.onRangeSelected = onRangeSelected
        self.onMonthChanged = onMonthChanged
        self.onConfirm = onConfirm
        self.onCancel = onCancel
        
        let cal = Calendar.current
        self._currentMonth = State(initialValue: cal.component(.month, from: initialDate))
        self._currentYear = State(initialValue: cal.component(.year, from: initialDate))
        
        self.calendarState = CalendarState(config: config)
        
        self._selectedDate = State(initialValue: initialDate)
    }
    
    private func getFullKhmerString(k: IKhmerDate) -> String {
        return "\(k.lunarDay) \(k.lunarMonth) ឆ្នាំ\(k.zodiacYear) \(k.stem) ព.ស. \(k.lunarYear)"
    }
    
    private var selectedKhmerDateFull: String? {
        if config.selectionMode == .single, let sel = selectedDate, let day = days.first(where: { isSameDay($0.date, sel) }) {
            return getFullKhmerString(k: day.khmerDate)
        }
        return nil
    }
    
    private var daysOfWeek: [String] {
        let firstDay = config.firstDayOfWeek
        if firstDay == 1 {
            return ["ចន្ទ", "អង្គារ", "ពុធ", "ព្រហ.", "សុក្រ", "សៅរ៍", "អាទិត្យ"]
        }
        return ["អាទិត្យ", "ចន្ទ", "អង្គារ", "ពុធ", "ព្រហ.", "សុក្រ", "សៅរ៍"]
    }
    
    private func isSundayIndex(_ idx: Int) -> Bool {
        return config.firstDayOfWeek == 1 ? idx == 6 : idx == 0
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            headerView
            
            subtitleView
            
            weekdaysView
            
            calendarGridView
            
            if showActionButtons {
                actionsView
            }
        }
        .padding(16)
        .background(Color.white)
        .onAppear {
            updateCalendar()
        }
        .onChange(of: currentMonth) { _ in updateCalendar() }
        .onChange(of: currentYear) { _ in updateCalendar() }
        .onChange(of: config) { _ in updateCalendar() }
        .sheet(isPresented: $showMonthPicker) {
            MonthYearPicker(
                month: $currentMonth,
                year: $currentYear,
                isPresented: $showMonthPicker,
                monthNames: monthNames
            )
            .withPresentationDetents()
        }
    }
    
    private var headerView: some View {
        HStack {
            Button(action: { showMonthPicker = true }) {
                HStack(spacing: 4) {
                    Text("\(monthNames[currentMonth - 1]) \(String(currentYear))")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color(red: 26/255, green: 42/255, blue: 94/255))
                    Image(systemName: "chevron.down")
                        .font(.system(size: 14))
                }
            }
            Spacer()
            HStack(spacing: 8) {
                Button(action: { animateToPrevMonth() }) {
                    Image(systemName: "chevron.left")
                        .frame(width: 24, height: 24)
                }
                Button(action: goToToday) {
                    Image(systemName: "calendar")
                        .frame(width: 24, height: 24)
                        .foregroundColor(Color(red: 0, green: 51/255, blue: 153/255))
                }
                Button(action: { animateToNextMonth() }) {
                    Image(systemName: "chevron.right")
                        .frame(width: 24, height: 24)
                }
            }
            .foregroundColor(.primary)
        }
        .padding(.vertical, 8)
    }
    
    @ViewBuilder
    private var subtitleView: some View {
        if let subtitle = selectedKhmerDateFull {
            Text(subtitle)
                .font(.system(size: 14))
                .foregroundColor(Color(red: 26/255, green: 42/255, blue: 94/255, opacity: 0.7))
                .padding(.bottom, 16)
        } else if let fk = firstDayKhmer {
            Text("ឆ្នាំ\(fk.zodiacYear) \(fk.stem) ព.ស. \(fk.lunarYear)")
                .font(.system(size: 14))
                .foregroundColor(Color(red: 26/255, green: 42/255, blue: 94/255, opacity: 0.7))
                .padding(.bottom, 16)
        } else {
            Spacer().frame(height: 36) // 14 font size approx height with padding
        }
    }
    
    private var weekdaysView: some View {
        HStack(spacing: 0) {
            ForEach(0..<7, id: \.self) { idx in
                Text(daysOfWeek[idx])
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(isSundayIndex(idx) ? Color.red : Color(red: 26/255, green: 42/255, blue: 94/255))
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.bottom, 8)
    }
    
    private var calendarGridView: some View {
        let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 7)
        return LazyVGrid(columns: columns, spacing: 0) {
            if isLoading {
                ForEach(0..<42, id: \.self) { _ in
                    skeletonCell
                }
            } else {
                ForEach(days) { day in
                    dayCell(for: day)
                }
            }
        }
        .offset(x: dragOffset)
        .gesture(
            DragGesture()
                .onChanged { value in
                    dragOffset = value.translation.width
                }
                .onEnded { value in
                    if value.translation.width > 50 {
                        animateToPrevMonth()
                    } else if value.translation.width < -50 {
                        animateToNextMonth()
                    } else {
                        withAnimation { dragOffset = 0 }
                    }
                }
        )
    }
    
    private var skeletonCell: some View {
        ZStack {
            BizSkeletonText()
                .padding(2)
        }
        .frame(height: 64)
    }
    
    private func dayCell(for day: CalendarDay) -> some View {
        ZStack {
            if day.isHidden {
                Color.clear
            } else {
                let isDisabled = !day.isEnabled || !day.isCurrentMonth
                let selected = isSelected(day)
                let inRange = isInRange(day)
                let rangeStart = isRangeStart(day)
                let rangeEnd = isRangeEnd(day)
                
                ZStack {
                    if inRange || rangeStart || rangeEnd {
                        HStack(spacing: 0) {
                            if rangeStart && !rangeEnd {
                                Color.clear.frame(maxWidth: .infinity)
                                Color.red.opacity(0.1).frame(maxWidth: .infinity)
                            } else if rangeEnd && !rangeStart {
                                Color.red.opacity(0.1).frame(maxWidth: .infinity)
                                Color.clear.frame(maxWidth: .infinity)
                            } else if inRange {
                                Color.red.opacity(0.1)
                            } else {
                                Color.clear
                            }
                        }
                    }
                    
                    VStack(spacing: 0) {
                        Text(day.khmerDate.lunarDay)
                            .font(.system(size: 8))
                            .foregroundColor(selected ? .white : Color(red: 26/255, green: 42/255, blue: 94/255, opacity: 0.7))
                            .lineLimit(1)
                            .padding(.top, 4)
                        
                        Text("\(day.gregorianDay)")
                            .font(.system(size: 18))
                            .foregroundColor(
                                selected ? .white :
                                    (day.isSunday ? .red :
                                        (isDisabled ? Color.gray.opacity(0.5) : Color.primary))
                            )
                        
                        Text(day.khmerDate.lunarMonth)
                            .font(.system(size: 8))
                            .foregroundColor(selected ? .white : Color(red: 26/255, green: 42/255, blue: 94/255, opacity: 0.7))
                            .lineLimit(1)
                            .padding(.bottom, 4)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(
                        selected ? Color.red : Color.clear
                    )
                    .cornerRadius(4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(day.isToday && !selected ? Color.red : Color.clear, lineWidth: 1)
                    )
                    .overlay(
                        Group {
                            if day.isSpecial {
                                Circle()
                                    .fill(Color.orange)
                                    .frame(width: 4, height: 4)
                                    .position(x: 34, y: 6) // Approx position
                            }
                        }
                    )
                    .padding(2)
                }
                .frame(height: 64)
                .opacity(isDisabled ? 0.3 : 1.0)
                .onTapGesture {
                    onDayClick(day)
                }
            }
        }
        .frame(height: 64)
    }
    
    private var actionsView: some View {
        HStack(spacing: 16) {
            Spacer()
            Button("Cancel") {
                onCancel?()
            }
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(Color(red: 26/255, green: 42/255, blue: 94/255))
            
            Button("Confirm") {
                onConfirmAction()
            }
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.red)
            .cornerRadius(4)
        }
        .padding(.top, 16)
    }
    
    private func updateCalendar() {
        isLoading = true
        let year = currentYear
        let month = currentMonth
        
        DispatchQueue.global(qos: .userInitiated).async {
            let newDays = self.calendarState.generateDaysForMonth(year: year, month: month)
            let fk = KhmerDate(day: 1, month: month, year: year).toLunar()
            
            DispatchQueue.main.async {
                self.days = newDays
                self.firstDayKhmer = fk
                self.isLoading = false
                self.onMonthChanged?(year, month)
            }
        }
    }
    
    private func animateToPrevMonth() {
        withAnimation(.easeInOut(duration: 0.2)) {
            dragOffset = UIScreen.main.bounds.width
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            prevMonth()
            dragOffset = -UIScreen.main.bounds.width
            withAnimation(.easeInOut(duration: 0.2)) {
                dragOffset = 0
            }
        }
    }
    
    private func animateToNextMonth() {
        withAnimation(.easeInOut(duration: 0.2)) {
            dragOffset = -UIScreen.main.bounds.width
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            nextMonth()
            dragOffset = UIScreen.main.bounds.width
            withAnimation(.easeInOut(duration: 0.2)) {
                dragOffset = 0
            }
        }
    }
    
    private func prevMonth() {
        if currentMonth == 1 {
            currentMonth = 12
            currentYear -= 1
        } else {
            currentMonth -= 1
        }
    }
    
    private func nextMonth() {
        if currentMonth == 12 {
            currentMonth = 1
            currentYear += 1
        } else {
            currentMonth += 1
        }
    }
    
    private func goToToday() {
        let cal = Calendar.current
        let today = Date()
        currentMonth = cal.component(.month, from: today)
        currentYear = cal.component(.year, from: today)
    }
    
    private func isSameDay(_ d1: Date?, _ d2: Date?) -> Bool {
        guard let d1 = d1, let d2 = d2 else { return false }
        let cal = Calendar.current
        return cal.isDate(d1, inSameDayAs: d2)
    }
    
    private func isSelected(_ day: CalendarDay) -> Bool {
        if config.selectionMode == .single {
            return isSameDay(selectedDate, day.date)
        }
        return isSameDay(rangeStartDate, day.date) || isSameDay(rangeEndDate, day.date)
    }
    
    private func isInRange(_ day: CalendarDay) -> Bool {
        guard config.selectionMode != .single, let start = rangeStartDate, let end = rangeEndDate else { return false }
        return day.date > start && day.date < end
    }
    
    private func isRangeStart(_ day: CalendarDay) -> Bool {
        if config.selectionMode == .single { return false }
        return isSameDay(rangeStartDate, day.date)
    }
    
    private func isRangeEnd(_ day: CalendarDay) -> Bool {
        if config.selectionMode == .single { return false }
        return isSameDay(rangeEndDate, day.date)
    }
    
    private func onDayClick(_ day: CalendarDay) {
        if !day.isEnabled || !day.isCurrentMonth { return }
        
        if config.selectionMode == .single {
            selectedDate = day.date
            onDateSelected?(KhmerCalendarSelection(date: day.date, khmerDate: day.khmerDate, fullText: getFullKhmerString(k: day.khmerDate)))
        } else if config.selectionMode == .week {
            if let index = days.firstIndex(where: { isSameDay($0.date, day.date) }) {
                let rowStart = (index / 7) * 7
                let weekDays = days[rowStart..<min(rowStart + 7, days.count)].filter { $0.isEnabled && !$0.isHidden }
                if let first = weekDays.first, let last = weekDays.last {
                    rangeStartDate = first.date
                    rangeEndDate = last.date
                    onRangeSelected?(
                        KhmerCalendarSelection(date: first.date, khmerDate: first.khmerDate, fullText: getFullKhmerString(k: first.khmerDate)),
                        KhmerCalendarSelection(date: last.date, khmerDate: last.khmerDate, fullText: getFullKhmerString(k: last.khmerDate))
                    )
                }
            }
        } else {
            if rangeStartDate == nil || (rangeStartDate != nil && rangeEndDate != nil) {
                rangeStartDate = day.date
                rangeEndDate = nil
            } else if let start = rangeStartDate, rangeEndDate == nil {
                if day.date < start {
                    rangeStartDate = day.date
                } else {
                    rangeEndDate = day.date
                    let startDay = days.first { isSameDay($0.date, start) }
                    onRangeSelected?(
                        startDay.map { KhmerCalendarSelection(date: $0.date, khmerDate: $0.khmerDate, fullText: getFullKhmerString(k: $0.khmerDate)) },
                        KhmerCalendarSelection(date: day.date, khmerDate: day.khmerDate, fullText: getFullKhmerString(k: day.khmerDate))
                    )
                }
            }
        }
    }
    
    private func onConfirmAction() {
        let startDay = days.first { isSameDay($0.date, config.selectionMode == .single ? selectedDate : rangeStartDate) }
        let endDay = days.first { isSameDay($0.date, rangeEndDate) }
        
        if config.selectionMode == .single {
            onConfirm?(
                startDay.map { KhmerCalendarSelection(date: $0.date, khmerDate: $0.khmerDate, fullText: getFullKhmerString(k: $0.khmerDate)) },
                nil
            )
        } else {
            onConfirm?(
                startDay.map { KhmerCalendarSelection(date: $0.date, khmerDate: $0.khmerDate, fullText: getFullKhmerString(k: $0.khmerDate)) },
                endDay.map { KhmerCalendarSelection(date: $0.date, khmerDate: $0.khmerDate, fullText: getFullKhmerString(k: $0.khmerDate)) }
            )
        }
    }
}
