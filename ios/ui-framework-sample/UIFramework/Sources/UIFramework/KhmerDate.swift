import Foundation

public struct IKhmerDate: Equatable {
    public var lunarDay: String
    public var lunarMonth: String
    public var lunarYear: String
    public var zodiacYear: String
    public var stem: String
    public var lunarDayNumber: Int
    public var ms: String
    public var cs: String
    public var lunarYearInt: Int
    
    public init(lunarDay: String, lunarMonth: String, lunarYear: String, zodiacYear: String, stem: String, lunarDayNumber: Int, ms: String, cs: String, lunarYearInt: Int) {
        self.lunarDay = lunarDay
        self.lunarMonth = lunarMonth
        self.lunarYear = lunarYear
        self.zodiacYear = zodiacYear
        self.stem = stem
        self.lunarDayNumber = lunarDayNumber
        self.ms = ms
        self.cs = cs
        self.lunarYearInt = lunarYearInt
    }
}

private let khmerDayString: [String: String] = [
    "1": "១កើត", "2": "២កើត", "3": "៣កើត", "4": "៤កើត", "5": "៥កើត",
    "6": "៦កើត", "7": "៧កើត", "8": "៨កើត", "9": "៩កើត", "10": "១០កើត",
    "11": "១១កើត", "12": "១២កើត", "13": "១៣កើត", "14": "១៤កើត", "15": "១៥កើត",
    "16": "១រោច", "17": "២រោច", "18": "៣រោច", "19": "៤រោច", "20": "៥រោច",
    "21": "៦រោច", "22": "៧រោច", "23": "៨រោច", "24": "៩រោច", "25": "១០រោច",
    "26": "១១រោច", "27": "១២រោច", "28": "១៣រោច", "29": "១៤រោច", "30": "១៥រោច"
]

private let khmerDigits: [String: String] = [
    "0": "០", "1": "១", "2": "២", "3": "៣", "4": "៤",
    "5": "៥", "6": "៦", "7": "៧", "8": "៨", "9": "៩"
]

private let KHMER_NORMAL_MONTHS = [
    "មិគសិរ", "បុស្ស", "មាឃ", "ផល្គុន", "ចេត្រ", "ពិសាខ", "ជេស្ឋ", "អាសាឍ", "ស្រាពណ៍", "ភទ្របទ", "អស្សុជ", "កត្តិក"
]

private let KHMER_LEAP_MONTHS = [
    "មិគសិរ", "បុស្ស", "មាឃ", "ផល្គុន", "ចេត្រ", "ពិសាខ", "ជេស្ឋ", "បឋមាសាឍ", "ទុតិយាសាឍ", "ស្រាពណ៍", "ភទ្របទ", "អស្សុជ", "កត្តិក"
]

private let KHMER_ZODIAC = [
    "ជូត", "ឆ្លូវ", "ខាល", "ថោះ", "រោង", "ម្សាញ់",
    "មមី", "មមែ", "វក", "រកា", "ច", "កុរ"
]

private let KHMER_STEMS = [
    "ឯកស័ក", "ទោស័ក", "ត្រីស័ក", "ចត្វាស័ក", "បញ្ចស័ក",
    "ឆស័ក", "សប្តស័ក", "អដ្ឋស័ក", "នព្វស័ក", "សំរឹទ្ធិស័ក"
]

private func replaceAll(text: String, dic: [String: String]) -> String {
    var result = text
    for (key, value) in dic {
        result = result.replacingOccurrences(of: key, with: value)
    }
    return result
}

private func isGregorianLeapYear(year: Int) -> Bool {
    return (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
}

private func getGregorianYearDays(year: Int) -> Int {
    return isGregorianLeapYear(year: year) ? 366 : 365
}

private func getDaysSinceStartOfYear(day: Int, month: Int, year: Int) -> Int {
    var cal = Calendar(identifier: .gregorian)
    cal.timeZone = TimeZone(secondsFromGMT: 0)!
    let date1 = cal.date(from: DateComponents(year: year, month: month, day: day))!
    let date2 = cal.date(from: DateComponents(year: year, month: 1, day: 1))!
    let diff = date1.timeIntervalSince(date2)
    return Int(floor(diff / 86400.0))
}

private func getBuddhistEraYearForCalculation(year: Int) -> Int {
    return year + 544
}

private func getAharkun(year: Int) -> Int {
    return Int(floor((Double(getBuddhistEraYearForCalculation(year: year)) * 292207.0 + 499.0) / 800.0)) + 4
}

private func getAvoman(year: Int) -> Int {
    return (11 * getAharkun(year: year) + 25) % 692
}

private func getBodithey(year: Int) -> Int {
    let aharkun = getAharkun(year: year)
    return (Int(floor((11.0 * Double(aharkun) + 25.0) / 692.0)) + aharkun + 29) % 30
}

private func isKhmerSolarLeapYear(year: Int) -> Bool {
    let aharkunMod = (getBuddhistEraYearForCalculation(year: year) * 292207 + 499) % 800
    return 800 - aharkunMod <= 207
}

private func getBoditheyLeapType(year: Int) -> Int {
    let avoman = getAvoman(year: year)
    let bodithey = getBodithey(year: year)
    var hasLeapMonth = bodithey >= 25 || bodithey <= 5
    var hasLeapDay = false
    
    if isKhmerSolarLeapYear(year: year) {
        hasLeapDay = avoman <= 126
    } else if avoman <= 137 {
        hasLeapDay = getAvoman(year: year + 1) != 0
    }
    
    if bodithey == 25 && getBodithey(year: year + 1) == 5 { hasLeapMonth = false }
    if bodithey == 24 && getBodithey(year: year + 1) == 6 { hasLeapMonth = true }
    
    if hasLeapMonth && hasLeapDay { return 3 }
    if hasLeapMonth { return 1 }
    if hasLeapDay { return 2 }
    return 0
}

private func getKhmerYearType(year: Int) -> String {
    let boditheyLeapType = getBoditheyLeapType(year: year)
    if boditheyLeapType == 3 || boditheyLeapType == 1 { return "leap-month" }
    if boditheyLeapType == 2 || getBoditheyLeapType(year: year - 1) == 3 { return "leap-day" }
    return "normal"
}

private func getKhmerYearDays(year: Int) -> Int {
    let yearType = getKhmerYearType(year: year)
    if yearType == "leap-month" { return 384 }
    return yearType == "leap-day" ? 355 : 354
}

private func normalizeKhmerMonthNumber(month: Int, year: Int) -> Int {
    let monthCount = getKhmerYearType(year: year) == "leap-month" ? 13 : 12
    return ((month - 1) % monthCount + monthCount) % monthCount + 1
}

private func getKhmerMonthName(month: Int, year: Int) -> String {
    let normalizedMonth = normalizeKhmerMonthNumber(month: month, year: year)
    let yearType = getKhmerYearType(year: year)
    if yearType == "leap-month" {
        return KHMER_LEAP_MONTHS[normalizedMonth - 1]
    }
    return KHMER_NORMAL_MONTHS[normalizedMonth - 1]
}

private func getKhmerMonthLength(month: Int, year: Int) -> Int {
    let normalizedMonth = normalizeKhmerMonthNumber(month: month, year: year)
    let yearType = getKhmerYearType(year: year)
    if yearType == "leap-month" {
        if normalizedMonth == 8 || normalizedMonth == 9 { return 30 }
        let normalMonthNumber = normalizedMonth > 9 ? normalizedMonth - 1 : normalizedMonth
        return normalMonthNumber % 2 == 0 ? 30 : 29
    }
    if normalizedMonth == 7 { return yearType == "leap-day" ? 30 : 29 }
    return normalizedMonth % 2 == 0 ? 30 : 29
}

private func getKhmerCivilDateAtGregorianYearStart(year: Int) -> (Int, Int) {
    var month = 2
    var day = 1
    for currentYear in 1900..<year {
        day += getGregorianYearDays(year: currentYear) - getKhmerYearDays(year: currentYear)
        while day > getKhmerMonthLength(month: month, year: currentYear) {
            day -= getKhmerMonthLength(month: month, year: currentYear)
            month = normalizeKhmerMonthNumber(month: month + 1, year: currentYear)
        }
        while day <= 0 {
            month = normalizeKhmerMonthNumber(month: month - 1, year: currentYear)
            day += getKhmerMonthLength(month: month, year: currentYear)
        }
    }
    return (month, day)
}

private func advanceKhmerCivilDate(month: Int, day: Int, year: Int, days: Int) -> (Int, Int) {
    var currentMonth = month
    var currentDay = day
    for _ in 0..<days {
        currentDay += 1
        if currentDay > getKhmerMonthLength(month: currentMonth, year: year) {
            currentDay = 1
            currentMonth = normalizeKhmerMonthNumber(month: currentMonth + 1, year: year)
        }
    }
    return (currentMonth, currentDay)
}

private func findBuddhistEraBoundary(year: Int) -> Date {
    let targetKhmerMonth = 6
    let targetMonthDay = 16
    
    var cal = Calendar(identifier: .gregorian)
    cal.timeZone = TimeZone(secondsFromGMT: 0)!
    
    var cursor = cal.date(from: DateComponents(year: year, month: 4, day: 10))!
    let end = cal.date(from: DateComponents(year: year, month: 5, day: 31))!
    
    while cursor <= end {
        let yearStart = getKhmerCivilDateAtGregorianYearStart(year: year)
        let daysSinceStart = getDaysSinceStartOfYear(day: cal.component(.day, from: cursor), month: cal.component(.month, from: cursor), year: year)
        let civilDate = advanceKhmerCivilDate(month: yearStart.0, day: yearStart.1, year: year, days: daysSinceStart)
        
        if civilDate.0 == targetKhmerMonth && civilDate.1 == targetMonthDay {
            return cursor
        }
        cursor = cal.date(byAdding: .day, value: 1, to: cursor)!
    }
    
    return cal.date(from: DateComponents(year: year, month: 5, day: 15))!
}

private func getKhmerZodiacYear(year: Int) -> String {
    return KHMER_ZODIAC[((year - 2020) % 12 + 12) % 12]
}

private func getKhmerStem(year: Int) -> String {
    return KHMER_STEMS[((year - 2019) % 10 + 10) % 10]
}

public class KhmerDate {
    private var day: Int
    private var month: Int
    private var year: Int

    public init(day: Int, month: Int, year: Int) {
        self.day = day
        self.month = month
        self.year = year
    }
    
    public init(date: Date = Date()) {
        let cal = Calendar.current
        self.day = cal.component(.day, from: date)
        self.month = cal.component(.month, from: date)
        self.year = cal.component(.year, from: date)
    }

    public func toLunar() -> IKhmerDate {
        let yearStart = getKhmerCivilDateAtGregorianYearStart(year: self.year)
        let daysSinceStart = getDaysSinceStartOfYear(day: self.day, month: self.month, year: self.year)
        let civilDate = advanceKhmerCivilDate(month: yearStart.0, day: yearStart.1, year: self.year, days: daysSinceStart)
        
        let khmerMonthName = getKhmerMonthName(month: civilDate.0, year: self.year)
        let monthDay = civilDate.1
        
        var gcal = Calendar(identifier: .gregorian)
        gcal.timeZone = TimeZone(secondsFromGMT: 0)!
        let targetDate = gcal.date(from: DateComponents(year: self.year, month: self.month, day: self.day))!
        
        let refYear = (self.month > 4 || (self.month == 4 && self.day >= 14)) ? self.year : self.year - 1

        let zodiacYear = getKhmerZodiacYear(year: refYear)
        let stem = getKhmerStem(year: refYear)

        let boundary = findBuddhistEraBoundary(year: self.year)
        var buddhistEraYear = self.year + 543
        if targetDate.timeIntervalSince1970 >= boundary.timeIntervalSince1970 {
            buddhistEraYear = self.year + 544
        }

        let lunarYearInt = buddhistEraYear
        let lunarYearStr = replaceAll(text: String(lunarYearInt), dic: khmerDigits)
        
        let msYear = lunarYearInt - 621
        let csYear = lunarYearInt - 1181
        let ms = replaceAll(text: String(msYear), dic: khmerDigits)
        let cs = replaceAll(text: String(csYear), dic: khmerDigits)

        return IKhmerDate(
            lunarDay: khmerDayString[String(monthDay)] ?? "",
            lunarMonth: khmerMonthName,
            lunarYear: lunarYearStr,
            zodiacYear: zodiacYear,
            stem: stem,
            lunarDayNumber: monthDay,
            ms: ms,
            cs: cs,
            lunarYearInt: lunarYearInt
        )
    }
}

public struct CalendarDay: Identifiable, Equatable {
    public let id = UUID()
    public var date: Date
    public var gregorianDay: Int
    public var isCurrentMonth: Bool
    public var isToday: Bool
    public var khmerDate: IKhmerDate
    public var isSunday: Bool
    public var isEnabled: Bool
    public var isHidden: Bool
    public var isSpecial: Bool
    
    public init(date: Date, gregorianDay: Int, isCurrentMonth: Bool, isToday: Bool, khmerDate: IKhmerDate, isSunday: Bool, isEnabled: Bool, isHidden: Bool, isSpecial: Bool) {
        self.date = date
        self.gregorianDay = gregorianDay
        self.isCurrentMonth = isCurrentMonth
        self.isToday = isToday
        self.khmerDate = khmerDate
        self.isSunday = isSunday
        self.isEnabled = isEnabled
        self.isHidden = isHidden
        self.isSpecial = isSpecial
    }
}

public enum SelectionMode {
    case single, range, week
}

public struct CalendarConfig: Equatable {
    public var firstDayOfWeek: Int // 0 = Sunday, 1 = Monday
    public var showAdjacentMonths: Bool
    public var extraWeeksBefore: Int
    public var extraWeeksAfter: Int
    public var fixedWeekCount: Int?
    public var minDate: Date?
    public var maxDate: Date?
    public var selectionMode: SelectionMode
    public var specialDates: [Date]
    
    public init(
        firstDayOfWeek: Int = 1,
        showAdjacentMonths: Bool = true,
        extraWeeksBefore: Int = 0,
        extraWeeksAfter: Int = 0,
        fixedWeekCount: Int? = 6,
        minDate: Date? = nil,
        maxDate: Date? = nil,
        selectionMode: SelectionMode = .single,
        specialDates: [Date] = []
    ) {
        self.firstDayOfWeek = firstDayOfWeek
        self.showAdjacentMonths = showAdjacentMonths
        self.extraWeeksBefore = extraWeeksBefore
        self.extraWeeksAfter = extraWeeksAfter
        self.fixedWeekCount = fixedWeekCount
        self.minDate = minDate
        self.maxDate = maxDate
        self.selectionMode = selectionMode
        self.specialDates = specialDates
    }
}

public class CalendarState {
    private var config: CalendarConfig
    private var cache: [String: [CalendarDay]] = [:]

    public init(config: CalendarConfig = CalendarConfig()) {
        self.config = config
    }

    private func isSameDay(_ date1: Date, _ date2: Date) -> Bool {
        let cal = Calendar.current
        return cal.component(.year, from: date1) == cal.component(.year, from: date2) &&
               cal.component(.month, from: date1) == cal.component(.month, from: date2) &&
               cal.component(.day, from: date1) == cal.component(.day, from: date2)
    }

    public func generateDaysForMonth(year: Int, month: Int) -> [CalendarDay] {
        let cacheKey = "\(year)-\(month)"
        if let cached = cache[cacheKey] {
            return cached
        }

        var days: [CalendarDay] = []
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone.current
        
        var dateComps = DateComponents(year: year, month: month, day: 1)
        guard let firstDayOfMonth = cal.date(from: dateComps) else { return [] }
        
        let weekday = cal.component(.weekday, from: firstDayOfMonth) // 1 = Sunday, 2 = Monday
        let dayOfWeek = weekday - 1 // 0 = Sunday, 1 = Monday
        
        var offset = 0
        if config.firstDayOfWeek == 1 {
            offset = dayOfWeek == 0 ? 6 : dayOfWeek - 1
        } else {
            offset = dayOfWeek
        }
        
        var startCal = cal.date(byAdding: .day, value: -offset - (config.extraWeeksBefore * 7), to: firstDayOfMonth)!
        
        dateComps = DateComponents(year: year, month: month + 1, day: 0)
        let endOfMonth = cal.date(from: dateComps)!
        let endWeekday = cal.component(.weekday, from: endOfMonth)
        let endDayOfWeek = endWeekday - 1
        
        var endOffset = 0
        if config.firstDayOfWeek == 1 {
            endOffset = endDayOfWeek == 0 ? 0 : 7 - endDayOfWeek
        } else {
            endOffset = endDayOfWeek == 6 ? 0 : 6 - endDayOfWeek
        }
        
        var endCal = cal.date(byAdding: .day, value: endOffset + (config.extraWeeksAfter * 7), to: endOfMonth)!
        
        var temp = startCal
        var totalDays = 0
        
        // Normalize time to noon to avoid DST issues
        temp = cal.date(bySettingHour: 12, minute: 0, second: 0, of: temp)!
        endCal = cal.date(bySettingHour: 12, minute: 0, second: 0, of: endCal)!
        
        while temp <= endCal {
            totalDays += 1
            temp = cal.date(byAdding: .day, value: 1, to: temp)!
        }
        
        if let fixedCount = config.fixedWeekCount {
            let targetDays = fixedCount * 7
            if totalDays < targetDays {
                let daysToPad = targetDays - totalDays
                let weeksToPad = daysToPad / 7
                let padBeforeWeeks = (offset == 0 && weeksToPad >= 1) ? 1 : weeksToPad / 2
                startCal = cal.date(byAdding: .day, value: -(padBeforeWeeks * 7), to: startCal)!
                totalDays = targetDays
            }
        }
        
        let today = Date()
        
        let minTime = config.minDate.map { cal.startOfDay(for: $0) }
        let maxTime = config.maxDate.map { cal.date(bySettingHour: 23, minute: 59, second: 59, of: $0)! }
        
        var currentIterator = startCal
        
        for _ in 0..<totalDays {
            let d = cal.component(.day, from: currentIterator)
            let m = cal.component(.month, from: currentIterator)
            let y = cal.component(.year, from: currentIterator)
            
            let isCurrentMonth = m == month
            let isToday = isSameDay(currentIterator, today)
            let isSunday = cal.component(.weekday, from: currentIterator) == 1
            
            let khmerDate = KhmerDate(day: d, month: m, year: y).toLunar()
            
            var isEnabled = true
            let t = currentIterator
            if let min = minTime, t < min { isEnabled = false }
            if let max = maxTime, t > max { isEnabled = false }
            
            let isHidden = !isCurrentMonth && !config.showAdjacentMonths
            let isSpecial = config.specialDates.contains { isSameDay($0, currentIterator) }
            
            days.append(CalendarDay(
                date: currentIterator,
                gregorianDay: d,
                isCurrentMonth: isCurrentMonth,
                isToday: isToday,
                khmerDate: khmerDate,
                isSunday: isSunday,
                isEnabled: isEnabled,
                isHidden: isHidden,
                isSpecial: isSpecial
            ))
            
            currentIterator = cal.date(byAdding: .day, value: 1, to: currentIterator)!
        }
        
        cache[cacheKey] = days
        return days
    }
}
