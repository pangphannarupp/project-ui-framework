package kh.mcnc.lib.components

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
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import kotlinx.coroutines.delay

@Composable
fun BizProgressGauge(
    value: Float,
    max: Float = 100f,
    modifier: Modifier = Modifier,
    thickness: Float = 8f,
    color: Color = Color(0xFF3880FF),
    trackColor: Color = Color(0xFFE0E0E0),
    label: String? = null,
    format: ((Float) -> String)? = null
) {
    var animated by remember { mutableStateOf(false) }

    LaunchedEffect(Unit) {
        delay(100)
        animated = true
    }

    val percentage = (value / max).coerceIn(0f, 1f)
    val animatedPercentage by animateFloatAsState(
        targetValue = if (animated) percentage else 0f,
        animationSpec = tween(durationMillis = 1500, easing = FastOutSlowInEasing),
        label = "Progress"
    )

    Box(
        modifier = modifier.aspectRatio(2f), // width = 2 * height
        contentAlignment = Alignment.BottomCenter
    ) {
        Canvas(modifier = Modifier.fillMaxSize()) {
            val strokeWidth = thickness.dp.toPx()
            
            // Background Track
            drawArc(
                color = trackColor,
                startAngle = 180f,
                sweepAngle = 180f,
                useCenter = false,
                style = Stroke(width = strokeWidth, cap = StrokeCap.Round),
                size = Size(size.width, size.width),
                topLeft = Offset(0f, 0f)
            )

            // Progress Track
            drawArc(
                color = color,
                startAngle = 180f,
                sweepAngle = 180f * animatedPercentage,
                useCenter = false,
                style = Stroke(width = strokeWidth, cap = StrokeCap.Round),
                size = Size(size.width, size.width),
                topLeft = Offset(0f, 0f)
            )
        }
        
        Column(
            horizontalAlignment = Alignment.CenterHorizontally,
            modifier = Modifier.padding(bottom = 8.dp)
        ) {
            val formattedValue = format?.invoke(value) ?: value.toInt().toString()
            Text(
                text = formattedValue,
                color = color,
                fontSize = 28.sp,
                fontWeight = FontWeight.Bold
            )
            if (label != null) {
                Text(
                    text = label,
                    color = Color(0xFF999999),
                    fontSize = 12.sp
                )
            }
        }
    }
}
