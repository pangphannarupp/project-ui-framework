package kh.mcnc.lib.components

import androidx.compose.runtime.Composable

@Composable
fun BizTimePickerSheet(
    visible: Boolean,
    onDismissRequest: () -> Unit,
    timeValue: String? = null,
    title: String? = null,
    min: String? = null,
    max: String? = null,
    minuteValues: Any? = null,
    hourCycle: String? = null,
    showActionButtons: Boolean = true,
    onTimeUpdate: ((String?) -> Unit)? = null,
    onChange: ((String?) -> Unit)? = null,
    onConfirm: ((String?) -> Unit)? = null,
    onCancel: (() -> Unit)? = null
) {
    BizBottomSheet(
        visible = visible,
        onDismissRequest = onDismissRequest,
        title = title
    ) {
        BizTimePicker(
            timeValue = timeValue,
            min = min,
            max = max,
            minuteValues = minuteValues,
            hourCycle = hourCycle,
            showActionButtons = showActionButtons,
            onTimeUpdate = onTimeUpdate,
            onChange = onChange,
            onConfirm = onConfirm,
            onCancel = onCancel
        )
    }
}
