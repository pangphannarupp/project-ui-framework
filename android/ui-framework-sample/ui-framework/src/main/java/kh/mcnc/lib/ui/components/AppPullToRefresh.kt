package kh.mcnc.lib.ui.components

import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.foundation.background
import androidx.compose.foundation.gestures.detectDragGestures
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Refresh
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.rotate
import androidx.compose.ui.draw.scale
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.unit.IntOffset
import androidx.compose.ui.unit.dp
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlin.math.roundToInt

@Composable
fun AppPullToRefresh(
    modifier: Modifier = Modifier,
    onRefresh: suspend () -> Unit = {},
    content: @Composable () -> Unit
) {
    var isRefreshing by remember { mutableStateOf(false) }
    var dragOffset by remember { mutableStateOf(0f) }
    val maxDrag = 300f
    val refreshThreshold = 150f

    val scope = rememberCoroutineScope()

    val animatedOffset by animateFloatAsState(targetValue = if (isRefreshing) refreshThreshold else dragOffset, label = "ptr_offset")
    val animatedScale by animateFloatAsState(targetValue = (animatedOffset / refreshThreshold).coerceIn(0f, 1f), label = "ptr_scale")

    Box(
        modifier = modifier.pointerInput(isRefreshing) {
            if (!isRefreshing) {
                detectDragGestures(
                    onDragEnd = {
                        if (dragOffset >= refreshThreshold) {
                            isRefreshing = true
                            scope.launch {
                                onRefresh()
                                isRefreshing = false
                                dragOffset = 0f
                            }
                        } else {
                            dragOffset = 0f
                        }
                    },
                    onDragCancel = { dragOffset = 0f },
                    onDrag = { change, dragAmount ->
                        if (dragAmount.y > 0 || dragOffset > 0) {
                            dragOffset = (dragOffset + dragAmount.y * 0.5f).coerceIn(0f, maxDrag)
                            change.consume()
                        }
                    }
                )
            }
        }
    ) {
        // Content
        Box(modifier = Modifier.offset { IntOffset(0, animatedOffset.roundToInt()) }) {
            content()
        }

        // Indicator
        if (animatedOffset > 0f) {
            Box(
                modifier = Modifier
                    .align(Alignment.TopCenter)
                    .offset { IntOffset(0, (animatedOffset - 40f).roundToInt()) } // 40f is indicator height approx
                    .size(40.dp)
                    .scale(animatedScale)
                    .clip(CircleShape)
                    .background(Color.White)
                    .padding(8.dp),
                contentAlignment = Alignment.Center
            ) {
                if (isRefreshing) {
                    CircularProgressIndicator(
                        modifier = Modifier.size(24.dp),
                        strokeWidth = 2.dp,
                        color = MaterialTheme.colorScheme.primary
                    )
                } else {
                    Icon(
                        imageVector = Icons.Default.Refresh,
                        contentDescription = "Pull to refresh",
                        modifier = Modifier.rotate(dragOffset),
                        tint = MaterialTheme.colorScheme.primary
                    )
                }
            }
        }
    }
}
