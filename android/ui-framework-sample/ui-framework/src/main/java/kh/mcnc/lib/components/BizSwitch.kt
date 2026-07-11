package kh.mcnc.lib.components

import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.selection.toggleable
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Switch
import androidx.compose.material3.SwitchDefaults
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.unit.dp

@Composable
fun BizSwitch(
    checked: Boolean,
    onCheckedChange: (Boolean) -> Unit,
    modifier: Modifier = Modifier,
    label: String? = null,
    checkedTrackColor: Color = Color(0xFF003399), // --biz-primary
    checkedThumbColor: Color = Color.White
) {
    Row(
        modifier = modifier
            .toggleable(
                value = checked,
                onValueChange = { onCheckedChange(!checked) },
                role = Role.Switch
            )
            .padding(vertical = 8.dp),
        verticalAlignment = Alignment.CenterVertically
    ) {
        if (label != null) {
            Text(
                text = label,
                style = MaterialTheme.typography.titleMedium,
                color = Color(0xFF1A2A5E) // --biz-primary-variant
            )
            Spacer(modifier = Modifier.width(16.dp))
        }
        
        Switch(
            checked = checked,
            onCheckedChange = null,
            colors = SwitchDefaults.colors(
                checkedTrackColor = checkedTrackColor,
                checkedThumbColor = checkedThumbColor
            )
        )
    }
}
