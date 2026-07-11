package kh.mcnc.lib.components

import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Text
import androidx.compose.runtime.*
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
fun BizSecureKeypad(
    modifier: Modifier = Modifier,
    showHeader: Boolean = true,
    onPress: (String) -> Unit
) {
    var shuffledKeys by remember { mutableStateOf(emptyList<String>()) }

    val randomizeKeys = {
        val nums = mutableListOf("1", "2", "3", "4", "5", "6", "7", "8", "9", "0")
        val shieldIndex = (0..10).random()
        nums.add(shieldIndex, "shield")
        shuffledKeys = nums
    }

    LaunchedEffect(Unit) {
        randomizeKeys()
    }

    val lettersMap = mapOf(
        "1" to "", "2" to "ABC", "3" to "DEF",
        "4" to "GHI", "5" to "JKL", "6" to "MNO",
        "7" to "PQRS", "8" to "TUV", "9" to "WXYZ",
        "0" to "+"
    )

    Column(
        modifier = modifier
            .fillMaxWidth()
            .shadow(
                elevation = 12.dp,
                shape = RoundedCornerShape(topStart = 24.dp, topEnd = 24.dp),
                spotColor = Color.Black.copy(alpha = 0.05f)
            )
            .background(
                color = Color(0xFFF4F6FA),
                shape = RoundedCornerShape(topStart = 24.dp, topEnd = 24.dp)
            )
            .padding(top = 12.dp, start = 20.dp, end = 20.dp, bottom = 32.dp),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        if (showHeader) {
            Row(
                modifier = Modifier.padding(bottom = 16.dp),
                verticalAlignment = Alignment.CenterVertically,
                horizontalArrangement = Arrangement.Center
            ) {
                ShieldCheckmarkIconCanvas(modifier = Modifier.size(18.dp))
                Spacer(modifier = Modifier.width(8.dp))
                Text(
                    text = "Secure Keypad Active",
                    color = Color(0xFF003399),
                    fontSize = 14.sp,
                    fontWeight = FontWeight.SemiBold
                )
            }
        }

        // 11 Slots + 1 Backspace = 12 Items total (4 rows of 3)
        // ShuffledKeys has 11 items. Backspace is the last item.
        val gridItems = buildList {
            addAll(shuffledKeys)
            add("backspace")
        }

        gridItems.chunked(3).forEach { row ->
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.spacedBy(12.dp)
            ) {
                row.forEach { item ->
                    when (item) {
                        "shield" -> {
                            Box(
                                modifier = Modifier
                                    .weight(1f)
                                    .height(56.dp),
                                contentAlignment = Alignment.Center
                            ) {
                                ShieldHalfIconCanvas(modifier = Modifier.size(26.dp))
                            }
                        }
                        "backspace" -> {
                            Box(
                                modifier = Modifier
                                    .weight(1f)
                                    .height(56.dp)
                                    .clip(RoundedCornerShape(12.dp))
                                    .clickable(
                                        interactionSource = remember { MutableInteractionSource() },
                                        indication = androidx.compose.material.ripple.rememberRipple(),
                                        onClick = { onPress("backspace") }
                                    ),
                                contentAlignment = Alignment.Center
                            ) {
                                BackspaceIconCanvas(tint = Color(0xFF1A2A5E))
                            }
                        }
                        else -> {
                            SecureKeypadButton(
                                modifier = Modifier.weight(1f),
                                num = item,
                                alpha = lettersMap[item] ?: " ",
                                onClick = { onPress(item) }
                            )
                        }
                    }
                }
            }
            Spacer(modifier = Modifier.height(12.dp))
        }
    }
}

@Composable
private fun SecureKeypadButton(
    modifier: Modifier = Modifier,
    num: String,
    alpha: String,
    onClick: () -> Unit
) {
    Box(
        modifier = modifier
            .height(56.dp)
            .shadow(2.dp, RoundedCornerShape(12.dp), spotColor = Color.Black.copy(alpha = 0.02f))
            .background(Color.White, RoundedCornerShape(12.dp))
            .border(1.dp, Color(0xFFE2E8F0), RoundedCornerShape(12.dp))
            .clip(RoundedCornerShape(12.dp))
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
                color = Color(0xFF1A2A5E),
                fontWeight = FontWeight.SemiBold,
                lineHeight = 26.sp
            )
            Text(
                text = alpha,
                fontSize = 10.sp,
                color = Color(0xFF718096),
                fontWeight = FontWeight.SemiBold,
                letterSpacing = 1.sp,
                lineHeight = 10.sp
            )
        }
    }
}

@Composable
internal fun ShieldCheckmarkIconCanvas(modifier: Modifier = Modifier) {
    Canvas(modifier = modifier) {
        val w = size.width
        val h = size.height
        val path = Path().apply {
            moveTo(w * 0.5f, h * 0.1f)
            lineTo(w * 0.9f, h * 0.25f)
            lineTo(w * 0.9f, h * 0.6f)
            cubicTo(w * 0.9f, h * 0.8f, w * 0.5f, h * 0.9f, w * 0.5f, h * 0.9f)
            cubicTo(w * 0.5f, h * 0.9f, w * 0.1f, h * 0.8f, w * 0.1f, h * 0.6f)
            lineTo(w * 0.1f, h * 0.25f)
            close()
        }
        drawPath(
            path = path,
            color = Color(0xFF3880FF),
            style = Stroke(width = 2.dp.toPx(), join = StrokeJoin.Round)
        )
        // Checkmark
        val checkPath = Path().apply {
            moveTo(w * 0.3f, h * 0.5f)
            lineTo(w * 0.45f, h * 0.65f)
            lineTo(w * 0.7f, h * 0.35f)
        }
        drawPath(
            path = checkPath,
            color = Color(0xFF3880FF),
            style = Stroke(width = 2.dp.toPx(), cap = StrokeCap.Round, join = StrokeJoin.Round)
        )
    }
}

@Composable
internal fun ShieldHalfIconCanvas(modifier: Modifier = Modifier) {
    Canvas(modifier = modifier) {
        val w = size.width
        val h = size.height
        val path = Path().apply {
            moveTo(w * 0.5f, h * 0.1f)
            lineTo(w * 0.9f, h * 0.25f)
            lineTo(w * 0.9f, h * 0.6f)
            cubicTo(w * 0.9f, h * 0.8f, w * 0.5f, h * 0.9f, w * 0.5f, h * 0.9f)
            cubicTo(w * 0.5f, h * 0.9f, w * 0.1f, h * 0.8f, w * 0.1f, h * 0.6f)
            lineTo(w * 0.1f, h * 0.25f)
            close()
        }
        drawPath(
            path = path,
            color = Color(0xFFA0AEC0),
            style = Stroke(width = 2.dp.toPx(), join = StrokeJoin.Round)
        )
        // Draw half filled
        val halfPath = Path().apply {
            moveTo(w * 0.5f, h * 0.1f)
            lineTo(w * 0.9f, h * 0.25f)
            lineTo(w * 0.9f, h * 0.6f)
            cubicTo(w * 0.9f, h * 0.8f, w * 0.5f, h * 0.9f, w * 0.5f, h * 0.9f)
            lineTo(w * 0.5f, h * 0.1f)
            close()
        }
        drawPath(
            path = halfPath,
            color = Color(0xFFA0AEC0).copy(alpha = 0.3f)
        )
    }
}
