package kh.mcnc.lib.components

import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.offset
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.scale
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.IntOffset
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import kotlinx.coroutines.delay

@Composable
fun BizPinDots(
    value: String,
    modifier: Modifier = Modifier,
    length: Int = 6,
    error: Boolean = false,
    errorText: String = "PIN does not match. Please try again.",
    success: Boolean = false
) {
    var shakeOffset by remember { mutableStateOf(0f) }
    LaunchedEffect(error) {
        if (error) {
            shakeOffset = -8f
            delay(100)
            shakeOffset = 8f
            delay(100)
            shakeOffset = -8f
            delay(100)
            shakeOffset = 0f
        }
    }
    val animatedShakeOffset by animateFloatAsState(targetValue = shakeOffset, label = "shake")

    Column(
        modifier = modifier.fillMaxWidth(),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.spacedBy(16.dp)
    ) {
        Row(
            modifier = Modifier.offset { IntOffset(animatedShakeOffset.toInt(), 0) },
            horizontalArrangement = Arrangement.spacedBy(16.dp),
            verticalAlignment = Alignment.CenterVertically
        ) {
            for (i in 0 until length) {
                val isFilled = value.length > i
                
                val borderColor = when {
                    success -> Color(0xFF52C41A)
                    error -> Color(0xFFFF4D4F)
                    else -> Color(0xFF003399) // biz-primary
                }
                
                val bgColor = when {
                    success -> Color(0xFF52C41A)
                    error && isFilled -> Color(0xFFFF4D4F)
                    isFilled -> Color(0xFF003399)
                    else -> Color.Transparent
                }
                
                var scale by remember { mutableStateOf(1f) }
                LaunchedEffect(success) {
                    if (success) {
                        delay(i * 50L) // stagger effect
                        scale = 1.25f
                        delay(200)
                        scale = 1f
                    }
                }
                val animatedScale by animateFloatAsState(targetValue = scale, label = "scale")
                
                Box(
                    modifier = Modifier
                        .size(16.dp)
                        .scale(animatedScale)
                        .background(bgColor, CircleShape)
                        .border(1.5.dp, borderColor, CircleShape)
                )
            }
        }
        
        if (error && errorText.isNotEmpty()) {
            Row(
                verticalAlignment = Alignment.CenterVertically,
                horizontalArrangement = Arrangement.spacedBy(6.dp)
            ) {
                Box(
                    modifier = Modifier
                        .size(14.dp)
                        .background(Color.Transparent, CircleShape)
                        .border(1.5.dp, Color(0xFFFF4D4F), CircleShape),
                    contentAlignment = Alignment.Center
                ) {
                    Text("!", color = Color(0xFFFF4D4F), fontSize = 10.sp, fontWeight = FontWeight.Bold)
                }
                Text(
                    text = errorText,
                    color = Color(0xFFFF4D4F),
                    fontSize = 13.sp,
                    fontWeight = FontWeight.Medium
                )
            }
        }
    }
}
