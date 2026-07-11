package kh.mcnc.lib.components

import androidx.compose.runtime.Composable
import java.util.Date

@Composable
fun BizMonthPickerSheet(
    visible: Boolean,
    onDismissRequest: () -> Unit,
    title: String? = null,
    config: Any? = null,
    initialDate: Date? = null,
    showActionButtons: Boolean = true,
    onMonthSelected: ((Any) -> Unit)? = null,
    onRangeSelected: ((Any?, Any?) -> Unit)? = null,
    onYearChanged: ((Int) -> Unit)? = null,
    onConfirm: ((Any?, Any?) -> Unit)? = null,
    onCancel: (() -> Unit)? = null
) {
    BizBottomSheet(
        visible = visible,
        onDismissRequest = onDismissRequest,
        title = title
    ) {
        BizMonthPicker(
            config = config,
            initialDate = initialDate,
            showActionButtons = showActionButtons,
            onMonthSelected = onMonthSelected,
            onRangeSelected = onRangeSelected,
            onYearChanged = onYearChanged,
            onConfirm = onConfirm,
            onCancel = onCancel
        )
    }
}
