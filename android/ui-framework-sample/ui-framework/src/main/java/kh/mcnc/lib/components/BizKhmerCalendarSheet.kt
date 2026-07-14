package kh.mcnc.lib.components

import androidx.compose.runtime.Composable
import kh.mcnc.lib.utils.CalendarConfig
import java.util.Date

@Composable
fun BizKhmerCalendarSheet(
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
        BizKhmerCalendar(
            config = config ?: CalendarConfig(),
            initialDate = initialDate ?: Date(),
            showActionButtons = showActionButtons,
            onDateSelected = { d, kd, s -> onDateSelected?.invoke(d) },
            onRangeSelected = { d1, kd1, s1, d2, kd2, s2 -> onRangeSelected?.invoke(d1, d2) },
            onMonthChanged = onMonthChanged,
            onConfirm = onConfirm,
            onCancel = onCancel
        )
    }
}
