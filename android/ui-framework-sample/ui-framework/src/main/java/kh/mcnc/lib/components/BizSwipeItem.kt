package kh.mcnc.lib.components

import androidx.compose.foundation.background
import androidx.compose.foundation.gestures.Orientation
import androidx.compose.foundation.gestures.draggable
import androidx.compose.foundation.gestures.rememberDraggableState
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.offset
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableFloatStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.onSizeChanged
import androidx.compose.ui.unit.IntOffset
import kotlin.math.roundToInt

@Composable
fun BizSwipeItem(
    leftActions: @Composable (() -> Unit)? = null,
    rightActions: @Composable (() -> Unit)? = null,
    content: @Composable () -> Unit
) {
    var offsetX by remember { mutableFloatStateOf(0f) }
    var leftWidth by remember { mutableFloatStateOf(0f) }
    var rightWidth by remember { mutableFloatStateOf(0f) }

    val draggableState = rememberDraggableState { delta ->
        val newX = offsetX + delta
        // resistance
        offsetX = if (newX > 0 && leftActions == null) {
            newX * 0.1f
        } else if (newX < 0 && rightActions == null) {
            newX * 0.1f
        } else if (newX > leftWidth) {
            leftWidth + (newX - leftWidth) * 0.2f
        } else if (newX < -rightWidth) {
            -rightWidth + (newX + rightWidth) * 0.2f
        } else {
            newX
        }
    }

    Box(
        modifier = Modifier
            .fillMaxWidth()
            .background(Color(0xFFF4F5F8))
            .draggable(
                state = draggableState,
                orientation = Orientation.Horizontal,
                onDragStopped = {
                    val threshold = 40f
                    offsetX = if (offsetX > threshold && leftWidth > 0) {
                        leftWidth
                    } else if (offsetX < -threshold && rightWidth > 0) {
                        -rightWidth
                    } else {
                        0f
                    }
                }
            )
    ) {
        // Actions container that matches the height of the content
        Box(modifier = Modifier.matchParentSize()) {
            if (leftActions != null) {
                Row(
                    modifier = Modifier
                        .align(Alignment.CenterStart)
                        .fillMaxHeight()
                        .onSizeChanged { leftWidth = it.width.toFloat() }
                ) {
                    leftActions()
                }
            }

            if (rightActions != null) {
                Row(
                    modifier = Modifier
                        .align(Alignment.CenterEnd)
                        .fillMaxHeight()
                        .onSizeChanged { rightWidth = it.width.toFloat() }
                ) {
                    rightActions()
                }
            }
        }

        Box(
            modifier = Modifier
                .fillMaxWidth()
                .offset { IntOffset(offsetX.roundToInt(), 0) }
                .background(Color.White)
        ) {
            content()
        }
    }
}
