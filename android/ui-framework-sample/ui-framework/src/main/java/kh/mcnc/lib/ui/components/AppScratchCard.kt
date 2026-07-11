package kh.mcnc.lib.ui.components

import android.view.MotionEvent
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.runtime.*
import androidx.compose.ui.ExperimentalComposeUiApi
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.geometry.Rect
import androidx.compose.ui.graphics.ClipOp
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Path
import androidx.compose.ui.graphics.SolidColor
import androidx.compose.ui.graphics.drawscope.clipPath
import androidx.compose.ui.input.pointer.pointerInteropFilter

@OptIn(ExperimentalComposeUiApi::class)
@Composable
fun AppScratchCard(
    modifier: Modifier = Modifier,
    overlayColor: Color = Color.LightGray,
    scratchBrushSize: Float = 60f,
    content: @Composable () -> Unit
) {
    val paths = remember { mutableStateListOf<Path>() }
    var currentPath by remember { mutableStateOf<Path?>(null) }

    Box(
        modifier = modifier
            .pointerInteropFilter { motionEvent ->
                val x = motionEvent.x
                val y = motionEvent.y
                when (motionEvent.action) {
                    MotionEvent.ACTION_DOWN -> {
                        val newPath = Path().apply {
                            moveTo(x, y)
                            // Add a small circle so a single tap creates a hole
                            addOval(Rect(center = Offset(x, y), radius = scratchBrushSize / 2f))
                        }
                        currentPath = newPath
                        true
                    }
                    MotionEvent.ACTION_MOVE -> {
                        currentPath?.apply {
                            lineTo(x, y)
                            addOval(Rect(center = Offset(x, y), radius = scratchBrushSize / 2f))
                        }
                        true
                    }
                    MotionEvent.ACTION_UP, MotionEvent.ACTION_CANCEL -> {
                        currentPath?.let { paths.add(it) }
                        currentPath = null
                        true
                    }
                    else -> false
                }
            }
    ) {
        // Hidden Content
        content()

        // Scratch Overlay
        Canvas(modifier = Modifier.fillMaxSize()) {
            val fullRectPath = Path().apply {
                addRect(Rect(0f, 0f, size.width, size.height))
            }
            
            val scratchPath = Path()
            paths.forEach { scratchPath.addPath(it) }
            currentPath?.let { scratchPath.addPath(it) }
            
            val remainingPath = Path.combine(
                operation = androidx.compose.ui.graphics.PathOperation.Difference,
                path1 = fullRectPath,
                path2 = scratchPath
            )

            clipPath(remainingPath) {
                drawRect(color = overlayColor)
            }
        }
    }
}
