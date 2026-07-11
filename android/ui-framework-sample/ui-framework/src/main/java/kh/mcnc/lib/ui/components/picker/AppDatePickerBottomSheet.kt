package kh.mcnc.lib.ui.components.picker

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ChevronLeft
import androidx.compose.material.icons.filled.ChevronRight
import androidx.compose.material.icons.filled.KeyboardArrowDown
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import kotlinx.coroutines.launch
import java.time.LocalDate
import java.time.YearMonth
import java.time.format.TextStyle
import java.util.Locale

enum class DatePickerMode {
    DAY, MONTH_YEAR
}

enum class DatePickerSelectionMode {
    SINGLE, RANGE, WEEK
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun AppDatePickerBottomSheet(
    showSheet: Boolean,
    onDismissRequest: () -> Unit,
    selectionMode: DatePickerSelectionMode = DatePickerSelectionMode.SINGLE,
    minDate: LocalDate? = null,
    maxDate: LocalDate? = null,
    initialDate: LocalDate? = LocalDate.now(),
    onDateSelected: (LocalDate) -> Unit = {},
    onRangeSelected: (LocalDate, LocalDate) -> Unit = { _, _ -> }
) {
    if (showSheet) {
        val sheetState = rememberModalBottomSheetState(skipPartiallyExpanded = true)
        
        ModalBottomSheet(
            onDismissRequest = onDismissRequest,
            sheetState = sheetState,
            containerColor = Color.White,
            shape = RoundedCornerShape(topStart = 24.dp, topEnd = 24.dp)
        ) {
            AppDatePickerContent(
                initialDate = initialDate,
                selectionMode = selectionMode,
                minDate = minDate,
                maxDate = maxDate,
                onApplySingle = {
                    onDateSelected(it)
                    onDismissRequest()
                },
                onApplyRange = { start, end ->
                    onRangeSelected(start, end)
                    onDismissRequest()
                },
                onCancel = onDismissRequest
            )
        }
    }
}

@Composable
fun AppDatePickerContent(
    initialDate: LocalDate?,
    selectionMode: DatePickerSelectionMode,
    minDate: LocalDate?,
    maxDate: LocalDate?,
    onApplySingle: (LocalDate) -> Unit,
    onApplyRange: (LocalDate, LocalDate) -> Unit,
    onCancel: () -> Unit
) {
    var mode by remember { mutableStateOf(DatePickerMode.DAY) }
    
    val baseDateForMonth = initialDate ?: LocalDate.now()
    var currentMonth by remember { mutableStateOf(YearMonth.from(baseDateForMonth)) }
    
    var startDate by remember { mutableStateOf<LocalDate?>(initialDate) }
    var endDate by remember { mutableStateOf<LocalDate?>(null) }

    Column(
        modifier = Modifier
            .fillMaxWidth()
            .padding(horizontal = 24.dp, vertical = 16.dp)
    ) {
        if (mode == DatePickerMode.DAY) {
            Row(
                modifier = Modifier.fillMaxWidth().padding(bottom = 24.dp),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Text(
                    text = when (selectionMode) {
                        DatePickerSelectionMode.SINGLE -> "Select Date"
                        DatePickerSelectionMode.RANGE -> "Select Range"
                        DatePickerSelectionMode.WEEK -> "Select Week"
                    },
                    style = MaterialTheme.typography.titleLarge,
                    fontWeight = FontWeight.Bold,
                    color = Color(0xFF1E3A8A) // Dark blue
                )
                
                TextButton(onClick = {
                    val today = LocalDate.now()
                    currentMonth = YearMonth.from(today)
                    when (selectionMode) {
                        DatePickerSelectionMode.SINGLE -> {
                            startDate = today
                            endDate = null
                        }
                        DatePickerSelectionMode.RANGE -> {
                            startDate = today
                            endDate = null
                        }
                        DatePickerSelectionMode.WEEK -> {
                            val startOfWeek = today.minusDays((today.dayOfWeek.value % 7).toLong())
                            val endOfWeek = startOfWeek.plusDays(6)
                            startDate = startOfWeek
                            endDate = endOfWeek
                        }
                    }
                }) {
                    Text("Today", fontWeight = FontWeight.Bold, color = Color(0xFF1E3A8A))
                }
            }

            val coroutineScope = rememberCoroutineScope()
            val baseMonth = remember { YearMonth.from(baseDateForMonth) }
            val initialPage = 50000
            val pagerState = androidx.compose.foundation.pager.rememberPagerState(
                initialPage = initialPage + (currentMonth.year - baseMonth.year) * 12 + (currentMonth.monthValue - baseMonth.monthValue),
                pageCount = { 100000 }
            )

            // Sync pager when currentMonth changes from outside
            LaunchedEffect(currentMonth) {
                val expectedPage = initialPage + (currentMonth.year - baseMonth.year) * 12 + (currentMonth.monthValue - baseMonth.monthValue)
                if (pagerState.currentPage != expectedPage) {
                    pagerState.animateScrollToPage(expectedPage)
                }
            }

            // Sync currentMonth when user swipes pager
            LaunchedEffect(pagerState.currentPage) {
                val offset = pagerState.currentPage - initialPage
                val newMonth = baseMonth.plusMonths(offset.toLong())
                if (currentMonth != newMonth) {
                    currentMonth = newMonth
                }
            }

            // Month/Year Selector
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                IconButton(onClick = { currentMonth = currentMonth.minusMonths(1) }) {
                    Icon(Icons.Default.ChevronLeft, contentDescription = "Previous Month", tint = Color(0xFF1E3A8A))
                }

                Row(
                    verticalAlignment = Alignment.CenterVertically,
                    modifier = Modifier
                        .clip(RoundedCornerShape(8.dp))
                        .clickable { mode = DatePickerMode.MONTH_YEAR }
                        .padding(horizontal = 8.dp, vertical = 4.dp)
                ) {
                    val monthName = currentMonth.month.getDisplayName(TextStyle.FULL, Locale.ENGLISH).uppercase()
                    Text(
                        text = "$monthName ${currentMonth.year}",
                        style = MaterialTheme.typography.titleSmall,
                        fontWeight = FontWeight.Bold,
                        color = Color.Black
                    )
                    Spacer(modifier = Modifier.width(4.dp))
                    Icon(
                        imageVector = Icons.Default.KeyboardArrowDown,
                        contentDescription = "Select Month/Year",
                        tint = Color(0xFF1E3A8A),
                        modifier = Modifier.size(20.dp)
                    )
                }

                IconButton(onClick = { currentMonth = currentMonth.plusMonths(1) }) {
                    Icon(Icons.Default.ChevronRight, contentDescription = "Next Month", tint = Color(0xFF1E3A8A))
                }
            }

            Spacer(modifier = Modifier.height(16.dp))

            // Days of week header
            Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween) {
                val daysOfWeek = listOf("SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT")
                daysOfWeek.forEach { day ->
                    Text(
                        text = day,
                        style = MaterialTheme.typography.labelSmall,
                        fontWeight = FontWeight.Bold,
                        modifier = Modifier.weight(1f),
                        textAlign = TextAlign.Center,
                        color = Color.Black
                    )
                }
            }

            Spacer(modifier = Modifier.height(16.dp))

            // Swipeable Calendar Grid
            androidx.compose.foundation.pager.HorizontalPager(state = pagerState) { page ->
                val offset = page - initialPage
                val displayMonth = baseMonth.plusMonths(offset.toLong())
                
                val daysInMonth = displayMonth.lengthOfMonth()
                val firstDayOfWeek = displayMonth.atDay(1).dayOfWeek.value % 7 // 0 for Sunday
                val daysInPrevMonth = displayMonth.minusMonths(1).lengthOfMonth()
                
                val calendarCells = mutableListOf<CalendarDay>()
                // Previous month trailing days
                for (i in firstDayOfWeek downTo 1) {
                    calendarCells.add(CalendarDay(daysInPrevMonth - i + 1, false, displayMonth.minusMonths(1)))
                }
                // Current month days
                for (i in 1..daysInMonth) {
                    calendarCells.add(CalendarDay(i, true, displayMonth))
                }
                // Next month leading days
                val remainingCells = 42 - calendarCells.size
                for (i in 1..remainingCells) {
                    calendarCells.add(CalendarDay(i, false, displayMonth.plusMonths(1)))
                }

                LazyVerticalGrid(
                    columns = GridCells.Fixed(7),
                    modifier = Modifier.heightIn(max = 300.dp)
                ) {
                    items(calendarCells.take(if (calendarCells.size > 35 && calendarCells[35].isCurrentMonth) 42 else 35)) { dayInfo ->
                        val date = dayInfo.yearMonth.atDay(dayInfo.day)
                        val isToday = LocalDate.now() == date
                        
                        // Disable logic
                        val isBeforeMin = minDate != null && date.isBefore(minDate)
                        val isAfterMax = maxDate != null && date.isAfter(maxDate)
                        val isDisabled = isBeforeMin || isAfterMax

                        // Selection logic
                        val isStart = startDate == date
                        val isEnd = endDate == date
                        val isSingleSelected = selectionMode == DatePickerSelectionMode.SINGLE && isStart
                        val isRangeSelected = selectionMode != DatePickerSelectionMode.SINGLE && 
                                              startDate != null && endDate != null && 
                                              (date.isAfter(startDate!!) && date.isBefore(endDate!!))

                        // Drawing styles for range
                        val boxModifier = Modifier.aspectRatio(1f).padding(vertical = 4.dp)
                        val innerModifier = if (isRangeSelected) {
                            Modifier.fillMaxSize().background(Color(0xFFDBEAFE)) // light blue
                        } else if ((isStart && endDate != null && startDate != endDate) || (isEnd && startDate != endDate)) {
                            // Half background for range edges
                            val shape = if (isStart) RoundedCornerShape(topStartPercent = 50, bottomStartPercent = 50) 
                                        else RoundedCornerShape(topEndPercent = 50, bottomEndPercent = 50)
                            Modifier.fillMaxSize().background(Color(0xFFDBEAFE), shape = shape)
                        } else {
                            Modifier.fillMaxSize()
                        }

                        Box(modifier = boxModifier.then(innerModifier), contentAlignment = Alignment.Center) {
                            Box(
                                modifier = Modifier
                                    .padding(4.dp)
                                    .fillMaxSize()
                                    .clip(CircleShape)
                                    .background(if (isStart || isEnd) Color(0xFF1E3A8A) else Color.Transparent)
                                    .border(
                                        width = if (isToday && !(isStart || isEnd || isRangeSelected)) 1.dp else 0.dp,
                                        color = if (isToday && !(isStart || isEnd || isRangeSelected)) Color(0xFFD1D5DB) else Color.Transparent,
                                        shape = CircleShape
                                    )
                                    .clickable(enabled = !isDisabled) {
                                        if (selectionMode == DatePickerSelectionMode.SINGLE) {
                                            startDate = date
                                        } else if (selectionMode == DatePickerSelectionMode.WEEK) {
                                            val startOfWeek = date.minusDays((date.dayOfWeek.value % 7).toLong())
                                            val endOfWeek = startOfWeek.plusDays(6)
                                            startDate = startOfWeek
                                            endDate = endOfWeek
                                        } else {
                                            // RANGE
                                            if (startDate == null || (startDate != null && endDate != null)) {
                                                startDate = date
                                                endDate = null
                                            } else if (startDate != null && endDate == null) {
                                                if (date.isBefore(startDate)) {
                                                    startDate = date
                                                } else {
                                                    endDate = date
                                                }
                                            }
                                        }
                                        
                                        if (!dayInfo.isCurrentMonth) {
                                            currentMonth = dayInfo.yearMonth
                                        }
                                    },
                                contentAlignment = Alignment.Center
                            ) {
                                Text(
                                    text = dayInfo.day.toString(),
                                    style = MaterialTheme.typography.bodyMedium,
                                    color = when {
                                        isStart || isEnd -> Color.White
                                        isDisabled -> Color(0xFFE5E7EB) // Very light gray for disabled
                                        !dayInfo.isCurrentMonth -> Color(0xFF9CA3AF) // Gray
                                        else -> Color.Black
                                    }
                                )
                            }
                        }
                    }
                }
            }
            
            Spacer(modifier = Modifier.height(16.dp))
            
            // Action Buttons
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.End
            ) {
                TextButton(onClick = onCancel) {
                    Text("Cancel", color = Color.Gray)
                }
                Spacer(modifier = Modifier.width(16.dp))
                Button(
                    onClick = {
                        if (selectionMode == DatePickerSelectionMode.SINGLE && startDate != null) {
                            onApplySingle(startDate!!)
                        } else if (startDate != null && endDate != null) {
                            onApplyRange(startDate!!, endDate!!)
                        } else if (startDate != null && endDate == null) {
                            // If they only selected start date in range mode, apply as single day range
                            onApplyRange(startDate!!, startDate!!)
                        }
                    },
                    colors = ButtonDefaults.buttonColors(containerColor = Color(0xFF1E3A8A))
                ) {
                    Text("Apply")
                }
            }
            
            Spacer(modifier = Modifier.height(8.dp))
        } else {
            // MONTH_YEAR MODE
            Text(
                text = "Month & Year",
                style = MaterialTheme.typography.titleLarge,
                fontWeight = FontWeight.Bold,
                color = Color(0xFF1E3A8A),
                modifier = Modifier.padding(bottom = 24.dp)
            )

            // Year Selector
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                IconButton(onClick = { currentMonth = currentMonth.minusYears(1) }) {
                    Icon(Icons.Default.ChevronLeft, contentDescription = "Previous Year", tint = Color(0xFF1E3A8A))
                }

                Text(
                    text = currentMonth.year.toString(),
                    style = MaterialTheme.typography.titleMedium,
                    fontWeight = FontWeight.Bold,
                    color = Color.Black
                )

                IconButton(onClick = { currentMonth = currentMonth.plusYears(1) }) {
                    Icon(Icons.Default.ChevronRight, contentDescription = "Next Year", tint = Color(0xFF1E3A8A))
                }
            }

            Spacer(modifier = Modifier.height(24.dp))

            // Month Grid
            val months = listOf("JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC")
            
            LazyVerticalGrid(
                columns = GridCells.Fixed(4),
                modifier = Modifier.heightIn(max = 200.dp),
                horizontalArrangement = Arrangement.spacedBy(8.dp),
                verticalArrangement = Arrangement.spacedBy(16.dp)
            ) {
                items(months.size) { index ->
                    val isSelected = currentMonth.monthValue == (index + 1)
                    
                    Box(
                        modifier = Modifier
                            .height(40.dp)
                            .clip(RoundedCornerShape(20.dp))
                            .background(if (isSelected) Color(0xFF1E3A8A) else Color.Transparent)
                            .clickable {
                                currentMonth = currentMonth.withMonth(index + 1)
                                mode = DatePickerMode.DAY
                            },
                        contentAlignment = Alignment.Center
                    ) {
                        Text(
                            text = months[index],
                            style = MaterialTheme.typography.bodyMedium,
                            fontWeight = if (isSelected) FontWeight.Bold else FontWeight.Normal,
                            color = if (isSelected) Color.White else Color.Black
                        )
                    }
                }
            }
            Spacer(modifier = Modifier.height(32.dp))
        }
    }
}

data class CalendarDay(
    val day: Int,
    val isCurrentMonth: Boolean,
    val yearMonth: YearMonth
)
