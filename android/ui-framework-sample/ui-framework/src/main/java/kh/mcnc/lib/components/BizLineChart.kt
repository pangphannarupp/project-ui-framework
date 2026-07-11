package kh.mcnc.lib.components

import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Path
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

@Composable
fun BizLineChart(
    data: List<Float>,
    modifier: Modifier = Modifier,
    labels: List<String>? = null,
    height: Float = 240f,
    color: Color = Color(0xFF3880FF),
    strokeWidth: Float = 2f,
    showPoints: Boolean = true,
    showGrid: Boolean = true
) {
    Column(modifier = modifier.fillMaxWidth()) {
        Box(
            modifier = Modifier
                .fillMaxWidth()
                .height(height.dp)
        ) {
            Canvas(modifier = Modifier.fillMaxSize().padding(vertical = 16.dp)) {
                if (data.isEmpty()) return@Canvas

                val max = data.maxOrNull()?.coerceAtLeast(0.001f) ?: 1f
                val min = data.minOrNull()?.coerceAtMost(0f) ?: 0f
                val range = max - min
                
                // Draw Grid
                if (showGrid) {
                    for (i in 0..4) {
                        val y = size.height * (i / 4f)
                        drawLine(
                            color = Color(0xFFF0F0F0),
                            start = Offset(0f, y),
                            end = Offset(size.width, y),
                            strokeWidth = 1.dp.toPx()
                        )
                    }
                }

                val path = Path()
                val points = mutableListOf<Offset>()

                data.forEachIndexed { index, value ->
                    val x = if (data.size > 1) {
                        size.width * (index.toFloat() / (data.size - 1))
                    } else {
                        size.width / 2
                    }
                    val y = size.height * (1f - ((value - min) / range))

                    points.add(Offset(x, y))

                    if (index == 0) {
                        path.moveTo(x, y)
                    } else {
                        path.lineTo(x, y)
                    }
                }

                // Draw line
                drawPath(
                    path = path,
                    color = color,
                    style = Stroke(width = strokeWidth.dp.toPx())
                )
            }

            // Draw Points
            if (showPoints && data.isNotEmpty()) {
                val max = data.maxOrNull()?.coerceAtLeast(0.001f) ?: 1f
                val min = data.minOrNull()?.coerceAtMost(0f) ?: 0f
                val range = max - min

                BoxWithConstraints(modifier = Modifier.fillMaxSize().padding(vertical = 16.dp)) {
                    val widthPx = constraints.maxWidth
                    val heightPx = constraints.maxHeight

                    data.forEachIndexed { index, value ->
                        val xRatio = if (data.size > 1) index.toFloat() / (data.size - 1) else 0.5f
                        val yRatio = 1f - ((value - min) / range)

                        Box(
                            modifier = Modifier
                                .offset(
                                    x = (maxWidth * xRatio) - 4.dp,
                                    y = (maxHeight * yRatio) - 4.dp
                                )
                                .size(8.dp)
                                .background(color, CircleShape)
                                .border(2.dp, Color.White, CircleShape)
                        )
                    }
                }
            }
        }

        if (!labels.isNullOrEmpty()) {
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(top = 8.dp),
                horizontalArrangement = Arrangement.SpaceBetween
            ) {
                labels.forEach { label ->
                    Text(
                        text = label,
                        fontSize = 12.sp,
                        color = Color(0xFF999999),
                        textAlign = TextAlign.Center,
                        modifier = Modifier.weight(1f)
                    )
                }
            }
        }
    }
}
