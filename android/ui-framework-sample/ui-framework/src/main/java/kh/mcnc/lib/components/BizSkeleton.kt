package kh.mcnc.lib.components

import androidx.compose.animation.core.*
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp

@Composable
fun Modifier.shimmerEffect(): Modifier {
    val shimmerColors = listOf(
        Color(0xFFF0F0F0),
        Color(0xFFE0E0E0),
        Color(0xFFF0F0F0)
    )

    val transition = rememberInfiniteTransition(label = "")
    val translateAnimation = transition.animateFloat(
        initialValue = 0f,
        targetValue = 1000f,
        animationSpec = infiniteRepeatable(
            animation = tween(1500, easing = LinearEasing),
            repeatMode = RepeatMode.Restart
        ),
        label = ""
    )

    return this.background(
        brush = Brush.linearGradient(
            colors = shimmerColors,
            start = Offset(translateAnimation.value - 200f, translateAnimation.value - 200f),
            end = Offset(translateAnimation.value, translateAnimation.value)
        )
    )
}

@Composable
fun BizSkeletonText(modifier: Modifier = Modifier) {
    Box(
        modifier = modifier
            .fillMaxWidth()
            .height(20.dp)
            .shimmerEffect()
            .background(Color.Transparent, RoundedCornerShape(4.dp))
    )
}
