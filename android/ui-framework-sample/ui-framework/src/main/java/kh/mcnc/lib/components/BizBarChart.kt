package kh.mcnc.lib.components

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

data class BizBarChartData(
    val label: String? = null,
    val value: Float,
    val color: Color? = null
)

@Composable
fun BizBarChart(
    data: List<BizBarChartData>,
    modifier: Modifier = Modifier,
    height: Float = 240f,
    color: Color = Color(0xFF3880FF),
    showValues: Boolean = true,
    barRadius: Float = 6f
) {
    val maxValue = data.maxOfOrNull { it.value }?.coerceAtLeast(0.001f) ?: 1f

    Row(
        modifier = modifier
            .fillMaxWidth()
            .height(height.dp)
            .padding(vertical = 24.dp),
        horizontalArrangement = Arrangement.SpaceAround,
        verticalAlignment = Alignment.Bottom
    ) {
        data.forEach { item ->
            Column(
                horizontalAlignment = Alignment.CenterHorizontally,
                verticalArrangement = Arrangement.Bottom,
                modifier = Modifier
                    .weight(1f)
                    .fillMaxHeight()
                    .padding(horizontal = 4.dp)
            ) {
                if (showValues) {
                    Text(
                        text = item.value.toInt().toString(),
                        fontSize = 12.sp,
                        color = Color(0xFF666666),
                        fontWeight = FontWeight.SemiBold,
                        modifier = Modifier.padding(bottom = 8.dp)
                    )
                }

                val fraction = (item.value / maxValue).coerceIn(0f, 1f)
                Box(
                    modifier = Modifier
                        .fillMaxWidth(0.8f) // Bar width relative to the slot
                        .fillMaxHeight(fraction)
                        .clip(RoundedCornerShape(topStart = barRadius.dp, topEnd = barRadius.dp))
                        .background(item.color ?: color)
                )

                if (item.label != null) {
                    Text(
                        text = item.label,
                        fontSize = 12.sp,
                        color = Color(0xFF999999),
                        modifier = Modifier.padding(top = 12.dp),
                        maxLines = 1,
                        overflow = TextOverflow.Ellipsis,
                        textAlign = TextAlign.Center
                    )
                }
            }
        }
    }
}
