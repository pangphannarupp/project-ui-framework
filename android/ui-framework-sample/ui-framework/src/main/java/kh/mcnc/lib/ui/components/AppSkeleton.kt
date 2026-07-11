package kh.mcnc.lib.ui.components

import androidx.compose.animation.core.*
import androidx.compose.foundation.background
import androidx.compose.ui.Modifier
import androidx.compose.ui.composed
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Shape

fun Modifier.appSkeleton(
    visible: Boolean = true,
    shape: Shape? = null,
    baseColor: Color = Color(0xFFE0E0E0),
    highlightColor: Color = Color(0xFFF5F5F5)
): Modifier = composed {
    if (!visible) return@composed this

    val transition = rememberInfiniteTransition(label = "skeleton_transition")
    val translateAnimation = transition.animateFloat(
        initialValue = 0f,
        targetValue = 1000f,
        animationSpec = infiniteRepeatable(
            animation = tween(
                durationMillis = 1000,
                easing = FastOutSlowInEasing
            ),
            repeatMode = RepeatMode.Restart
        ),
        label = "skeleton_shimmer"
    )

    val brush = Brush.linearGradient(
        colors = listOf(
            baseColor,
            highlightColor,
            baseColor,
        ),
        start = Offset.Zero,
        end = Offset(x = translateAnimation.value, y = translateAnimation.value)
    )

    if (shape != null) {
        this.background(brush, shape)
    } else {
        this.background(brush)
    }
}
