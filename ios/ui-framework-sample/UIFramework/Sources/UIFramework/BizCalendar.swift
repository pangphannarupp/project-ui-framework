import SwiftUI

public struct CalendarSelection {
    public let date: Date
}

public struct BizCalendar: View {
    public var config: CalendarConfig
    @State public var initialDate: Date
    public var showActionButtons: Bool
    
    public var onDateSelected: ((CalendarSelection) -> Void)?
    public var onRangeSelected: ((CalendarSelection?, CalendarSelection?) -> Void)?
    public var onMonthChanged: ((Int, Int) -> Void)?
    public var onConfirm: ((CalendarSelection?, CalendarSelection?) -> Void)?
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
    
    private let calendarState: CalendarState
    private let monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    
    public init(
        config: CalendarConfig = CalendarConfig(),
        initialDate: Date = Date(),
        showActionButtons: Bool = false,
        onDateSelected: ((CalendarSelection) -> Void)? = nil,
        onRangeSelected: ((CalendarSelection?, CalendarSelection?) -> Void)? = nil,
        onMonthChanged: ((Int, Int) -> Void)? = nil,
        onConfirm: ((CalendarSelection?, CalendarSelection?) -> Void)? = nil,
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
    
    private var daysOfWeek: [String] {
        let firstDay = config.firstDayOfWeek
        if firstDay == 1 {
            return ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
        }
        return ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    }
    
    private func isSundayIndex(_ idx: Int) -> Bool {
        return config.firstDayOfWeek == 1 ? idx == 6 : idx == 0
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            headerView
            
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
        .padding(.vertical, 16)
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
                    
                    VStack {
                        if day.isSpecial {
                            Circle()
                                .fill(Color.orange)
                                .frame(width: 6, height: 6)
                                .position(x: 32, y: 8) // Approx position
                        }
                        Text("\(day.gregorianDay)")
                            .font(.system(size: 18))
                            .foregroundColor(
                                selected ? .white :
                                    (day.isSunday ? .red :
                                        (isDisabled ? Color.gray.opacity(0.5) : Color.primary))
                            )
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
            
            DispatchQueue.main.async {
                self.days = newDays
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
            onDateSelected?(CalendarSelection(date: day.date))
        } else if config.selectionMode == .week {
            if let index = days.firstIndex(where: { isSameDay($0.date, day.date) }) {
                let rowStart = (index / 7) * 7
                let weekDays = days[rowStart..<min(rowStart + 7, days.count)].filter { $0.isEnabled && !$0.isHidden }
                if let first = weekDays.first, let last = weekDays.last {
                    rangeStartDate = first.date
                    rangeEndDate = last.date
                    onRangeSelected?(CalendarSelection(date: first.date), CalendarSelection(date: last.date))
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
                    onRangeSelected?(CalendarSelection(date: start), CalendarSelection(date: day.date))
                }
            }
        }
    }
    
    private func onConfirmAction() {
        let startDay = days.first { isSameDay($0.date, config.selectionMode == .single ? selectedDate : rangeStartDate) }
        let endDay = days.first { isSameDay($0.date, rangeEndDate) }
        
        if config.selectionMode == .single {
            onConfirm?(startDay.map { CalendarSelection(date: $0.date) }, nil)
        } else {
            onConfirm?(
                startDay.map { CalendarSelection(date: $0.date) },
                endDay.map { CalendarSelection(date: $0.date) }
            )
        }
    }
}

struct MonthYearPicker: View {
    @Binding var month: Int
    @Binding var year: Int
    @Binding var isPresented: Bool
    var monthNames: [String]
    
    @State private var tempMonth: Int
    @State private var tempYear: Int
    
    private let yearRange: [Int]
    
    init(month: Binding<Int>, year: Binding<Int>, isPresented: Binding<Bool>, monthNames: [String]) {
        self._month = month
        self._year = year
        self._isPresented = isPresented
        self.monthNames = monthNames
        
        let currentYear = Calendar.current.component(.year, from: Date())
        self.yearRange = Array((currentYear - 50)...(currentYear + 50))
        
        self._tempMonth = State(initialValue: month.wrappedValue)
        self._tempYear = State(initialValue: year.wrappedValue)
    }
    
    var body: some View {
        VStack {
            Text("Select Month")
                .font(.headline)
                .padding()
            
            HStack {
                Picker("Month", selection: $tempMonth) {
                    ForEach(1...12, id: \.self) { m in
                        Text(monthNames[m - 1]).tag(m)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                
                Picker("Year", selection: $tempYear) {
                    ForEach(yearRange, id: \.self) { y in
                        Text(String(y)).tag(y)
                    }
                }
                .pickerStyle(WheelPickerStyle())
            }
            .frame(height: 200)
            
            HStack(spacing: 16) {
                Button("Close") {
                    isPresented = false
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(white: 0.95))
                .cornerRadius(8)
                .foregroundColor(.black)
                
                Button("Confirm") {
                    month = tempMonth
                    year = tempYear
                    isPresented = false
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(red: 0, green: 51/255, blue: 153/255))
                .cornerRadius(8)
                .foregroundColor(.white)
            }
            .padding()
        }
    }
}

struct PresentationDetentModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content.presentationDetents([.medium, .fraction(0.4)])
        } else {
            content
        }
    }
}

extension View {
    func withPresentationDetents() -> some View {
        self.modifier(PresentationDetentModifier())
    }
}
