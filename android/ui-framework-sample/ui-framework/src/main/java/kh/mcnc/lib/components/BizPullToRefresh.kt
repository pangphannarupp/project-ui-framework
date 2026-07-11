package kh.mcnc.lib.components

import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.rotate
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.input.nestedscroll.NestedScrollConnection
import androidx.compose.ui.input.nestedscroll.NestedScrollSource
import androidx.compose.ui.input.nestedscroll.nestedScroll
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.unit.Velocity
import androidx.compose.ui.unit.dp

@Composable
fun BizPullToRefresh(
    isRefreshing: Boolean,
    onRefresh: () -> Unit,
    content: @Composable () -> Unit
) {
    val thresholdPx = with(LocalDensity.current) { 60.dp.toPx() }
    val maxPullPx = with(LocalDensity.current) { 100.dp.toPx() }
    
    var pullDistance by remember { mutableFloatStateOf(0f) }
    
    val nestedScrollConnection = remember(isRefreshing) {
        object : NestedScrollConnection {
            override fun onPreScroll(available: Offset, source: NestedScrollSource): Offset {
                return if (isRefreshing) Offset.Zero else {
                    if (available.y < 0 && pullDistance > 0) {
                        val newPull = (pullDistance + available.y).coerceAtLeast(0f)
                        val consumed = pullDistance - newPull
                        pullDistance = newPull
                        Offset(0f, -consumed)
                    } else {
                        Offset.Zero
                    }
                }
            }

            override fun onPostScroll(
                consumed: Offset,
                available: Offset,
                source: NestedScrollSource
            ): Offset {
                return if (isRefreshing) Offset.Zero else {
                    if (available.y > 0) {
                        val newPull = (pullDistance + available.y * 0.5f).coerceAtMost(maxPullPx)
                        val consumedY = newPull - pullDistance
                        pullDistance = newPull
                        Offset(0f, available.y)
                    } else {
                        Offset.Zero
                    }
                }
            }
            
            override suspend fun onPreFling(available: Velocity): Velocity {
                if (pullDistance >= thresholdPx && !isRefreshing) {
                    onRefresh()
                }
                pullDistance = 0f
                return super.onPreFling(available)
            }
        }
    }

    Box(
        modifier = Modifier
            .fillMaxSize()
            .background(Color(0xFFF4F5F8))
            .nestedScroll(nestedScrollConnection)
    ) {
        val pullProgress = (pullDistance / thresholdPx).coerceIn(0f, 1f)
        val indicatorHeight = with(LocalDensity.current) { pullDistance.toDp() }
        
        Column(modifier = Modifier.fillMaxSize()) {
            Box(
                modifier = Modifier
                    .fillMaxWidth()
                    .height(if (isRefreshing) 60.dp else indicatorHeight),
                contentAlignment = Alignment.Center
            ) {
                if (isRefreshing) {
                    CircularProgressIndicator(
                        modifier = Modifier.size(24.dp),
                        color = Color(0xFF1A2A5E),
                        strokeWidth = 2.dp
                    )
                } else if (pullDistance > 0) {
                    val rotation by animateFloatAsState(targetValue = if (pullProgress >= 1f) 180f else 0f)
                    Box(modifier = Modifier.rotate(rotation)) {
                        Text("↓", color = Color(0xFF1A2A5E))
                    }
                }
            }
            
            Box(modifier = Modifier.weight(1f)) {
                content()
            }
        }
    }
}
