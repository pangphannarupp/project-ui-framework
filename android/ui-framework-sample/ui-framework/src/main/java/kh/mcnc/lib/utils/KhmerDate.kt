package kh.mcnc.lib.utils

import java.util.Calendar
import java.util.Date

data class IKhmerDate(
    val lunarDay: String,
    val lunarMonth: String,
    val lunarYear: String,
    val zodiacYear: String,
    val stem: String,
    val lunarDayNumber: Int,
    val ms: String,
    val cs: String,
    val lunarYearInt: Int
)

class KhmerDate(day: Int? = null, month: Int? = null, year: Int? = null, date: Date? = null) {
    private var day: Int
    private var month: Int
    private var year: Int

    init {
        val cal = Calendar.getInstance()
        if (date != null) {
            cal.time = date
            this.day = cal.get(Calendar.DAY_OF_MONTH)
            this.month = cal.get(Calendar.MONTH) + 1
            this.year = cal.get(Calendar.YEAR)
        } else if (day != null && month != null && year != null) {
            this.day = day
            this.month = month
            this.year = year
        } else {
            this.day = cal.get(Calendar.DAY_OF_MONTH)
            this.month = cal.get(Calendar.MONTH) + 1
            this.year = cal.get(Calendar.YEAR)
        }
    }

    companion object {
        private val khmerDayString = mapOf(
            "1" to "១កើត", "2" to "២កើត", "3" to "៣កើត", "4" to "៤កើត", "5" to "៥កើត",
            "6" to "៦កើត", "7" to "៧កើត", "8" to "៨កើត", "9" to "៩កើត", "10" to "១០កើត",
            "11" to "១១កើត", "12" to "១២កើត", "13" to "១៣កើត", "14" to "១៤កើត", "15" to "១៥កើត",
            "16" to "១រោច", "17" to "២រោច", "18" to "៣រោច", "19" to "៤រោច", "20" to "៥រោច",
            "21" to "៦រោច", "22" to "៧រោច", "23" to "៨រោច", "24" to "៩រោច", "25" to "១០រោច",
            "26" to "១១រោច", "27" to "១២រោច", "28" to "១៣រោច", "29" to "១៤រោច", "30" to "១៥រោច"
        )

        private val khmerDigits = mapOf(
            "0" to "០", "1" to "១", "2" to "២", "3" to "៣", "4" to "៤",
            "5" to "៥", "6" to "៦", "7" to "៧", "8" to "៨", "9" to "៩"
        )

        private val KHMER_NORMAL_MONTHS = listOf(
            "មិគសិរ", "បុស្ស", "មាឃ", "ផល្គុន", "ចេត្រ", "ពិសាខ", "ជេស្ឋ", "អាសាឍ", "ស្រាពណ៍", "ភទ្របទ", "អស្សុជ", "កត្តិក"
        )

        private val KHMER_LEAP_MONTHS = listOf(
            "មិគសិរ", "បុស្ស", "មាឃ", "ផល្គុន", "ចេត្រ", "ពិសាខ", "ជេស្ឋ", "បឋមាសាឍ", "ទុតិយាសាឍ", "ស្រាពណ៍", "ភទ្របទ", "អស្សុជ", "កត្តិក"
        )

        private val KHMER_ZODIAC = listOf(
            "ជូត", "ឆ្លូវ", "ខាល", "ថោះ", "រោង", "ម្សាញ់",
            "មមី", "មមែ", "វក", "រកា", "ច", "កុរ"
        )

        private val KHMER_STEMS = listOf(
            "ឯកស័ក", "ទោស័ក", "ត្រីស័ក", "ចត្វាស័ក", "បញ្ចស័ក",
            "ឆស័ក", "សប្តស័ក", "អដ្ឋស័ក", "នព្វស័ក", "សំរឹទ្ធិស័ក"
        )

        private fun replaceAll(text: String, dic: Map<String, String>): String {
            var result = text
            for ((key, value) in dic) {
                result = result.replace(key, value)
            }
            return result
        }

        private fun isGregorianLeapYear(year: Int): Boolean {
            return (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
        }

        private fun getGregorianYearDays(year: Int): Int {
            return if (isGregorianLeapYear(year)) 366 else 365
        }

        private fun getDaysSinceStartOfYear(day: Int, month: Int, year: Int): Int {
            val cal1 = Calendar.getInstance().apply { set(year, month - 1, day, 0, 0, 0); set(Calendar.MILLISECOND, 0) }
            val cal2 = Calendar.getInstance().apply { set(year, 0, 1, 0, 0, 0); set(Calendar.MILLISECOND, 0) }
            val diff = cal1.timeInMillis - cal2.timeInMillis
            return (diff / 86400000).toInt()
        }

        private fun getBuddhistEraYearForCalculation(year: Int): Int = year + 544

        private fun getAharkun(year: Int): Int {
            return Math.floor((getBuddhistEraYearForCalculation(year) * 292207.0 + 499.0) / 800.0).toInt() + 4
        }

        private fun getAvoman(year: Int): Int {
            return (11 * getAharkun(year) + 25) % 692
        }

        private fun getBodithey(year: Int): Int {
            val aharkun = getAharkun(year)
            return (Math.floor((11.0 * aharkun + 25.0) / 692.0).toInt() + aharkun + 29) % 30
        }

        private fun isKhmerSolarLeapYear(year: Int): Boolean {
            val aharkunMod = (getBuddhistEraYearForCalculation(year) * 292207 + 499) % 800
            return 800 - aharkunMod <= 207
        }

        private fun getBoditheyLeapType(year: Int): Int {
            val avoman = getAvoman(year)
            val bodithey = getBodithey(year)
            var hasLeapMonth = bodithey >= 25 || bodithey <= 5
            var hasLeapDay = false
            if (isKhmerSolarLeapYear(year)) {
                hasLeapDay = avoman <= 126
            } else if (avoman <= 137) {
                hasLeapDay = getAvoman(year + 1) != 0
            }
            if (bodithey == 25 && getBodithey(year + 1) == 5) hasLeapMonth = false
            if (bodithey == 24 && getBodithey(year + 1) == 6) hasLeapMonth = true
            
            if (hasLeapMonth && hasLeapDay) return 3
            if (hasLeapMonth) return 1
            if (hasLeapDay) return 2
            return 0
        }

        private fun getKhmerYearType(year: Int): String {
            val boditheyLeapType = getBoditheyLeapType(year)
            if (boditheyLeapType == 3 || boditheyLeapType == 1) return "leap-month"
            if (boditheyLeapType == 2 || getBoditheyLeapType(year - 1) == 3) return "leap-day"
            return "normal"
        }

        private fun getKhmerYearDays(year: Int): Int {
            val yearType = getKhmerYearType(year)
            if (yearType == "leap-month") return 384
            return if (yearType == "leap-day") 355 else 354
        }

        private fun normalizeKhmerMonthNumber(month: Int, year: Int): Int {
            val monthCount = if (getKhmerYearType(year) == "leap-month") 13 else 12
            return ((month - 1) % monthCount + monthCount) % monthCount + 1
        }

        private fun getKhmerMonthName(month: Int, year: Int): String {
            val normalizedMonth = normalizeKhmerMonthNumber(month, year)
            val yearType = getKhmerYearType(year)
            if (yearType == "leap-month") {
                return KHMER_LEAP_MONTHS[normalizedMonth - 1]
            }
            return KHMER_NORMAL_MONTHS[normalizedMonth - 1]
        }

        private fun getKhmerMonthLength(month: Int, year: Int): Int {
            val normalizedMonth = normalizeKhmerMonthNumber(month, year)
            val yearType = getKhmerYearType(year)
            if (yearType == "leap-month") {
                if (normalizedMonth == 8 || normalizedMonth == 9) return 30
                val normalMonthNumber = if (normalizedMonth > 9) normalizedMonth - 1 else normalizedMonth
                return if (normalMonthNumber % 2 == 0) 30 else 29
            }
            if (normalizedMonth == 7) return if (yearType == "leap-day") 30 else 29
            return if (normalizedMonth % 2 == 0) 30 else 29
        }

        private fun getKhmerCivilDateAtGregorianYearStart(year: Int): Pair<Int, Int> {
            var month = 2
            var day = 1
            for (currentYear in 1900 until year) {
                day += getGregorianYearDays(currentYear) - getKhmerYearDays(currentYear)
                while (day > getKhmerMonthLength(month, currentYear)) {
                    day -= getKhmerMonthLength(month, currentYear)
                    month = normalizeKhmerMonthNumber(month + 1, currentYear)
                }
                while (day <= 0) {
                    month = normalizeKhmerMonthNumber(month - 1, currentYear)
                    day += getKhmerMonthLength(month, currentYear)
                }
            }
            return Pair(month, day)
        }

        private fun advanceKhmerCivilDate(month: Int, day: Int, year: Int, days: Int): Pair<Int, Int> {
            var currentMonth = month
            var currentDay = day
            for (i in 0 until days) {
                currentDay += 1
                if (currentDay > getKhmerMonthLength(currentMonth, year)) {
                    currentDay = 1
                    currentMonth = normalizeKhmerMonthNumber(currentMonth + 1, year)
                }
            }
            return Pair(currentMonth, currentDay)
        }

        private fun findBuddhistEraBoundary(year: Int): Date {
            val targetKhmerMonth = 6
            val targetMonthDay = 16
            
            val cursor = Calendar.getInstance().apply { set(year, 3, 10, 0, 0, 0); set(Calendar.MILLISECOND, 0) }
            val end = Calendar.getInstance().apply { set(year, 4, 31, 0, 0, 0); set(Calendar.MILLISECOND, 0) }
            
            while (cursor.timeInMillis <= end.timeInMillis) {
                val yearStart = getKhmerCivilDateAtGregorianYearStart(year)
                val daysSinceStart = getDaysSinceStartOfYear(cursor.get(Calendar.DAY_OF_MONTH), cursor.get(Calendar.MONTH) + 1, year)
                val civilDate = advanceKhmerCivilDate(yearStart.first, yearStart.second, year, daysSinceStart)
                
                if (civilDate.first == targetKhmerMonth && civilDate.second == targetMonthDay) {
                    return cursor.time
                }
                cursor.add(Calendar.DAY_OF_MONTH, 1)
            }
            
            return Calendar.getInstance().apply { set(year, 4, 15, 0, 0, 0); set(Calendar.MILLISECOND, 0) }.time
        }

        private fun getKhmerZodiacYear(year: Int): String {
            return KHMER_ZODIAC[((year - 2020) % 12 + 12) % 12]
        }

        private fun getKhmerStem(year: Int): String {
            return KHMER_STEMS[((year - 2019) % 10 + 10) % 10]
        }
    }

    fun toLunar(): IKhmerDate {
        val yearStart = getKhmerCivilDateAtGregorianYearStart(this.year)
        val daysSinceStart = getDaysSinceStartOfYear(this.day, this.month, this.year)
        val civilDate = advanceKhmerCivilDate(yearStart.first, yearStart.second, this.year, daysSinceStart)
        
        val khmerMonthName = getKhmerMonthName(civilDate.first, this.year)
        val monthDay = civilDate.second
        
        val targetDate = Calendar.getInstance().apply { set(this@KhmerDate.year, this@KhmerDate.month - 1, this@KhmerDate.day, 0, 0, 0); set(Calendar.MILLISECOND, 0) }.time
        val refYear = if (this.month > 4 || (this.month == 4 && this.day >= 14)) this.year else this.year - 1

        val zodiacYear = getKhmerZodiacYear(refYear)
        val stem = getKhmerStem(refYear)

        val boundary = findBuddhistEraBoundary(this.year)
        var buddhistEraYear = this.year + 543
        if (targetDate.time >= boundary.time) {
            buddhistEraYear = this.year + 544
        }

        val lunarYearInt = buddhistEraYear
        val lunarYearStr = replaceAll(lunarYearInt.toString(), khmerDigits)
        
        val msYear = lunarYearInt - 621
        val csYear = lunarYearInt - 1181
        val ms = replaceAll(msYear.toString(), khmerDigits)
        val cs = replaceAll(csYear.toString(), khmerDigits)

        return IKhmerDate(
            lunarDay = khmerDayString[monthDay.toString()] ?: "",
            lunarMonth = khmerMonthName,
            lunarYear = lunarYearStr,
            zodiacYear = zodiacYear,
            stem = stem,
            lunarDayNumber = monthDay,
            ms = ms,
            cs = cs,
            lunarYearInt = lunarYearInt
        )
    }
}

enum class SelectionMode {
    Single, Range, Week
}

data class CalendarConfig(
    val firstDayOfWeek: Int = 1,
    val showAdjacentMonths: Boolean = true,
    val extraWeeksBefore: Int = 0,
    val extraWeeksAfter: Int = 0,
    val fixedWeekCount: Int? = 6,
    val minDate: Date? = null,
    val maxDate: Date? = null,
    val selectionMode: SelectionMode = SelectionMode.Single,
    val specialDates: List<Date> = emptyList()
)

data class CalendarDay(
    val date: Date,
    val gregorianDay: Int,
    val isCurrentMonth: Boolean,
    val isToday: Boolean,
    val khmerDate: IKhmerDate,
    val isSunday: Boolean,
    val isEnabled: Boolean,
    val isHidden: Boolean,
    val isSpecial: Boolean
)

class CalendarState(private val config: CalendarConfig = CalendarConfig()) {
    private val cache = mutableMapOf<String, List<CalendarDay>>()

    private fun isSameDay(date1: Date, date2: Date): Boolean {
        val cal1 = Calendar.getInstance().apply { time = date1 }
        val cal2 = Calendar.getInstance().apply { time = date2 }
        return cal1.get(Calendar.YEAR) == cal2.get(Calendar.YEAR) &&
               cal1.get(Calendar.MONTH) == cal2.get(Calendar.MONTH) &&
               cal1.get(Calendar.DAY_OF_MONTH) == cal2.get(Calendar.DAY_OF_MONTH)
    }

    fun generateDaysForMonth(year: Int, month: Int): List<CalendarDay> {
        val cacheKey = "$year-$month"
        if (cache.containsKey(cacheKey)) {
            return cache[cacheKey]!!
        }

        val days = mutableListOf<CalendarDay>()
        val cal = Calendar.getInstance().apply { 
            set(year, month - 1, 1, 0, 0, 0)
            set(Calendar.MILLISECOND, 0)
        }
        
        // Java Calendar.DAY_OF_WEEK: 1 = Sunday, 2 = Monday, ... 7 = Saturday
        val dayOfWeek = cal.get(Calendar.DAY_OF_WEEK) - 1 // 0 = Sunday, 1 = Monday
        
        var offset = 0
        if (config.firstDayOfWeek == 1) {
            offset = if (dayOfWeek == 0) 6 else dayOfWeek - 1
        } else {
            offset = dayOfWeek
        }
        
        cal.add(Calendar.DAY_OF_MONTH, -offset - (config.extraWeeksBefore * 7))
        
        val endCal = Calendar.getInstance().apply {
            set(year, month - 1, 1, 0, 0, 0)
            set(Calendar.MILLISECOND, 0)
            add(Calendar.MONTH, 1)
            add(Calendar.DAY_OF_MONTH, -1)
        }
        val endDayOfWeek = endCal.get(Calendar.DAY_OF_WEEK) - 1
        var endOffset = 0
        if (config.firstDayOfWeek == 1) {
            endOffset = if (endDayOfWeek == 0) 0 else 7 - endDayOfWeek
        } else {
            endOffset = if (endDayOfWeek == 6) 0 else 6 - endDayOfWeek
        }
        
        endCal.add(Calendar.DAY_OF_MONTH, endOffset + (config.extraWeeksAfter * 7))
        
        var totalDays = 0
        val temp = Calendar.getInstance().apply { time = cal.time; set(Calendar.HOUR_OF_DAY, 12) }
        val tempEnd = Calendar.getInstance().apply { time = endCal.time; set(Calendar.HOUR_OF_DAY, 12) }
        
        while (temp.timeInMillis <= tempEnd.timeInMillis) {
            totalDays++
            temp.add(Calendar.DAY_OF_MONTH, 1)
        }
        
        if (config.fixedWeekCount != null) {
            val targetDays = config.fixedWeekCount * 7
            if (totalDays < targetDays) {
                val daysToPad = targetDays - totalDays
                val weeksToPad = daysToPad / 7
                val padBeforeWeeks = if (offset == 0 && weeksToPad >= 1) 1 else Math.floor(weeksToPad / 2.0).toInt()
                cal.add(Calendar.DAY_OF_MONTH, -(padBeforeWeeks * 7))
                totalDays = targetDays
            }
        }
        
        val today = Calendar.getInstance().apply { set(Calendar.HOUR_OF_DAY, 0); set(Calendar.MINUTE, 0); set(Calendar.SECOND, 0); set(Calendar.MILLISECOND, 0) }.time
        
        val minTime = config.minDate?.let { 
            Calendar.getInstance().apply { time = it; set(Calendar.HOUR_OF_DAY, 0); set(Calendar.MINUTE, 0); set(Calendar.SECOND, 0); set(Calendar.MILLISECOND, 0) }.timeInMillis
        }
        val maxTime = config.maxDate?.let {
            Calendar.getInstance().apply { time = it; set(Calendar.HOUR_OF_DAY, 23); set(Calendar.MINUTE, 59); set(Calendar.SECOND, 59); set(Calendar.MILLISECOND, 999) }.timeInMillis
        }
        
        for (i in 0 until totalDays) {
            val d = cal.get(Calendar.DAY_OF_MONTH)
            val m = cal.get(Calendar.MONTH) + 1
            val y = cal.get(Calendar.YEAR)
            val isCurrentMonth = m == month
            
            val calDate = cal.time
            val isToday = isSameDay(calDate, today)
            val isSunday = cal.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY
            
            val khmerDate = KhmerDate(d, m, y).toLunar()
            
            var isEnabled = true
            val t = calDate.time
            if (minTime != null && t < minTime) isEnabled = false
            if (maxTime != null && t > maxTime) isEnabled = false
            
            val isHidden = !isCurrentMonth && !config.showAdjacentMonths
            val isSpecial = config.specialDates.any { isSameDay(it, calDate) }
            
            days.add(CalendarDay(
                date = calDate,
                gregorianDay = d,
                isCurrentMonth = isCurrentMonth,
                isToday = isToday,
                khmerDate = khmerDate,
                isSunday = isSunday,
                isEnabled = isEnabled,
                isHidden = isHidden,
                isSpecial = isSpecial
            ))
            
            cal.add(Calendar.DAY_OF_MONTH, 1)
        }
        
        cache[cacheKey] = days
        return days
    }
}
