package kh.mcnc.lib.ui.components.calendar

import kh.mcnc.lib.ui.KhmerDate
import java.util.Calendar
import java.util.Date

data class CalendarDay(
    val date: Date,
    val gregorianDay: Int,
    val isCurrentMonth: Boolean,
    val isToday: Boolean,
    val khmerDate: kh.mcnc.lib.ui.IKhmerDate,
    val isSunday: Boolean,
    val isEnabled: Boolean,
    val isHidden: Boolean,
    val isSpecial: Boolean = false
)

sealed class SelectionMode {
    object Single : SelectionMode()
    object Range : SelectionMode()
    object Week : SelectionMode()
}

data class CalendarConfig(
    val firstDayOfWeek: Int = Calendar.MONDAY,
    val showAdjacentMonths: Boolean = true,
    val extraWeeksBefore: Int = 0,
    val extraWeeksAfter: Int = 0,
    val fixedWeekCount: Int? = 6,
    val minDate: Date? = null,
    val maxDate: Date? = null,
    val selectionMode: SelectionMode = SelectionMode.Single,
    val specialDates: List<Date> = emptyList()
)

class CalendarState(val config: CalendarConfig = CalendarConfig()) {
    
    private fun isSameDay(date1: Date, date2: Date): Boolean {
        val cal1 = Calendar.getInstance().apply { time = date1 }
        val cal2 = Calendar.getInstance().apply { time = date2 }
        return cal1.get(Calendar.YEAR) == cal2.get(Calendar.YEAR) &&
               cal1.get(Calendar.DAY_OF_YEAR) == cal2.get(Calendar.DAY_OF_YEAR)
    }
    
    private val cache = mutableMapOf<Pair<Int, Int>, List<CalendarDay>>()
    
    fun generateDaysForMonth(year: Int, month: Int): List<CalendarDay> {
        val cacheKey = Pair(year, month)
        if (cache.containsKey(cacheKey)) {
            return cache[cacheKey]!!
        }
        
        val days = mutableListOf<CalendarDay>()
        
        val cal = Calendar.getInstance()
        cal.set(Calendar.YEAR, year)
        cal.set(Calendar.MONTH, month - 1)
        cal.set(Calendar.DAY_OF_MONTH, 1)
        
        val dayOfWeek = cal.get(Calendar.DAY_OF_WEEK)
        
        // Calculate offset based on firstDayOfWeek config
        val offset = if (config.firstDayOfWeek == Calendar.MONDAY) {
            if (dayOfWeek == Calendar.SUNDAY) 6 else dayOfWeek - 2
        } else {
            // Sunday first
            dayOfWeek - 1
        }
        
        cal.add(Calendar.DAY_OF_MONTH, -offset)
        cal.add(Calendar.DAY_OF_MONTH, -(config.extraWeeksBefore * 7))
        
        val endCal = Calendar.getInstance()
        endCal.set(Calendar.YEAR, year)
        endCal.set(Calendar.MONTH, month - 1)
        endCal.set(Calendar.DAY_OF_MONTH, endCal.getActualMaximum(Calendar.DAY_OF_MONTH))
        
        val endDayOfWeek = endCal.get(Calendar.DAY_OF_WEEK)
        val endOffset = if (config.firstDayOfWeek == Calendar.MONDAY) {
            if (endDayOfWeek == Calendar.SUNDAY) 0 else 7 - (endDayOfWeek - 1)
        } else {
            if (endDayOfWeek == Calendar.SATURDAY) 0 else 7 - endDayOfWeek
        }
        
        endCal.add(Calendar.DAY_OF_MONTH, endOffset)
        endCal.add(Calendar.DAY_OF_MONTH, config.extraWeeksAfter * 7)
        
        // Calculate total days required to cover the month's weeks
        var totalDays = 0
        val temp = Calendar.getInstance().apply { time = cal.time }
        // Set both to noon to avoid DST skips
        temp.set(Calendar.HOUR_OF_DAY, 12)
        val tempEnd = Calendar.getInstance().apply { time = endCal.time }
        tempEnd.set(Calendar.HOUR_OF_DAY, 12)
        
        while (temp.timeInMillis <= tempEnd.timeInMillis) {
            totalDays++
            temp.add(Calendar.DAY_OF_MONTH, 1)
        }
        
        // If we want a fixed week grid, balance the padding
        if (config.fixedWeekCount != null) {
            val targetDays = config.fixedWeekCount * 7
            if (totalDays < targetDays) {
                val daysToPad = targetDays - totalDays
                val weeksToPad = daysToPad / 7
                
                // Try to distribute weeks evenly, preferring to pad the front if it's completely empty of previous month days
                val padBeforeWeeks = if (offset == 0 && weeksToPad >= 1) {
                    1
                } else {
                    weeksToPad / 2
                }
                
                // Shift the start date back by the padBeforeWeeks
                cal.add(Calendar.DAY_OF_MONTH, -(padBeforeWeeks * 7))
                
                totalDays = targetDays
            }
        }
        
        val today = Calendar.getInstance()
        
        // Ensure time is 00:00:00 for bounds checking
        val minCal = config.minDate?.let { 
            Calendar.getInstance().apply { 
                time = it
                set(Calendar.HOUR_OF_DAY, 0)
                set(Calendar.MINUTE, 0)
                set(Calendar.SECOND, 0)
                set(Calendar.MILLISECOND, 0)
            } 
        }
        val maxCal = config.maxDate?.let { 
            Calendar.getInstance().apply { 
                time = it
                set(Calendar.HOUR_OF_DAY, 23)
                set(Calendar.MINUTE, 59)
                set(Calendar.SECOND, 59)
                set(Calendar.MILLISECOND, 999)
            } 
        }
        
        for (i in 0 until totalDays) {
            val d = cal.get(Calendar.DAY_OF_MONTH)
            val m = cal.get(Calendar.MONTH) + 1
            val y = cal.get(Calendar.YEAR)
            val isCurrentMonth = m == month
            
            val isToday = d == today.get(Calendar.DAY_OF_MONTH) &&
                          m == today.get(Calendar.MONTH) + 1 &&
                          y == today.get(Calendar.YEAR)
                          
            val isSunday = cal.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY
            
            val khmerDate = KhmerDate(d, m, y).toLunar()
            
            // Check bounds
            var isEnabled = true
            if (minCal != null && cal.timeInMillis < minCal.timeInMillis) isEnabled = false
            if (maxCal != null && cal.timeInMillis > maxCal.timeInMillis) isEnabled = false
            
            val isHidden = !isCurrentMonth && !config.showAdjacentMonths
            val isSpecial = config.specialDates.any { isSameDay(it, cal.time) }
            
            days.add(
                CalendarDay(
                    date = cal.time,
                    gregorianDay = d,
                    isCurrentMonth = isCurrentMonth,
                    isToday = isToday,
                    khmerDate = khmerDate,
                    isSunday = isSunday,
                    isEnabled = isEnabled,
                    isHidden = isHidden,
                    isSpecial = isSpecial
                )
            )
            cal.add(Calendar.DAY_OF_MONTH, 1)
        }
        
        cache[cacheKey] = days
        return days
    }
}
