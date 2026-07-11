package kh.mcnc.lib.components

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun BizTimePicker(
    modifier: Modifier = Modifier,
    value: String = "12:00", // HH:mm format
    title: String? = null,
    showActionButtons: Boolean = false,
    onValueChange: (String) -> Unit = {},
    onCancel: () -> Unit = {},
    onConfirm: (String) -> Unit = {}
) {
    val initialHour = value.split(":").getOrNull(0)?.toIntOrNull() ?: 12
    val initialMinute = value.split(":").getOrNull(1)?.toIntOrNull() ?: 0
    val state = rememberTimePickerState(
        initialHour = initialHour,
        initialMinute = initialMinute,
        is24Hour = true
    )

    Column(modifier = modifier.padding(16.dp)) {
        if (title != null) {
            Text(
                text = title,
                style = MaterialTheme.typography.titleMedium,
                modifier = Modifier.padding(bottom = 16.dp)
            )
        }
        TimePicker(state = state, modifier = Modifier.fillMaxWidth())
        if (showActionButtons) {
            Row(
                horizontalArrangement = Arrangement.End,
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(top = 16.dp)
            ) {
                TextButton(onClick = onCancel) {
                    Text("Cancel")
                }
                Spacer(modifier = Modifier.width(8.dp))
                Button(onClick = {
                    val formatted = "${state.hour.toString().padStart(2, '0')}:${state.minute.toString().padStart(2, '0')}"
                    onValueChange(formatted)
                    onConfirm(formatted)
                }) {
                    Text("Confirm")
                }
            }
        }
    }
}
