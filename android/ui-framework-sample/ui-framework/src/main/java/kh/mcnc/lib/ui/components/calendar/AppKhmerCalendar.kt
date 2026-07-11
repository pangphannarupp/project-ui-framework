package kh.mcnc.lib.ui.components.calendar

import androidx.compose.animation.core.tween
import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import kh.mcnc.lib.ui.components.picker.AppMonthYearPickerBottomSheet
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.foundation.pager.HorizontalPager
import androidx.compose.foundation.pager.rememberPagerState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.KeyboardArrowLeft
import androidx.compose.material.icons.filled.KeyboardArrowRight
import androidx.compose.material.icons.filled.Today
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.Button
import androidx.compose.material3.DropdownMenu
import androidx.compose.material3.DropdownMenuItem
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.alpha
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.RectangleShape
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import kh.mcnc.lib.ui.KhmerDate
import kh.mcnc.lib.ui.theme.AppSpacing
import kh.mcnc.lib.ui.theme.AppTypography
import kotlinx.coroutines.launch
import java.util.*

@OptIn(ExperimentalFoundationApi::class)
@Composable
fun AppKhmerCalendar(
    modifier: Modifier = Modifier,
    config: CalendarConfig = CalendarConfig(),
    initialDate: Date = Date(),
    showActionButtons: Boolean = false,
    onDateSelected: (Date) -> Unit = {},
    onRangeSelected: (Date?, Date?) -> Unit = { _, _ -> },
    onMonthChanged: (Int, Int) -> Unit = { _, _ -> },
    onConfirm: (Date?, Date?) -> Unit = { _, _ -> },
    onCancel: () -> Unit = {}
) {
    val coroutineScope = rememberCoroutineScope()
    
    // Selection State
    var selectedDate by remember { mutableStateOf<Date?>(initialDate) }
    var rangeStartDate by remember { mutableStateOf<Date?>(null) }
    var rangeEndDate by remember { mutableStateOf<Date?>(null) }
    
    // Pager State
    val initialPage = 5000 // Middle point for infinite scrolling
    val pagerState = rememberPagerState(initialPage = initialPage, pageCount = { 10000 })
    
    val today = remember { Calendar.getInstance() }
    
    // Calculate current month/year based on pager offset from initialPage
    val currentMonthOffset = pagerState.currentPage - initialPage
    val currentCal = Calendar.getInstance().apply { 
        time = today.time
        add(Calendar.MONTH, currentMonthOffset) 
    }
    val currentMonth = currentCal.get(Calendar.MONTH) + 1
    val currentYear = currentCal.get(Calendar.YEAR)
    
    LaunchedEffect(currentMonth, currentYear) {
        onMonthChanged(currentYear, currentMonth)
    }
    
    val calendarState = remember(config) { CalendarState(config) }
    
    // Derived header info from the 1st of the current month
    var firstDayKhmer by remember { mutableStateOf<kh.mcnc.lib.ui.IKhmerDate?>(null) }
    LaunchedEffect(currentMonth, currentYear) {
        kotlinx.coroutines.withContext(kotlinx.coroutines.Dispatchers.IO) {
            val khmer = KhmerDate(1, currentMonth, currentYear).toLunar()
            firstDayKhmer = khmer
        }
    }
    
    val monthNames = listOf(
        "មករា", "កុម្ភៈ", "មីនា", "មេសា", "ឧសភា", "មិថុនា", 
        "កក្កដា", "សីហា", "កញ្ញា", "តុលា", "វិច្ឆិកា", "ធ្នូ"
    )

    Column(modifier = modifier.fillMaxWidth()) {
        // Header Row
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(vertical = AppSpacing.md),
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            var showMonthYearPicker by remember { mutableStateOf(false) }
            
            if (showMonthYearPicker) {
                AppMonthYearPickerBottomSheet(
                    isVisible = showMonthYearPicker,
                    onDismiss = { showMonthYearPicker = false },
                    initialMonth = currentMonth,
                    initialYear = currentYear,
                    onConfirm = { m, y ->
                        showMonthYearPicker = false
                        val selectedCal = Calendar.getInstance().apply {
                            set(Calendar.YEAR, y)
                            set(Calendar.MONTH, m - 1)
                            set(Calendar.DAY_OF_MONTH, 1)
                        }
                        val todayCal = Calendar.getInstance().apply {
                            time = today.time
                            set(Calendar.DAY_OF_MONTH, 1)
                        }
                        val diffYears = selectedCal.get(Calendar.YEAR) - todayCal.get(Calendar.YEAR)
                        val diffMonths = diffYears * 12 + selectedCal.get(Calendar.MONTH) - todayCal.get(Calendar.MONTH)
                        coroutineScope.launch {
                            pagerState.scrollToPage(initialPage + diffMonths)
                        }
                    }
                )
            }

            Text(
                text = "${monthNames[currentMonth - 1]} $currentYear",
                style = AppTypography.titleLarge,
                color = MaterialTheme.colorScheme.onBackground,
                modifier = Modifier.clickable {
                    showMonthYearPicker = true
                }
            )
            
            Row {
                IconButton(onClick = {
                    coroutineScope.launch {
                        pagerState.animateScrollToPage(pagerState.currentPage - 1)
                    }
                }) {
                    Icon(imageVector = Icons.Default.KeyboardArrowLeft, contentDescription = "Previous Month")
                }
                IconButton(onClick = {
                    coroutineScope.launch {
                        pagerState.scrollToPage(initialPage) // Go to today
                    }
                }) {
                    Icon(imageVector = Icons.Default.Today, contentDescription = "Today", tint = MaterialTheme.colorScheme.primary)
                }
                IconButton(onClick = {
                    coroutineScope.launch {
                        pagerState.animateScrollToPage(pagerState.currentPage + 1)
                    }
                }) {
                    Icon(imageVector = Icons.Default.KeyboardArrowRight, contentDescription = "Next Month")
                }
            }
        }
        
        // Subtitle Info
        if (firstDayKhmer != null) {
            Text(
                text = "ឆ្នាំ${firstDayKhmer!!.zodiacYear} ${firstDayKhmer!!.stem} ព.ស. ${firstDayKhmer!!.lunarYear}",
                style = AppTypography.bodyLarge,
                color = MaterialTheme.colorScheme.onBackground.copy(alpha = 0.7f),
                modifier = Modifier.padding(bottom = AppSpacing.md)
            )
        } else {
            // Placeholder while loading
            Box(modifier = Modifier
                .fillMaxWidth()
                .height(24.dp)
                .padding(bottom = AppSpacing.md))
        }
        
        // Days of Week
        Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceEvenly) {
            val daysOfWeek = if (config.firstDayOfWeek == Calendar.MONDAY) {
                listOf("ចន្ទ", "អង្គារ", "ពុធ", "ព្រហ.", "សុក្រ", "សៅរ៍", "អាទិត្យ")
            } else {
                listOf("អាទិត្យ", "ចន្ទ", "អង្គារ", "ពុធ", "ព្រហ.", "សុក្រ", "សៅរ៍")
            }
            
            daysOfWeek.forEachIndexed { index, day ->
                val isSun = if (config.firstDayOfWeek == Calendar.MONDAY) index == 6 else index == 0
                Text(
                    text = day,
                    style = AppTypography.labelLarge,
                    color = if (isSun) MaterialTheme.colorScheme.error else MaterialTheme.colorScheme.onBackground,
                    modifier = Modifier.weight(1f),
                    textAlign = TextAlign.Center
                )
            }
        }
        
        Spacer(modifier = Modifier.height(AppSpacing.sm))
        
        // Horizontal Pager for months
        HorizontalPager(
            state = pagerState,
            modifier = Modifier.fillMaxWidth()
        ) { page ->
            val pageOffset = page - initialPage
            val pageCal = Calendar.getInstance().apply { 
                time = today.time
                add(Calendar.MONTH, pageOffset) 
            }
            val pMonth = pageCal.get(Calendar.MONTH) + 1
            val pYear = pageCal.get(Calendar.YEAR)
            
            var days by remember { mutableStateOf<List<CalendarDay>>(emptyList()) }
            LaunchedEffect(pMonth, pYear, config) {
                kotlinx.coroutines.withContext(kotlinx.coroutines.Dispatchers.IO) {
                    val computed = calendarState.generateDaysForMonth(pYear, pMonth)
                    days = computed
                }
            }
            
            Column(modifier = Modifier.fillMaxWidth()) {
                if (days.isEmpty()) {
                    for (i in 0 until (config.fixedWeekCount ?: 6)) {
                        Row(modifier = Modifier.fillMaxWidth()) {
                            for (j in 0 until 7) {
                                Box(modifier = Modifier.weight(1f).height(74.dp).padding(4.dp)) {
                                    Box(
                                        modifier = Modifier
                                            .fillMaxSize()
                                            .clip(RoundedCornerShape(8.dp))
                                            .background(MaterialTheme.colorScheme.onBackground.copy(alpha = 0.05f))
                                    )
                                }
                            }
                        }
                    }
                } else {
                    val chunkedDays = days.chunked(7)
                    chunkedDays.forEach { week ->
                        Row(modifier = Modifier.fillMaxWidth()) {
                            week.forEach { day ->
                                val isSelected = when (config.selectionMode) {
                                    is SelectionMode.Single -> selectedDate?.let { isSameDay(it, day.date) } ?: false
                                    is SelectionMode.Range, is SelectionMode.Week -> {
                                        if (rangeStartDate != null && isSameDay(rangeStartDate!!, day.date)) true
                                        else if (rangeEndDate != null && isSameDay(rangeEndDate!!, day.date)) true
                                        else false
                                    }
                                }
                                
                                val isInRange = if ((config.selectionMode is SelectionMode.Range || config.selectionMode is SelectionMode.Week) && rangeStartDate != null && rangeEndDate != null) {
                                    day.date.after(rangeStartDate) && day.date.before(rangeEndDate)
                                } else false
                                
                                val isRangeStart = (config.selectionMode is SelectionMode.Range || config.selectionMode is SelectionMode.Week) && rangeStartDate != null && isSameDay(rangeStartDate!!, day.date)
                                val isRangeEnd = (config.selectionMode is SelectionMode.Range || config.selectionMode is SelectionMode.Week) && rangeEndDate != null && isSameDay(rangeEndDate!!, day.date)
                                
                                Box(modifier = Modifier.weight(1f)) {
                                    if (day.isHidden) {
                                        Box(modifier = Modifier.height(64.dp).padding(2.dp))
                                    } else {
                                         CalendarDayCell(
                                            day = day,
                                            isSelected = isSelected,
                                            isInRange = isInRange,
                                            isRangeStart = isRangeStart,
                                            isRangeEnd = isRangeEnd,
                                            onClick = { clickedDay ->
                                                if (!clickedDay.isEnabled || !clickedDay.isCurrentMonth) return@CalendarDayCell
                                                
                                                if (config.selectionMode is SelectionMode.Single) {
                                                    selectedDate = clickedDay.date
                                                    onDateSelected(clickedDay.date)
                                                } else if (config.selectionMode is SelectionMode.Week) {
                                                    val validWeekDays = week.filter { it.isEnabled && !it.isHidden }
                                                    if (validWeekDays.isNotEmpty()) {
                                                        rangeStartDate = validWeekDays.first().date
                                                        rangeEndDate = validWeekDays.last().date
                                                        onRangeSelected(rangeStartDate, rangeEndDate)
                                                    }
                                                } else {
                                                    // Range logic
                                                    if (rangeStartDate == null || (rangeStartDate != null && rangeEndDate != null)) {
                                                        // Start new range
                                                        rangeStartDate = clickedDay.date
                                                        rangeEndDate = null
                                                    } else if (rangeStartDate != null && rangeEndDate == null) {
                                                        if (clickedDay.date.before(rangeStartDate)) {
                                                            rangeStartDate = clickedDay.date
                                                        } else {
                                                            rangeEndDate = clickedDay.date
                                                            onRangeSelected(rangeStartDate, rangeEndDate)
                                                        }
                                                    }
                                                }
                                            }
                                        )
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
        if (showActionButtons) {
            Spacer(modifier = Modifier.height(16.dp))
            Row(
                modifier = Modifier.fillMaxWidth().padding(horizontal = 8.dp, vertical = 8.dp),
                horizontalArrangement = Arrangement.End
            ) {
                androidx.compose.material3.TextButton(onClick = { onCancel() }) {
                    Text("Cancel", style = AppTypography.labelLarge, color = MaterialTheme.colorScheme.onBackground)
                }
                Spacer(modifier = Modifier.width(16.dp))
                Button(
                    onClick = { 
                        if (config.selectionMode is SelectionMode.Single) {
                            onConfirm(selectedDate, null)
                        } else {
                            onConfirm(rangeStartDate, rangeEndDate)
                        }
                    },
                    colors = androidx.compose.material3.ButtonDefaults.buttonColors(
                        containerColor = MaterialTheme.colorScheme.error,
                        contentColor = Color.White
                    )
                ) {
                    Text("Confirm", style = AppTypography.labelLarge)
                }
            }
        }
    }
}

private fun isSameDay(date1: Date, date2: Date): Boolean {
    val cal1 = Calendar.getInstance().apply { time = date1 }
    val cal2 = Calendar.getInstance().apply { time = date2 }
    return cal1.get(Calendar.YEAR) == cal2.get(Calendar.YEAR) &&
           cal1.get(Calendar.DAY_OF_YEAR) == cal2.get(Calendar.DAY_OF_YEAR)
}

@Composable
fun CalendarDayCell(
    day: CalendarDay,
    isSelected: Boolean,
    isInRange: Boolean,
    isRangeStart: Boolean,
    isRangeEnd: Boolean,
    onClick: (CalendarDay) -> Unit
) {
    val lunarDayStr = day.khmerDate.lunarDay
    
    val textColor = when {
        !day.isEnabled -> MaterialTheme.colorScheme.onBackground.copy(alpha = 0.3f)
        !day.isCurrentMonth -> MaterialTheme.colorScheme.onBackground.copy(alpha = 0.3f)
        isSelected -> Color.White
        day.isSunday -> MaterialTheme.colorScheme.error
        else -> MaterialTheme.colorScheme.onBackground
    }
    
    val baseColor = MaterialTheme.colorScheme.error
    
    // Background for range (faint red)
    val rangeBgColor = if (isInRange || isRangeStart || isRangeEnd) baseColor.copy(alpha = 0.1f) else Color.Transparent
    
    // Inner circle for selection
    val circleColor = if (isSelected) baseColor else Color.Transparent
    
    Box(
        modifier = Modifier
            .height(74.dp)
            .fillMaxWidth() // Important for range background to connect across cells
            .background(
                color = rangeBgColor,
                shape = when {
                    isRangeStart && isRangeEnd -> RoundedCornerShape(8.dp) // Single day selected in range or week mode
                    isRangeStart -> RoundedCornerShape(topStart = 8.dp, bottomStart = 8.dp)
                    isRangeEnd -> RoundedCornerShape(topEnd = 8.dp, bottomEnd = 8.dp)
                    else -> RectangleShape // Contiguous in the middle
                }
            )
            .clickable(enabled = day.isEnabled) { onClick(day) }
            .alpha(if (day.isEnabled) 1f else 0.5f),
        contentAlignment = Alignment.Center
    ) {
        // The solid background for selected days (start/end or single select)
        if (isSelected) {
            Box(
                modifier = Modifier
                    .fillMaxSize()
                    .padding(2.dp)
                    .background(color = circleColor, shape = RoundedCornerShape(4.dp))
            )
        } else if (day.isToday) {
            // Outline for today if not selected
            Box(
                modifier = Modifier
                    .fillMaxSize()
                    .padding(2.dp)
                    .border(width = 1.dp, color = baseColor, shape = RoundedCornerShape(4.dp))
            )
        }
        
        // Inner content box
        Box(modifier = Modifier.fillMaxSize()) {
            // Special Event Dot
            if (day.isSpecial) {
                Box(
                    modifier = Modifier
                        .size(6.dp)
                        .align(Alignment.TopEnd)
                        .padding(top = 4.dp, end = 4.dp)
                        .background(Color(0xFFFFA000), shape = CircleShape)
                )
            }
            
            // Top Left: Lunar Day Number (with phase)
            Text(
                text = lunarDayStr,
                fontSize = 8.sp,
                color = if (isSelected) Color.White.copy(alpha = 0.9f) else textColor.copy(alpha = 0.7f),
                maxLines = 1,
                modifier = Modifier
                    .align(Alignment.TopStart)
                    .padding(start = 4.dp, top = 4.dp)
            )
            
            // Center: Gregorian Day
            Text(
                text = day.gregorianDay.toString(),
                fontSize = 18.sp,
                fontWeight = if (isSelected || day.isToday) FontWeight.Bold else FontWeight.Normal,
                color = if (isSelected) Color.White else textColor,
                modifier = Modifier
                    .align(Alignment.Center)
            )
            
            // Bottom Center: Lunar Month
            Text(
                text = day.khmerDate.lunarMonth,
                fontSize = 8.sp,
                color = if (isSelected) Color.White.copy(alpha = 0.9f) else textColor.copy(alpha = 0.7f),
                maxLines = 1,
                modifier = Modifier
                    .align(Alignment.BottomCenter)
                    .padding(bottom = 4.dp)
            )
        }
    }
}

@Preview(showBackground = true)
@Composable
fun AppKhmerCalendarPreview() {
    kh.mcnc.lib.ui.theme.AppTheme {
        AppKhmerCalendar(
            modifier = Modifier.padding(16.dp),
            config = CalendarConfig(
                firstDayOfWeek = Calendar.MONDAY,
                showAdjacentMonths = true,
                selectionMode = SelectionMode.Range
            )
        )
    }
}
