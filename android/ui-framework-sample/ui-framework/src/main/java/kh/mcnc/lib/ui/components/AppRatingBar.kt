package kh.mcnc.lib.ui.components

import android.view.MotionEvent
import androidx.compose.animation.core.Spring
import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.animation.core.spring
import androidx.compose.foundation.layout.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Star
import androidx.compose.material.icons.filled.StarBorder
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.ExperimentalComposeUiApi
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.scale
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.input.pointer.pointerInteropFilter
import androidx.compose.ui.layout.onGloballyPositioned
import androidx.compose.ui.unit.dp

@OptIn(ExperimentalComposeUiApi::class)
@Composable
fun AppRatingBar(
    rating: Int,
    onRatingChange: (Int) -> Unit,
    modifier: Modifier = Modifier,
    maxRating: Int = 5,
    activeColor: Color = Color(0xFFFFC107),
    inactiveColor: Color = Color.LightGray
) {
    var rowWidth by remember { mutableStateOf(0) }
    
    Row(
        modifier = modifier
            .onGloballyPositioned { rowWidth = it.size.width }
            .pointerInteropFilter { event ->
                when (event.action) {
                    MotionEvent.ACTION_DOWN, MotionEvent.ACTION_MOVE -> {
                        if (rowWidth > 0) {
                            val percent = (event.x / rowWidth).coerceIn(0f, 1f)
                            val newRating = (percent * maxRating + 0.5f).toInt().coerceIn(1, maxRating)
                            if (newRating != rating) {
                                onRatingChange(newRating)
                            }
                        }
                        true
                    }
                    else -> false
                }
            },
        horizontalArrangement = Arrangement.spacedBy(8.dp),
        verticalAlignment = Alignment.CenterVertically
    ) {
        for (i in 1..maxRating) {
            val isSelected = i <= rating
            val scale by animateFloatAsState(
                targetValue = if (isSelected) 1.2f else 1f,
                animationSpec = spring(
                    dampingRatio = Spring.DampingRatioMediumBouncy,
                    stiffness = Spring.StiffnessLow
                ),
                label = "star_scale"
            )
            
            Icon(
                imageVector = if (isSelected) Icons.Default.Star else Icons.Default.StarBorder,
                contentDescription = "Star $i",
                tint = if (isSelected) activeColor else inactiveColor,
                modifier = Modifier
                    .size(40.dp)
                    .scale(scale)
            )
        }
    }
}
