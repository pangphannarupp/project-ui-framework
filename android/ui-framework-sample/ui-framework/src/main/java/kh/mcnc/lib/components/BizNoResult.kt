package kh.mcnc.lib.components

import androidx.compose.foundation.Canvas
import androidx.compose.foundation.layout.*
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.geometry.Rect
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Path
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.graphics.StrokeJoin
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.graphics.drawscope.translate
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

@Composable
fun BizNoResult(
    modifier: Modifier = Modifier,
    title: String = "No results found",
    subtitle: String? = "Try changing your search or filter.",
    graphic: @Composable (() -> Unit)? = null,
    action: @Composable (() -> Unit)? = null
) {
    Column(
        modifier = modifier
            .fillMaxWidth()
            .padding(vertical = 40.dp, horizontal = 20.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Box(
            modifier = Modifier.padding(bottom = 24.dp),
            contentAlignment = Alignment.Center
        ) {
            if (graphic != null) {
                graphic()
            } else {
                DefaultNoResultGraphic()
            }
        }
        
        Text(
            text = title,
            fontSize = 18.sp,
            fontWeight = FontWeight.Bold,
            color = Color(0xFF333333),
            textAlign = TextAlign.Center,
            modifier = Modifier.padding(bottom = 8.dp)
        )
        
        if (subtitle != null) {
            Text(
                text = subtitle,
                fontSize = 14.sp,
                color = Color(0xFF777777),
                textAlign = TextAlign.Center,
                lineHeight = 19.6.sp
            )
        }
        
        if (action != null) {
            Box(modifier = Modifier.padding(top = 24.dp)) {
                action()
            }
        }
    }
}

@Composable
private fun DefaultNoResultGraphic() {
    Canvas(modifier = Modifier.size(120.dp)) {
        // Grey Circle with Question Mark
        drawCircle(
            color = Color(0xFF9E9E9E),
            radius = 30.dp.toPx(),
            center = Offset(50.dp.toPx(), 50.dp.toPx())
        )
        
        val questionMarkPath = Path().apply {
            moveTo(43.dp.toPx(), 40.dp.toPx())
            cubicTo(
                43.dp.toPx(), 36.134.dp.toPx(),
                46.134.dp.toPx(), 33.dp.toPx(),
                50.dp.toPx(), 33.dp.toPx()
            )
            cubicTo(
                53.866.dp.toPx(), 33.dp.toPx(),
                57.dp.toPx(), 36.134.dp.toPx(),
                57.dp.toPx(), 40.dp.toPx()
            )
            cubicTo(
                57.dp.toPx(), 42.5.dp.toPx(),
                54.dp.toPx(), 44.5.dp.toPx(),
                51.5.dp.toPx(), 46.5.dp.toPx()
            )
            cubicTo(
                50.5.dp.toPx(), 47.3.dp.toPx(),
                50.dp.toPx(), 48.5.dp.toPx(),
                50.dp.toPx(), 50.dp.toPx()
            )
            lineTo(50.dp.toPx(), 52.dp.toPx())
        }
        
        drawPath(
            path = questionMarkPath,
            color = Color.White,
            style = Stroke(
                width = 6.dp.toPx(),
                cap = StrokeCap.Round,
                join = StrokeJoin.Round
            )
        )
        
        drawCircle(
            color = Color.White,
            radius = 4.dp.toPx(),
            center = Offset(50.dp.toPx(), 62.dp.toPx())
        )
        
        // Magnifying Glass Overlay
        translate(left = 15.dp.toPx(), top = 15.dp.toPx()) {
            drawCircle(
                color = Color(0xFFD8D8D8).copy(alpha = 0.9f),
                radius = 22.dp.toPx(),
                center = Offset(55.dp.toPx(), 55.dp.toPx())
            )
            drawCircle(
                color = Color(0xFF606775),
                radius = 22.dp.toPx(),
                center = Offset(55.dp.toPx(), 55.dp.toPx()),
                style = Stroke(width = 5.dp.toPx())
            )
            
            drawLine(
                color = Color(0xFF606775),
                start = Offset(70.dp.toPx(), 70.dp.toPx()),
                end = Offset(85.dp.toPx(), 85.dp.toPx()),
                strokeWidth = 6.dp.toPx(),
                cap = StrokeCap.Round
            )
            
            // Little highlight on glass
            val highlightPath = Path().apply {
                val rect = Rect(
                    center = Offset(55.dp.toPx(), 55.dp.toPx()),
                    radius = 15.dp.toPx()
                )
                arcTo(rect, 180f, 90f, false)
            }
            drawPath(
                path = highlightPath,
                color = Color.White.copy(alpha = 0.6f),
                style = Stroke(
                    width = 3.dp.toPx(),
                    cap = StrokeCap.Round
                )
            )
        }
    }
}
