package kh.mcnc.lib.components

import androidx.compose.foundation.Canvas
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.geometry.Size
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.drawscope.Stroke

data class BizPieSegment(
    val value: Float,
    val color: Color
)

@Composable
fun BizPieChart(
    data: List<BizPieSegment>,
    modifier: Modifier = Modifier
) {
    val total = data.sumOf { it.value.toDouble() }.toFloat().coerceAtLeast(0.001f)

    Canvas(modifier = modifier.aspectRatio(1f).fillMaxSize()) {
        var startAngle = 0f
        
        data.forEach { segment ->
            val sweepAngle = (segment.value / total) * 360f
            
            drawArc(
                color = segment.color,
                startAngle = startAngle,
                sweepAngle = sweepAngle,
                useCenter = true,
                size = Size(size.width, size.height),
                topLeft = Offset(0f, 0f)
            )
            
            // Draw gap/stroke between slices
            drawArc(
                color = Color.White,
                startAngle = startAngle,
                sweepAngle = sweepAngle,
                useCenter = true,
                style = Stroke(width = 2f),
                size = Size(size.width, size.height),
                topLeft = Offset(0f, 0f)
            )
            
            startAngle += sweepAngle
        }
    }
}
