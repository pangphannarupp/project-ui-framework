package kh.mcnc.lib.ui.components

import androidx.compose.foundation.Canvas
import androidx.compose.foundation.layout.*
import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.*
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.unit.dp

@Composable
fun AppLineChart(
    data: List<Float>,
    modifier: Modifier = Modifier,
    lineColor: Color = MaterialTheme.colorScheme.primary,
    gradientColors: List<Color> = listOf(
        MaterialTheme.colorScheme.primary.copy(alpha = 0.5f),
        Color.Transparent
    ),
    strokeWidth: Float = 6f
) {
    if (data.isEmpty()) return
    
    Canvas(
        modifier = modifier
            .fillMaxWidth()
            .height(200.dp)
            .padding(16.dp)
    ) {
        val maxData = data.maxOrNull() ?: 0f
        val minData = data.minOrNull() ?: 0f
        val range = if (maxData == minData) 1f else maxData - minData
        
        val width = size.width
        val height = size.height
        
        val xStep = width / if (data.size > 1) (data.size - 1) else 1
        
        val path = Path()
        val fillPath = Path()
        
        data.forEachIndexed { index, value ->
            val x = index * xStep
            val y = height - ((value - minData) / range * height)
            
            if (index == 0) {
                path.moveTo(x, y)
                fillPath.moveTo(x, y)
            } else {
                path.lineTo(x, y)
                fillPath.lineTo(x, y)
            }
        }
        
        fillPath.lineTo(width, height)
        fillPath.lineTo(0f, height)
        fillPath.close()
        
        drawPath(
            path = fillPath,
            brush = Brush.verticalGradient(
                colors = gradientColors,
                startY = 0f,
                endY = height
            )
        )
        
        drawPath(
            path = path,
            color = lineColor,
            style = Stroke(
                width = strokeWidth,
                cap = StrokeCap.Round,
                join = StrokeJoin.Round
            )
        )
        
        data.forEachIndexed { index, value ->
            val x = index * xStep
            val y = height - ((value - minData) / range * height)
            
            drawCircle(
                color = lineColor,
                radius = strokeWidth * 1.5f,
                center = Offset(x, y)
            )
            drawCircle(
                color = Color.White,
                radius = strokeWidth,
                center = Offset(x, y)
            )
        }
    }
}
