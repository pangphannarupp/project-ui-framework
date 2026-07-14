package kh.mcnc.lib.components

import androidx.compose.runtime.Composable
import kh.mcnc.lib.utils.CalendarConfig
import java.util.Date

@Composable
fun BizCalendarSheet(
    visible: Boolean,
    onDismissRequest: () -> Unit,
    title: String? = null,
    config: CalendarConfig? = null,
    initialDate: Date? = null,
    showActionButtons: Boolean = true,
    onDateSelected: ((Any) -> Unit)? = null,
    onRangeSelected: ((Any?, Any?) -> Unit)? = null,
    onMonthChanged: ((Int, Int) -> Unit)? = null,
    onConfirm: ((Any?, Any?) -> Unit)? = null,
    onCancel: (() -> Unit)? = null
) {
    BizBottomSheet(
        isVisible = visible,
        onDismissRequest = onDismissRequest,
        
    ) {
        BizCalendar(
            config = config ?: CalendarConfig(),
            initialDate = initialDate ?: Date(),
            showActionButtons = showActionButtons,
            onDateSelected = onDateSelected,
            onRangeSelected = onRangeSelected,
            onMonthChanged = onMonthChanged,
            onConfirm = onConfirm,
            onCancel = onCancel
        )
    }
}
