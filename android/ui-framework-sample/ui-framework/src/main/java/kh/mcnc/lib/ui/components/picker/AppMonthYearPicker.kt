package kh.mcnc.lib.ui.components.picker

import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.background
import androidx.compose.foundation.gestures.snapping.rememberSnapFlingBehavior
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import java.util.*

@OptIn(ExperimentalFoundationApi::class)
@Composable
fun WheelPicker(
    items: List<String>,
    selectedIndex: Int,
    onSelectionChanged: (Int) -> Unit,
    modifier: Modifier = Modifier,
    itemHeight: Dp = 48.dp,
    visibleItemsCount: Int = 3
) {
    val listState = rememberLazyListState(initialFirstVisibleItemIndex = selectedIndex)
    val snapBehavior = rememberSnapFlingBehavior(lazyListState = listState)

    // Ensure we trigger callbacks when snapping settles
    LaunchedEffect(listState.isScrollInProgress) {
        if (!listState.isScrollInProgress) {
            val centerItemIndex = listState.firstVisibleItemIndex
            if (centerItemIndex != selectedIndex) {
                onSelectionChanged(centerItemIndex)
            }
        }
    }

    Box(
        modifier = modifier.height(itemHeight * visibleItemsCount),
        contentAlignment = Alignment.Center
    ) {
        LazyColumn(
            state = listState,
            flingBehavior = snapBehavior,
            modifier = Modifier.fillMaxSize()
        ) {
            // Padding at the top so the first item can be centered
            item { Spacer(modifier = Modifier.height(itemHeight * (visibleItemsCount / 2))) }
            
            items(items.size) { index ->
                val item = items[index]
                // Use derived state for instantaneous UI updates while scrolling
                val isSelected by remember {
                    derivedStateOf { listState.firstVisibleItemIndex == index }
                }
                
                Box(
                    modifier = Modifier
                        .height(itemHeight)
                        .fillMaxWidth(),
                    contentAlignment = Alignment.Center
                ) {
                    Text(
                        text = item,
                        style = if (isSelected) MaterialTheme.typography.headlineMedium else MaterialTheme.typography.titleLarge,
                        color = if (isSelected) MaterialTheme.colorScheme.onSurface else MaterialTheme.colorScheme.onSurface.copy(alpha = 0.4f),
                        fontWeight = if (isSelected) FontWeight.Bold else FontWeight.Medium
                    )
                }
            }
            
            // Padding at the bottom so the last item can be centered
            item { Spacer(modifier = Modifier.height(itemHeight * (visibleItemsCount / 2))) }
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun AppMonthYearPickerBottomSheet(
    isVisible: Boolean,
    onDismiss: () -> Unit,
    initialMonth: Int, // 1 to 12
    initialYear: Int,
    monthNames: List<String> = listOf("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"),
    yearRange: IntRange = 1900..2100,
    onConfirm: (month: Int, year: Int) -> Unit
) {
    if (!isVisible) return

    val sheetState = rememberModalBottomSheetState(skipPartiallyExpanded = true)
    
    // Convert ranges to lists
    val years = yearRange.toList().map { it.toString() }
    
    // Internal state
    var selectedMonthIndex by remember { mutableStateOf(initialMonth - 1) }
    var selectedYearIndex by remember { mutableStateOf(years.indexOf(initialYear.toString()).coerceAtLeast(0)) }

    ModalBottomSheet(
        onDismissRequest = onDismiss,
        sheetState = sheetState,
        containerColor = Color.White,
        shape = RoundedCornerShape(topStart = 16.dp, topEnd = 16.dp),
        dragHandle = {
            Column(
                modifier = Modifier.fillMaxWidth(),
                horizontalAlignment = Alignment.CenterHorizontally
            ) {
                Spacer(modifier = Modifier.height(12.dp))
                Box(
                    modifier = Modifier
                        .width(48.dp)
                        .height(4.dp)
                        .background(color = Color(0xFF1B8A44), shape = RoundedCornerShape(2.dp)) // Using the green from screenshot
                )
                Spacer(modifier = Modifier.height(12.dp))
            }
        }
    ) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = 24.dp)
        ) {
            // Title
            Text(
                text = "Select Month",
                style = MaterialTheme.typography.titleLarge,
                fontWeight = FontWeight.Bold,
                color = MaterialTheme.colorScheme.onSurface,
                modifier = Modifier.padding(bottom = 24.dp)
            )
            
            // Column Headers
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceEvenly
            ) {
                Text(
                    text = "Month",
                    style = MaterialTheme.typography.titleMedium,
                    fontWeight = FontWeight.Medium,
                    color = MaterialTheme.colorScheme.onSurface,
                    modifier = Modifier.weight(1f),
                    textAlign = androidx.compose.ui.text.style.TextAlign.Center
                )
                Text(
                    text = "Year",
                    style = MaterialTheme.typography.titleMedium,
                    fontWeight = FontWeight.Medium,
                    color = MaterialTheme.colorScheme.onSurface,
                    modifier = Modifier.weight(1f),
                    textAlign = androidx.compose.ui.text.style.TextAlign.Center
                )
            }
            
            Spacer(modifier = Modifier.height(16.dp))
            
            // Wheel Pickers
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceEvenly
            ) {
                WheelPicker(
                    items = monthNames,
                    selectedIndex = selectedMonthIndex,
                    onSelectionChanged = { selectedMonthIndex = it },
                    modifier = Modifier.weight(1f),
                    itemHeight = 56.dp
                )
                
                WheelPicker(
                    items = years,
                    selectedIndex = selectedYearIndex,
                    onSelectionChanged = { selectedYearIndex = it },
                    modifier = Modifier.weight(1f),
                    itemHeight = 56.dp
                )
            }
            
            Spacer(modifier = Modifier.height(32.dp))
            
            // Action Buttons
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(bottom = 24.dp),
                horizontalArrangement = Arrangement.spacedBy(16.dp)
            ) {
                Button(
                    onClick = onDismiss,
                    modifier = Modifier.weight(0.35f).height(50.dp),
                    colors = ButtonDefaults.buttonColors(
                        containerColor = Color(0xFFF0F0F5),
                        contentColor = MaterialTheme.colorScheme.onSurface
                    ),
                    shape = RoundedCornerShape(8.dp)
                ) {
                    Text("Close", fontSize = androidx.compose.ui.unit.TextUnit(16f, androidx.compose.ui.unit.TextUnitType.Sp), fontWeight = FontWeight.Medium)
                }
                
                Button(
                    onClick = {
                        val finalMonth = selectedMonthIndex + 1
                        val finalYear = years[selectedYearIndex].toInt()
                        onConfirm(finalMonth, finalYear)
                        onDismiss()
                    },
                    modifier = Modifier.weight(0.65f).height(50.dp),
                    colors = ButtonDefaults.buttonColors(
                        containerColor = Color(0xFF1B8A44),
                        contentColor = Color.White
                    ),
                    shape = RoundedCornerShape(8.dp)
                ) {
                    Text("Confirm", fontSize = androidx.compose.ui.unit.TextUnit(16f, androidx.compose.ui.unit.TextUnitType.Sp), fontWeight = FontWeight.Medium)
                }
            }
        }
    }
}

@androidx.compose.ui.tooling.preview.Preview(showBackground = true)
@Composable
fun AppMonthYearPickerPreview() {
    AppMonthYearPickerBottomSheet(
        isVisible = true,
        onDismiss = {},
        initialMonth = 5,
        initialYear = 2026,
        onConfirm = { _, _ -> }
    )
}
