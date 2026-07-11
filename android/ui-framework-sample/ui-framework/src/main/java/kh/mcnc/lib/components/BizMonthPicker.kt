package kh.mcnc.lib.components

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import kh.mcnc.lib.utils.CalendarConfig
import kh.mcnc.lib.utils.SelectionMode
import java.util.Calendar
import java.util.Date

data class MonthSelection(val year: Int, val month: Int)

@Composable
fun BizMonthPicker(
    config: CalendarConfig = CalendarConfig(),
    initialDate: Date = Date(),
    showActionButtons: Boolean = false,
    onMonthSelected: ((MonthSelection) -> Unit)? = null,
    onRangeSelected: ((MonthSelection?, MonthSelection?) -> Unit)? = null,
    onYearChanged: ((Int) -> Unit)? = null,
    onCancel: (() -> Unit)? = null,
    onConfirm: ((MonthSelection?, MonthSelection?) -> Unit)? = null
) {
    val primaryColor = Color(0xFF1A2A5E)
    val primaryLight = Color(0xFF003399)
    val dangerColor = Color(0xFFFF4D4F)
    val rangeBgColor = dangerColor.copy(alpha = 0.1f)
    
    val initialCal = Calendar.getInstance().apply { time = initialDate }
    var currentYear by remember(initialDate) { mutableStateOf(initialCal.get(Calendar.YEAR)) }
    
    var selectedMonth by remember(initialDate) { 
        mutableStateOf<MonthSelection?>(MonthSelection(initialCal.get(Calendar.YEAR), initialCal.get(Calendar.MONTH) + 1)) 
    }
    var rangeStartMonth by remember { mutableStateOf<MonthSelection?>(null) }
    var rangeEndMonth by remember { mutableStateOf<MonthSelection?>(null) }
    
    val monthNames = listOf(
        "Jan", "Feb", "Mar", "Apr", "May", "Jun",
        "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    )
    
    val todayCal = Calendar.getInstance()
    val todayYear = todayCal.get(Calendar.YEAR)
    val todayMonth = todayCal.get(Calendar.MONTH) + 1
    
    fun isEnabled(year: Int, month: Int): Boolean {
        if (config.minDate != null) {
            val minCal = Calendar.getInstance().apply { time = config.minDate }
            val minYear = minCal.get(Calendar.YEAR)
            val minM = minCal.get(Calendar.MONTH) + 1
            if (year < minYear || (year == minYear && month < minM)) return false
        }
        if (config.maxDate != null) {
            val maxCal = Calendar.getInstance().apply { time = config.maxDate }
            val maxYear = maxCal.get(Calendar.YEAR)
            val maxM = maxCal.get(Calendar.MONTH) + 1
            if (year > maxYear || (year == maxYear && month > maxM)) return false
        }
        return true
    }
    
    fun isMonthBefore(m1: MonthSelection, m2: MonthSelection): Boolean {
        return m1.year < m2.year || (m1.year == m2.year && m1.month < m2.month)
    }
    
    fun isMonthAfter(m1: MonthSelection, m2: MonthSelection): Boolean {
        return m1.year > m2.year || (m1.year == m2.year && m1.month > m2.month)
    }
    
    Column(
        modifier = Modifier
            .fillMaxWidth()
            .background(Color.White)
            .padding(16.dp)
    ) {
        // Header
        Row(
            modifier = Modifier.fillMaxWidth().padding(bottom = 16.dp),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically
        ) {
            Text(
                text = currentYear.toString(),
                color = primaryColor,
                fontSize = 18.sp,
                fontWeight = FontWeight.SemiBold
            )
            
            Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                IconButton(onClick = { 
                    currentYear -= 1 
                    onYearChanged?.invoke(currentYear)
                }) {
                    Text("<", color = primaryColor, fontSize = 24.sp)
                }
                IconButton(onClick = { 
                    currentYear = todayYear
                    onYearChanged?.invoke(currentYear)
                }) {
                    Text("T", color = primaryLight, fontSize = 20.sp, fontWeight = FontWeight.Bold) // Calendar icon placeholder
                }
                IconButton(onClick = { 
                    currentYear += 1 
                    onYearChanged?.invoke(currentYear)
                }) {
                    Text(">", color = primaryColor, fontSize = 24.sp)
                }
            }
        }
        
        // Grid
        Column(modifier = Modifier.fillMaxWidth()) {
            for (row in 0..3) {
                Row(modifier = Modifier.fillMaxWidth()) {
                    for (col in 0..2) {
                        val monthIndex = row * 3 + col + 1
                        val isEn = isEnabled(currentYear, monthIndex)
                        val m = MonthSelection(currentYear, monthIndex)
                        
                        val isSel = if (config.selectionMode == SelectionMode.Single) {
                            selectedMonth == m
                        } else {
                            rangeStartMonth == m || rangeEndMonth == m
                        }
                        
                        val isRangeStart = config.selectionMode != SelectionMode.Single && rangeStartMonth == m
                        val isRangeEnd = config.selectionMode != SelectionMode.Single && rangeEndMonth == m
                        val isInRange = config.selectionMode != SelectionMode.Single && rangeStartMonth != null && rangeEndMonth != null &&
                                isMonthAfter(m, rangeStartMonth!!) && isMonthBefore(m, rangeEndMonth!!)
                                
                        val isCur = currentYear == todayYear && monthIndex == todayMonth
                        
                        Box(
                            modifier = Modifier
                                .weight(1f)
                                .height(48.dp)
                                .padding(2.dp)
                                .let {
                                    if (isSel) it.background(dangerColor, RoundedCornerShape(8.dp))
                                    else if (isInRange) it.background(rangeBgColor)
                                    else if (isRangeStart && rangeEndMonth != null) {
                                        it.background(rangeBgColor) // simple implementation for android
                                    } else if (isRangeEnd && rangeStartMonth != null) {
                                        it.background(rangeBgColor)
                                    } else it
                                }
                                .let {
                                    if (isCur && !isSel) it.border(1.dp, dangerColor, RoundedCornerShape(8.dp)) else it
                                }
                                .clip(RoundedCornerShape(8.dp))
                                .clickable(enabled = isEn) {
                                    if (config.selectionMode == SelectionMode.Single) {
                                        selectedMonth = m
                                        onMonthSelected?.invoke(m)
                                    } else {
                                        if (rangeStartMonth == null || (rangeStartMonth != null && rangeEndMonth != null)) {
                                            rangeStartMonth = m
                                            rangeEndMonth = null
                                        } else if (rangeStartMonth != null && rangeEndMonth == null) {
                                            if (isMonthBefore(m, rangeStartMonth!!)) {
                                                rangeStartMonth = m
                                            } else {
                                                rangeEndMonth = m
                                                onRangeSelected?.invoke(rangeStartMonth, rangeEndMonth)
                                            }
                                        }
                                    }
                                },
                            contentAlignment = Alignment.Center
                        ) {
                            Text(
                                text = monthNames[monthIndex - 1],
                                color = if (isSel) Color.White else if (isCur) dangerColor else primaryColor.copy(alpha = if (isEn) 1f else 0.3f),
                                fontSize = 15.sp,
                                fontWeight = FontWeight.Medium
                            )
                        }
                    }
                }
            }
        }
        
        // Actions
        if (showActionButtons) {
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(top = 16.dp),
                horizontalArrangement = Arrangement.End
            ) {
                TextButton(
                    onClick = { onCancel?.invoke() },
                    colors = ButtonDefaults.textButtonColors(containerColor = Color(0xFFF4F5F8), contentColor = Color(0xFF666666)),
                    shape = RoundedCornerShape(8.dp),
                    modifier = Modifier.padding(end = 8.dp)
                ) {
                    Text("Cancel")
                }
                Button(
                    onClick = {
                        if (config.selectionMode == SelectionMode.Single) {
                            onConfirm?.invoke(selectedMonth, null)
                        } else {
                            onConfirm?.invoke(rangeStartMonth, rangeEndMonth)
                        }
                    },
                    colors = ButtonDefaults.buttonColors(containerColor = primaryLight, contentColor = Color.White),
                    shape = RoundedCornerShape(8.dp)
                ) {
                    Text("Confirm")
                }
            }
        }
    }
}
