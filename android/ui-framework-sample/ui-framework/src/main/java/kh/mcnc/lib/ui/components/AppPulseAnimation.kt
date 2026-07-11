package kh.mcnc.lib.ui.components

import androidx.compose.animation.core.*
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.scale
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp

@Composable
fun AppPulseAnimation(
    modifier: Modifier = Modifier,
    color: Color = MaterialTheme.colorScheme.primary,
    baseSize: Dp = 48.dp,
    content: @Composable () -> Unit
) {
    val infiniteTransition = rememberInfiniteTransition(label = "pulse_anim")
    
    val scale1 by infiniteTransition.animateFloat(
        initialValue = 1f,
        targetValue = 2.5f,
        animationSpec = infiniteRepeatable(
            animation = tween(1500, easing = LinearOutSlowInEasing),
            repeatMode = RepeatMode.Restart
        ),
        label = "pulse_scale_1"
    )
    
    val alpha1 by infiniteTransition.animateFloat(
        initialValue = 0.6f,
        targetValue = 0f,
        animationSpec = infiniteRepeatable(
            animation = tween(1500, easing = LinearOutSlowInEasing),
            repeatMode = RepeatMode.Restart
        ),
        label = "pulse_alpha_1"
    )

    val scale2 by infiniteTransition.animateFloat(
        initialValue = 1f,
        targetValue = 2f,
        animationSpec = infiniteRepeatable(
            animation = tween(1500, delayMillis = 500, easing = LinearOutSlowInEasing),
            repeatMode = RepeatMode.Restart
        ),
        label = "pulse_scale_2"
    )
    
    val alpha2 by infiniteTransition.animateFloat(
        initialValue = 0.6f,
        targetValue = 0f,
        animationSpec = infiniteRepeatable(
            animation = tween(1500, delayMillis = 500, easing = LinearOutSlowInEasing),
            repeatMode = RepeatMode.Restart
        ),
        label = "pulse_alpha_2"
    )

    Box(
        modifier = modifier,
        contentAlignment = Alignment.Center
    ) {
        // Outer pulse
        Box(
            modifier = Modifier
                .size(baseSize)
                .scale(scale1)
                .background(color = color.copy(alpha = alpha1), shape = CircleShape)
        )
        // Inner pulse
        Box(
            modifier = Modifier
                .size(baseSize)
                .scale(scale2)
                .background(color = color.copy(alpha = alpha2), shape = CircleShape)
        )
        // Content
        Box(modifier = Modifier.size(baseSize), contentAlignment = Alignment.Center) {
            content()
        }
    }
}
