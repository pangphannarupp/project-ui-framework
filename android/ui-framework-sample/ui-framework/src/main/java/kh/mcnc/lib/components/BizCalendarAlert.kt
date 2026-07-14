package kh.mcnc.lib.components

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Surface
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import androidx.compose.ui.window.Dialog
import androidx.compose.ui.window.DialogProperties
import kh.mcnc.lib.utils.CalendarConfig
import java.util.Date

@Composable
fun BizCalendarAlert(
    visible: Boolean,
    onDismissRequest: () -> Unit,
    title: String? = null,
    config: CalendarConfig? = null,
    initialDate: Date? = null,
    showActionButtons: Boolean = true,
    dismissOnOverlayClick: Boolean = true,
    onDateSelected: ((Any) -> Unit)? = null,
    onRangeSelected: ((Any?, Any?) -> Unit)? = null,
    onMonthChanged: ((Int, Int) -> Unit)? = null,
    onConfirm: ((Any?, Any?) -> Unit)? = null,
    onCancel: (() -> Unit)? = null
) {
    if (visible) {
        Dialog(
            onDismissRequest = {
                if (dismissOnOverlayClick) onDismissRequest()
            },
            properties = DialogProperties(
                dismissOnBackPress = true,
                dismissOnClickOutside = dismissOnOverlayClick,
                usePlatformDefaultWidth = false
            )
        ) {
            Box(
                modifier = Modifier
                    .fillMaxSize()
                    .clickable(
                        enabled = dismissOnOverlayClick,
                        onClick = onDismissRequest
                    )
                    .padding(16.dp),
                contentAlignment = Alignment.Center
            ) {
                Surface(
                    modifier = Modifier
                        .widthIn(max = 400.dp)
                        .fillMaxWidth()
                        .clickable(enabled = false, onClick = {}),
                    shape = RoundedCornerShape(16.dp),
                    color = Color.White,
                    shadowElevation = 12.dp
                ) {
                    Box(modifier = Modifier.padding(0.dp)) {
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
            }
        }
    }
}
