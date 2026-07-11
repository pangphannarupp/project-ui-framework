package kh.mcnc.lib.ui.components

import androidx.compose.animation.core.FastOutSlowInEasing
import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.animation.core.tween
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.layout.*
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.geometry.Size
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Path
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.graphics.drawscope.rotate
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp

@Composable
fun AppGaugeChart(
    value: Float, // 0f to maxValue
    maxValue: Float = 100f,
    modifier: Modifier = Modifier,
    title: String = "Credit Score",
    activeColor: Color = MaterialTheme.colorScheme.primary,
    inactiveColor: Color = MaterialTheme.colorScheme.surfaceVariant
) {
    var animationPlayed by remember { mutableStateOf(false) }
    
    val currentProgress by animateFloatAsState(
        targetValue = if (animationPlayed) (value / maxValue).coerceIn(0f, 1f) else 0f,
        animationSpec = tween(durationMillis = 1500, easing = FastOutSlowInEasing),
        label = "gauge_progress"
    )
    
    LaunchedEffect(key1 = true) {
        animationPlayed = true
    }

    Box(
        contentAlignment = Alignment.Center,
        modifier = modifier.size(240.dp).padding(16.dp)
    ) {
        Canvas(modifier = Modifier.fillMaxSize()) {
            val strokeWidth = 32f
            val canvasWidth = size.width
            val canvasHeight = size.height
            val radius = (canvasWidth - strokeWidth) / 2
            val center = Offset(canvasWidth / 2, canvasHeight - strokeWidth)
            
            // Background arc (0 to 180 degrees)
            drawArc(
                color = inactiveColor,
                startAngle = 180f,
                sweepAngle = 180f,
                useCenter = false,
                style = Stroke(width = strokeWidth, cap = StrokeCap.Round),
                size = Size(radius * 2, radius * 2),
                topLeft = Offset(strokeWidth / 2, canvasHeight - radius - strokeWidth)
            )

            // Foreground arc
            drawArc(
                color = activeColor,
                startAngle = 180f,
                sweepAngle = 180f * currentProgress,
                useCenter = false,
                style = Stroke(width = strokeWidth, cap = StrokeCap.Round),
                size = Size(radius * 2, radius * 2),
                topLeft = Offset(strokeWidth / 2, canvasHeight - radius - strokeWidth)
            )

            // Needle
            val needleRotation = 180f + (180f * currentProgress)
            rotate(degrees = needleRotation, pivot = center) {
                val needlePath = Path().apply {
                    moveTo(center.x - 10f, center.y)
                    lineTo(center.x + 10f, center.y)
                    lineTo(center.x, center.y - radius + strokeWidth)
                    close()
                }
                drawPath(path = needlePath, color = Color.DarkGray)
                drawCircle(color = Color.DarkGray, radius = 16f, center = center)
                drawCircle(color = Color.White, radius = 6f, center = center)
            }
        }
        
        Column(
            horizontalAlignment = Alignment.CenterHorizontally,
            modifier = Modifier.align(Alignment.BottomCenter).padding(bottom = 16.dp)
        ) {
            Text(
                text = "${(value).toInt()}",
                style = MaterialTheme.typography.displaySmall,
                fontWeight = FontWeight.Bold,
                color = MaterialTheme.colorScheme.onSurface
            )
            Text(
                text = title,
                style = MaterialTheme.typography.labelLarge,
                color = MaterialTheme.colorScheme.onSurfaceVariant
            )
        }
    }
}
