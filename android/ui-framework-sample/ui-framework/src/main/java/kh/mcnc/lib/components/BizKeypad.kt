package kh.mcnc.lib.components

import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.material.ripple.rememberRipple
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Path
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.graphics.StrokeJoin
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

@Composable
fun BizKeypad(
    modifier: Modifier = Modifier,
    onPress: (String) -> Unit
) {
    val lettersMap = mapOf(
        "1" to "", "2" to "ABC", "3" to "DEF",
        "4" to "GHI", "5" to "JKL", "6" to "MNO",
        "7" to "PQRS", "8" to "TUV", "9" to "WXYZ"
    )

    Column(
        modifier = modifier
            .fillMaxWidth()
            .background(
                color = Color(0xFFE5E7EB),
                shape = RoundedCornerShape(topStart = 24.dp, topEnd = 24.dp)
            )
            .padding(top = 16.dp, start = 20.dp, end = 20.dp, bottom = 32.dp)
    ) {
        val rows = listOf(
            listOf("1", "2", "3"),
            listOf("4", "5", "6"),
            listOf("7", "8", "9")
        )
        
        rows.forEach { row ->
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.spacedBy(12.dp)
            ) {
                row.forEach { num ->
                    KeypadButton(
                        modifier = Modifier.weight(1f),
                        num = num,
                        alpha = lettersMap[num] ?: "",
                        onClick = { onPress(num) }
                    )
                }
            }
            Spacer(modifier = Modifier.height(12.dp))
        }
        
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.spacedBy(12.dp)
        ) {
            Box(modifier = Modifier.weight(1f).height(54.dp))
            
            KeypadButton(
                modifier = Modifier.weight(1f),
                num = "0",
                alpha = "+",
                onClick = { onPress("0") }
            )
            
            Box(
                modifier = Modifier
                    .weight(1f)
                    .height(54.dp)
                    .clip(RoundedCornerShape(8.dp))
                    .clickable(
                        interactionSource = remember { MutableInteractionSource() },
                        indication = androidx.compose.material3.ripple(),
                        onClick = { onPress("backspace") }
                    ),
                contentAlignment = Alignment.Center
            ) {
                BackspaceIconCanvas()
            }
        }
    }
}

@Composable
private fun KeypadButton(
    modifier: Modifier = Modifier,
    num: String,
    alpha: String,
    onClick: () -> Unit
) {
    Box(
        modifier = modifier
            .height(54.dp)
            .shadow(1.dp, RoundedCornerShape(8.dp))
            .background(Color.White, RoundedCornerShape(8.dp))
            .clip(RoundedCornerShape(8.dp))
            .clickable(onClick = onClick),
        contentAlignment = Alignment.Center
    ) {
        Column(
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.Center
        ) {
            Text(
                text = num,
                fontSize = 26.sp,
                color = Color(0xFF111111),
                fontWeight = FontWeight.Medium,
                lineHeight = 26.sp
            )
            if (alpha.isNotEmpty()) {
                Text(
                    text = alpha,
                    fontSize = 10.sp,
                    color = Color(0xFF718096),
                    fontWeight = FontWeight.SemiBold,
                    letterSpacing = 1.sp,
                    lineHeight = 10.sp
                )
            } else {
                Spacer(modifier = Modifier.height(10.dp))
            }
        }
    }
}

@Composable
internal fun BackspaceIconCanvas(tint: Color = Color(0xFF333333)) {
    Canvas(modifier = Modifier.size(24.dp)) {
        val w = size.width
        val h = size.height
        val path = Path().apply {
            moveTo(w * 0.875f, h * 0.166f)
            lineTo(w * 0.333f, h * 0.166f)
            lineTo(w * 0.041f, h * 0.5f)
            lineTo(w * 0.333f, h * 0.833f)
            lineTo(w * 0.875f, h * 0.833f)
            close()
        }
        drawPath(
            path = path,
            color = tint,
            style = Stroke(
                width = 1.5f.dp.toPx(),
                cap = StrokeCap.Round,
                join = StrokeJoin.Round
            )
        )
        drawLine(
            color = tint,
            start = androidx.compose.ui.geometry.Offset(w * 0.5f, h * 0.375f),
            end = androidx.compose.ui.geometry.Offset(w * 0.75f, h * 0.625f),
            strokeWidth = 1.5f.dp.toPx(),
            cap = StrokeCap.Round
        )
        drawLine(
            color = tint,
            start = androidx.compose.ui.geometry.Offset(w * 0.75f, h * 0.375f),
            end = androidx.compose.ui.geometry.Offset(w * 0.5f, h * 0.625f),
            strokeWidth = 1.5f.dp.toPx(),
            cap = StrokeCap.Round
        )
    }
}
