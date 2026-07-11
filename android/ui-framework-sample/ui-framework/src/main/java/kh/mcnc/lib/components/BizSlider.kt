package kh.mcnc.lib.components

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

@Composable
fun BizSlider(
    value: Float,
    onValueChange: (Float) -> Unit,
    modifier: Modifier = Modifier,
    valueRange: ClosedFloatingPointRange<Float> = 0f..100f,
    steps: Int = 0,
    label: String? = null,
    showValue: Boolean = false,
    formatValue: ((Float) -> String)? = null,
    color: Color = Color(0xFF003399)
) {
    Column(
        modifier = modifier.fillMaxWidth(),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        if (label != null || showValue) {
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(horizontal = 16.dp),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                if (label != null) {
                    Text(
                        text = label,
                        fontSize = 14.sp,
                        fontWeight = FontWeight.Medium,
                        color = Color(0xFF1A2A5E)
                    )
                } else {
                    Spacer(modifier = Modifier.width(1.dp))
                }

                if (showValue) {
                    val displayValue = formatValue?.invoke(value) ?: value.toInt().toString()
                    Text(
                        text = displayValue,
                        fontSize = 14.sp,
                        fontWeight = FontWeight.Bold,
                        color = color
                    )
                }
            }
        }

        Slider(
            value = value,
            onValueChange = onValueChange,
            valueRange = valueRange,
            steps = steps,
            colors = SliderDefaults.colors(
                thumbColor = color,
                activeTrackColor = color,
                inactiveTrackColor = color.copy(alpha = 0.2f)
            ),
            modifier = Modifier.padding(horizontal = 8.dp)
        )
    }
}
