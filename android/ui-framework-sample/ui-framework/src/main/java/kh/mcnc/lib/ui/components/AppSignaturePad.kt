package kh.mcnc.lib.ui.components

import android.view.MotionEvent
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.ExperimentalComposeUiApi
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Path
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.graphics.StrokeJoin
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.input.pointer.pointerInteropFilter
import androidx.compose.ui.unit.dp

@OptIn(ExperimentalComposeUiApi::class)
@Composable
fun AppSignaturePad(
    modifier: Modifier = Modifier,
    onClear: () -> Unit = {},
    strokeColor: Color = MaterialTheme.colorScheme.onSurface,
    strokeWidth: Float = 8f
) {
    val paths = remember { mutableStateListOf<Path>() }
    var currentPath by remember { mutableStateOf<Path?>(null) }
    var currentPosition by remember { mutableStateOf(Offset.Unspecified) }

    Column(modifier = modifier) {
        Box(
            modifier = Modifier
                .fillMaxWidth()
                .height(200.dp)
                .clip(RoundedCornerShape(12.dp))
                .background(MaterialTheme.colorScheme.surfaceVariant.copy(alpha = 0.5f))
                .border(
                    width = 1.dp,
                    color = MaterialTheme.colorScheme.outline,
                    shape = RoundedCornerShape(12.dp)
                )
                .pointerInteropFilter { motionEvent ->
                    val x = motionEvent.x
                    val y = motionEvent.y
                    when (motionEvent.action) {
                        MotionEvent.ACTION_DOWN -> {
                            val newPath = Path().apply {
                                moveTo(x, y)
                            }
                            currentPath = newPath
                            currentPosition = Offset(x, y)
                            true
                        }
                        MotionEvent.ACTION_MOVE -> {
                            currentPosition = Offset(x, y)
                            currentPath?.lineTo(x, y)
                            true
                        }
                        MotionEvent.ACTION_UP, MotionEvent.ACTION_CANCEL -> {
                            currentPath?.let {
                                paths.add(it)
                            }
                            currentPath = null
                            currentPosition = Offset.Unspecified
                            true
                        }
                        else -> false
                    }
                }
        ) {
            Canvas(modifier = Modifier.fillMaxSize()) {
                val stroke = Stroke(
                    width = strokeWidth,
                    cap = StrokeCap.Round,
                    join = StrokeJoin.Round
                )
                
                paths.forEach { path ->
                    drawPath(
                        path = path,
                        color = strokeColor,
                        style = stroke
                    )
                }
                
                currentPath?.let { path ->
                    drawPath(
                        path = path,
                        color = strokeColor,
                        style = stroke
                    )
                }
            }
            
            if (paths.isEmpty() && currentPath == null) {
                Text(
                    text = "Sign here",
                    color = MaterialTheme.colorScheme.onSurfaceVariant.copy(alpha = 0.5f),
                    modifier = Modifier.align(Alignment.Center)
                )
            }
        }
        
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(top = 8.dp),
            horizontalArrangement = Arrangement.End
        ) {
            TextButton(onClick = {
                paths.clear()
                currentPath = null
                onClear()
            }) {
                Text("Clear")
            }
        }
    }
}
