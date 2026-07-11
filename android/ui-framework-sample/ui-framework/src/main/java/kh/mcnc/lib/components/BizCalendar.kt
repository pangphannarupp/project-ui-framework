package kh.mcnc.lib.components

import androidx.compose.animation.AnimatedContent
import androidx.compose.animation.ExperimentalAnimationApi
import androidx.compose.animation.SizeTransform
import androidx.compose.animation.core.tween
import androidx.compose.animation.slideInHorizontally
import androidx.compose.animation.slideOutHorizontally
import androidx.compose.animation.with
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ChevronLeft
import androidx.compose.material.icons.filled.ChevronRight
import androidx.compose.material.icons.filled.Today
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import kh.mcnc.lib.utils.CalendarConfig
import kh.mcnc.lib.utils.CalendarDay
import kh.mcnc.lib.utils.CalendarState
import kh.mcnc.lib.utils.SelectionMode
import java.util.Calendar
import java.util.Date

@OptIn(ExperimentalAnimationApi::class)
@Composable
fun BizCalendar(
    config: CalendarConfig = CalendarConfig(),
    initialDate: Date = Date(),
    showActionButtons: Boolean = false,
    onDateSelected: ((Date) -> Unit)? = null,
    onRangeSelected: ((start: Date?, end: Date?) -> Unit)? = null,
    onMonthChanged: ((year: Int, month: Int) -> Unit)? = null,
    onCancel: (() -> Unit)? = null,
    onConfirm: ((start: Date?, end: Date?) -> Unit)? = null
) {
    val primaryColor = Color(0xFF1A2A5E)
    val dangerColor = Color(0xFFFF4D4F)
    val rangeBgColor = dangerColor.copy(alpha = 0.1f)
    
    var currentMonth by remember(initialDate) { mutableStateOf(Calendar.getInstance().apply { time = initialDate }.get(Calendar.MONTH) + 1) }
    var currentYear by remember(initialDate) { mutableStateOf(Calendar.getInstance().apply { time = initialDate }.get(Calendar.YEAR)) }
    
    var selectedDate by remember(initialDate) { mutableStateOf<Date?>(initialDate) }
    var rangeStartDate by remember { mutableStateOf<Date?>(null) }
    var rangeEndDate by remember { mutableStateOf<Date?>(null) }
    
    val calendarState = remember(config) { CalendarState(config) }
    var days by remember { mutableStateOf(emptyList<CalendarDay>()) }
    var isLoading by remember { mutableStateOf(false) }
    
    var transitionDirection by remember { mutableStateOf(1) } // 1 for next, -1 for prev
    
    val monthNames = listOf(
        "Jan", "Feb", "Mar", "Apr", "May", "Jun", 
        "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    )
    
    val daysOfWeek = if (config.firstDayOfWeek == 1) {
        listOf("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun")
    } else {
        listOf("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")
    }

    LaunchedEffect(currentMonth, currentYear, calendarState) {
        isLoading = true
        kotlinx.coroutines.withContext(kotlinx.coroutines.Dispatchers.Default) {
            val newDays = calendarState.generateDaysForMonth(currentYear, currentMonth)
            days = newDays
        }
        isLoading = false
        onMonthChanged?.invoke(currentYear, currentMonth)
    }

    fun isSameDay(d1: Date?, d2: Date?): Boolean {
        if (d1 == null || d2 == null) return false
        val cal1 = Calendar.getInstance().apply { time = d1 }
        val cal2 = Calendar.getInstance().apply { time = d2 }
        return cal1.get(Calendar.YEAR) == cal2.get(Calendar.YEAR) &&
               cal1.get(Calendar.MONTH) == cal2.get(Calendar.MONTH) &&
               cal1.get(Calendar.DAY_OF_MONTH) == cal2.get(Calendar.DAY_OF_MONTH)
    }

    fun nextMonth() {
        transitionDirection = 1
        if (currentMonth == 12) {
            currentMonth = 1
            currentYear += 1
        } else {
            currentMonth += 1
        }
    }

    fun prevMonth() {
        transitionDirection = -1
        if (currentMonth == 1) {
            currentMonth = 12
            currentYear -= 1
        } else {
            currentMonth -= 1
        }
    }

    fun goToToday() {
        transitionDirection = 1
        val today = Calendar.getInstance()
        currentMonth = today.get(Calendar.MONTH) + 1
        currentYear = today.get(Calendar.YEAR)
    }

    fun onDayClick(day: CalendarDay) {
        if (!day.isEnabled || !day.isCurrentMonth) return
        
        when (config.selectionMode) {
            SelectionMode.Single -> {
                selectedDate = day.date
                onDateSelected?.invoke(day.date)
            }
            SelectionMode.Week -> {
                val index = days.indexOfFirst { isSameDay(it.date, day.date) }
                if (index != -1) {
                    val rowStart = (index / 7) * 7
                    val weekDays = days.subList(rowStart, Math.min(rowStart + 7, days.size)).filter { it.isEnabled && !it.isHidden }
                    if (weekDays.isNotEmpty()) {
                        rangeStartDate = weekDays.first().date
                        rangeEndDate = weekDays.last().date
                        onRangeSelected?.invoke(rangeStartDate, rangeEndDate)
                    }
                }
            }
            SelectionMode.Range -> {
                if (rangeStartDate == null || (rangeStartDate != null && rangeEndDate != null)) {
                    rangeStartDate = day.date
                    rangeEndDate = null
                } else if (rangeStartDate != null && rangeEndDate == null) {
                    if (day.date.time < rangeStartDate!!.time) {
                        rangeStartDate = day.date
                    } else {
                        rangeEndDate = day.date
                        onRangeSelected?.invoke(rangeStartDate, rangeEndDate)
                    }
                }
            }
        }
    }

    Column(modifier = Modifier
        .fillMaxWidth()
        .background(Color.White)
        .padding(16.dp)) {
        
        // Header
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(vertical = 16.dp),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically
        ) {
            Text(
                text = "${monthNames[currentMonth - 1]} $currentYear",
                fontSize = 18.sp,
                fontWeight = FontWeight.SemiBold,
                color = primaryColor,
                modifier = Modifier.clickable { /* TODO: Show Month Picker */ }
            )
            Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                IconButton(onClick = { prevMonth() }) {
                    Icon(Icons.Default.ChevronLeft, contentDescription = "Previous Month", tint = primaryColor)
                }
                IconButton(onClick = { goToToday() }) {
                    Icon(Icons.Default.Today, contentDescription = "Today", tint = primaryColor)
                }
                IconButton(onClick = { nextMonth() }) {
                    Icon(Icons.Default.ChevronRight, contentDescription = "Next Month", tint = primaryColor)
                }
            }
        }

        // Weekdays
        Row(modifier = Modifier.fillMaxWidth().padding(bottom = 8.dp)) {
            daysOfWeek.forEachIndexed { index, dayName ->
                val isSunday = if (config.firstDayOfWeek == 1) index == 6 else index == 0
                Text(
                    text = dayName,
                    modifier = Modifier.weight(1f),
                    textAlign = TextAlign.Center,
                    fontSize = 13.sp,
                    fontWeight = FontWeight.SemiBold,
                    color = if (isSunday) dangerColor else primaryColor
                )
            }
        }

        // Calendar Grid
        AnimatedContent(
            targetState = "$currentYear-$currentMonth",
            transitionSpec = {
                if (transitionDirection > 0) {
                    slideInHorizontally(animationSpec = tween(300)) { width -> width } with
                    slideOutHorizontally(animationSpec = tween(300)) { width -> -width }
                } else {
                    slideInHorizontally(animationSpec = tween(300)) { width -> -width } with
                    slideOutHorizontally(animationSpec = tween(300)) { width -> width }
                }.using(SizeTransform(clip = false))
            }
        ) { _ ->
            Column(modifier = Modifier.fillMaxWidth()) {
                if (isLoading) {
                    val chunks = (0 until 42).chunked(7)
                    chunks.forEach { week ->
                        Row(modifier = Modifier.fillMaxWidth()) {
                            week.forEach { _ ->
                                Box(
                                    modifier = Modifier
                                        .weight(1f)
                                        .height(64.dp)
                                        .padding(vertical = 2.dp)
                                ) {
                                    BizSkeletonText(
                                        modifier = Modifier
                                            .fillMaxSize()
                                            .padding(horizontal = 2.dp)
                                            .clip(RoundedCornerShape(4.dp))
                                    )
                                }
                            }
                        }
                    }
                } else {
                    val chunks = days.chunked(7)
                    chunks.forEach { week ->
                        Row(modifier = Modifier.fillMaxWidth()) {
                            week.forEach { day ->
                                val isSelected = when (config.selectionMode) {
                                    SelectionMode.Single -> isSameDay(selectedDate, day.date)
                                    else -> isSameDay(rangeStartDate, day.date) || isSameDay(rangeEndDate, day.date)
                                }
                                val isRangeStart = config.selectionMode != SelectionMode.Single && isSameDay(rangeStartDate, day.date)
                                val isRangeEnd = config.selectionMode != SelectionMode.Single && isSameDay(rangeEndDate, day.date)
                                val isInRange = config.selectionMode != SelectionMode.Single && rangeStartDate != null && rangeEndDate != null &&
                                        day.date.time > rangeStartDate!!.time && day.date.time < rangeEndDate!!.time
    
                                Box(
                                    modifier = Modifier
                                        .weight(1f)
                                        .height(64.dp)
                                        .padding(vertical = 2.dp)
                                        .clickable(enabled = day.isEnabled && day.isCurrentMonth) { onDayClick(day) },
                                    contentAlignment = Alignment.Center
                                ) {
                                    if (!day.isHidden) {
                                        // Range backgrounds
                                        if (isInRange) {
                                            Box(modifier = Modifier.fillMaxSize().background(rangeBgColor))
                                        }
                                        if (isRangeStart && rangeEndDate != null && !isSameDay(rangeStartDate, rangeEndDate)) {
                                            Box(modifier = Modifier.fillMaxSize().padding(start = 32.dp).background(rangeBgColor))
                                        }
                                        if (isRangeEnd && rangeStartDate != null && !isSameDay(rangeStartDate, rangeEndDate)) {
                                            Box(modifier = Modifier.fillMaxSize().padding(end = 32.dp).background(rangeBgColor))
                                        }
    
                                        // Day content background
                                        val contentModifier = Modifier
                                            .fillMaxSize()
                                            .padding(horizontal = 2.dp)
                                            .clip(RoundedCornerShape(4.dp))
                                            .then(
                                                if (isSelected) Modifier.background(dangerColor)
                                                else if (day.isToday && !isSelected) Modifier.border(1.dp, dangerColor, RoundedCornerShape(4.dp))
                                                else Modifier
                                            )
                                            
                                        Box(modifier = contentModifier, contentAlignment = Alignment.Center) {
                                            if (day.isSpecial) {
                                                Box(modifier = Modifier.align(Alignment.TopEnd).padding(4.dp).size(6.dp).background(Color(0xFFFFA000), CircleShape))
                                            }
                                            
                                            Text(
                                                text = day.gregorianDay.toString(),
                                                fontSize = 18.sp,
                                                color = if (isSelected) Color.White 
                                                        else if (!day.isEnabled || !day.isCurrentMonth) primaryColor.copy(alpha = 0.3f)
                                                        else if (day.isSunday) dangerColor 
                                                        else primaryColor
                                            )
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        if (showActionButtons) {
            Row(
                modifier = Modifier.fillMaxWidth().padding(top = 16.dp),
                horizontalArrangement = Arrangement.End
            ) {
                TextButton(onClick = { onCancel?.invoke() }) {
                    Text("Cancel", color = primaryColor, fontWeight = FontWeight.SemiBold)
                }
                Spacer(modifier = Modifier.width(16.dp))
                Button(
                    onClick = { onConfirm?.invoke(if (config.selectionMode == SelectionMode.Single) selectedDate else rangeStartDate, if (config.selectionMode == SelectionMode.Single) null else rangeEndDate) },
                    colors = ButtonDefaults.buttonColors(containerColor = dangerColor)
                ) {
                    Text("Confirm", color = Color.White, fontWeight = FontWeight.SemiBold)
                }
            }
        }
    }
}
