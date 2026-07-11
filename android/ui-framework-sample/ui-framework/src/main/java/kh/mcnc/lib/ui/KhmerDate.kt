package kh.mcnc.lib.ui

import java.util.Calendar
import java.util.Date
import kotlin.collections.iterator
import kotlin.math.floor

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

class KhmerDate {
    private var day: Int
    private var month: Int
    private var year: Int

    constructor(date: Date = Date()) {
        val cal = Calendar.getInstance()
        cal.time = date
        this.day = cal.get(Calendar.DAY_OF_MONTH)
        this.month = cal.get(Calendar.MONTH) + 1
        this.year = cal.get(Calendar.YEAR)
    }

    constructor(day: Int, month: Int, year: Int) {
        if (!isValidDate(day, month, year)) {
            throw IllegalArgumentException("Invalid Gregorian date")
        }
        this.day = day
        this.month = month
        this.year = year
    }

    fun toLunar(): IKhmerDate {
        val yearStart = getKhmerCivilDateAtGregorianYearStart(this.year)
        val daysSinceStart = getDaysSinceStartOfYear(this.day, this.month, this.year)
        val civilDate = advanceKhmerCivilDate(yearStart.first, yearStart.second, this.year, daysSinceStart)
        
        val khmerMonthName = getKhmerMonthName(civilDate.first, this.year)
        val monthDay = civilDate.second
        
        val cal = Calendar.getInstance()
        cal.set(this.year, this.month - 1, this.day, 0, 0, 0)
        cal.set(Calendar.MILLISECOND, 0)
        val targetDate = cal.time
        
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

    override fun toString(): String {
        val cal = Calendar.getInstance()
        cal.set(year, month - 1, day)
        val dayOfWeekInt = cal.get(Calendar.DAY_OF_WEEK)
        
        val dayNameEn = when (dayOfWeekInt) {
            Calendar.SUNDAY -> "Sunday"
            Calendar.MONDAY -> "Monday"
            Calendar.TUESDAY -> "Tuesday"
            Calendar.WEDNESDAY -> "Wednesday"
            Calendar.THURSDAY -> "Thursday"
            Calendar.FRIDAY -> "Friday"
            Calendar.SATURDAY -> "Saturday"
            else -> ""
        }
        
        val dayNameKm = khmerDayOfWeek[dayNameEn] ?: dayNameEn
        val result = toLunar()
        val gregorianDayKh = replaceAll(day.toString(), khmerDigits)
        val gregorianMonthKh = GREGORIAN_MONTHS[month - 1]
        val gregorianYearKh = replaceAll(year.toString(), khmerDigits)
        return "ថ្ងៃ$dayNameKm ${result.lunarDay} ខែ${result.lunarMonth} ឆ្នាំ${result.zodiacYear} ${result.stem} ពុទ្ធសករាជ ${result.lunarYear} ត្រូវនឹងថ្ងៃទី$gregorianDayKh ខែ$gregorianMonthKh ឆ្នាំ$gregorianYearKh"
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
        
        val khmerDayOfWeek = mapOf(
            "Monday" to "ចន្ទ", "Tuesday" to "អង្គារ", "Wednesday" to "ពុធ",
            "Thursday" to "ព្រហស្បតិ៍", "Friday" to "សុក្រ", "Saturday" to "សៅរ៍", "Sunday" to "អាទិត្យ"
        )

        private val khmerDigits = mapOf(
            "0" to "០", "1" to "១", "2" to "២", "3" to "៣", "4" to "៤",
            "5" to "៥", "6" to "៦", "7" to "៧", "8" to "៨", "9" to "៩"
        )

        private val GREGORIAN_MONTHS = listOf(
            "មករា", "កុម្ភៈ", "មីនា", "មេសា", "ឧសភា", "មិថុនា", "កក្កដា", "សីហា", "កញ្ញា", "តុលា", "វិច្ឆិកា", "ធ្នូ"
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

        fun now(): KhmerDate {
            return KhmerDate(Date())
        }

        private fun isValidDate(day: Int, month: Int, year: Int): Boolean {
            if (month < 1 || month > 12) return false
            if (year < 1) return false
            
            val daysInMonth = intArrayOf(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
            if (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)) {
                daysInMonth[1] = 29
            }
            
            return day >= 1 && day <= daysInMonth[month - 1]
        }

        private fun replaceAll(text: String, dic: Map<String, String>): String {
            var result = text
            for ((key, value) in dic) {
                result = result.replace(key, value)
            }
            return result
        }

        private fun getBuddhistEraYearForCalculation(year: Int): Int {
            return year + 544
        }

        private fun getAharkun(year: Int): Int {
            return floor((getBuddhistEraYearForCalculation(year) * 292207.0 + 499.0) / 800.0).toInt() + 4
        }

        private fun getAvoman(year: Int): Int {
            return (11 * getAharkun(year) + 25) % 692
        }

        private fun getBodithey(year: Int): Int {
            val aharkun = getAharkun(year)
            return (floor((11.0 * aharkun + 25.0) / 692.0).toInt() + aharkun + 29) % 30
        }

        private fun isKhmerSolarLeapYear(year: Int): Boolean {
            val aharkunMod = (getBuddhistEraYearForCalculation(year) * 292207L + 499L) % 800L
            return 800L - aharkunMod <= 207L
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
            return if (hasLeapDay) 2 else 0
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
            return if (yearType == "leap-month") {
                KHMER_LEAP_MONTHS[normalizedMonth - 1]
            } else {
                KHMER_NORMAL_MONTHS[normalizedMonth - 1]
            }
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

        private fun isGregorianLeapYear(year: Int): Boolean {
            return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)
        }

        private fun getGregorianYearDays(year: Int): Int {
            return if (isGregorianLeapYear(year)) 366 else 365
        }

        private fun getDaysSinceStartOfYear(day: Int, month: Int, year: Int): Int {
            val cal1 = Calendar.getInstance().apply {
                set(year, month - 1, day, 0, 0, 0)
                set(Calendar.MILLISECOND, 0)
            }
            val cal2 = Calendar.getInstance().apply {
                set(year, 0, 1, 0, 0, 0)
                set(Calendar.MILLISECOND, 0)
            }
            val diff = cal1.timeInMillis - cal2.timeInMillis
            return (diff / 86400000L).toInt()
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
            
            val cursor = Calendar.getInstance().apply {
                set(year, 3, 10, 0, 0, 0)
                set(Calendar.MILLISECOND, 0)
            }
            val end = Calendar.getInstance().apply {
                set(year, 4, 31, 0, 0, 0)
                set(Calendar.MILLISECOND, 0)
            }
            
            while (cursor.timeInMillis <= end.timeInMillis) {
                val yearStart = getKhmerCivilDateAtGregorianYearStart(year)
                val daysSinceStart = getDaysSinceStartOfYear(
                    cursor.get(Calendar.DAY_OF_MONTH),
                    cursor.get(Calendar.MONTH) + 1,
                    year
                )
                val civilDate = advanceKhmerCivilDate(yearStart.first, yearStart.second, year, daysSinceStart)
                
                if (civilDate.first == targetKhmerMonth && civilDate.second == targetMonthDay) {
                    return cursor.time
                }
                cursor.add(Calendar.DAY_OF_MONTH, 1)
            }
            
            val fallback = Calendar.getInstance().apply {
                set(year, 4, 15, 0, 0, 0)
                set(Calendar.MILLISECOND, 0)
            }
            return fallback.time
        }

        private fun getKhmerZodiacYear(year: Int): String {
            return KHMER_ZODIAC[((year - 2020) % 12 + 12) % 12]
        }

        private fun getKhmerStem(year: Int): String {
            return KHMER_STEMS[((year - 2019) % 10 + 10) % 10]
        }
    }
}
