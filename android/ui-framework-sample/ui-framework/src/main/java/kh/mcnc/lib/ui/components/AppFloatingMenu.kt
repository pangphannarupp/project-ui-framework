package kh.mcnc.lib.ui.components

import androidx.compose.animation.AnimatedVisibility
import androidx.compose.animation.core.Spring
import androidx.compose.animation.core.spring
import androidx.compose.animation.fadeIn
import androidx.compose.animation.fadeOut
import androidx.compose.animation.scaleIn
import androidx.compose.animation.scaleOut
import androidx.compose.foundation.background
import androidx.compose.foundation.gestures.detectDragGestures
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.rotate
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.unit.IntOffset
import androidx.compose.ui.unit.dp
import kotlin.math.roundToInt

data class FloatingMenuAction(
    val icon: ImageVector,
    val contentDescription: String,
    val onClick: () -> Unit
)

@Composable
fun AppFloatingMenu(
    actions: List<FloatingMenuAction>,
    modifier: Modifier = Modifier
) {
    var isExpanded by remember { mutableStateOf(false) }
    var offsetX by remember { mutableStateOf(0f) }
    var offsetY by remember { mutableStateOf(0f) }

    Box(modifier = modifier.fillMaxSize()) {
        Box(
            modifier = Modifier
                .offset { IntOffset(offsetX.roundToInt(), offsetY.roundToInt()) }
                .pointerInput(Unit) {
                    detectDragGestures(
                        onDragEnd = {
                            // In a real app, calculate snapping to edge
                            // We just leave it where it was dropped for this demo
                        }
                    ) { change, dragAmount ->
                        change.consume()
                        offsetX += dragAmount.x
                        offsetY += dragAmount.y
                    }
                }
        ) {
            Column(
                horizontalAlignment = Alignment.CenterHorizontally,
                verticalArrangement = Arrangement.spacedBy(12.dp)
            ) {
                // Expanded Actions
                AnimatedVisibility(
                    visible = isExpanded,
                    enter = fadeIn() + scaleIn(spring(stiffness = Spring.StiffnessMediumLow)),
                    exit = fadeOut() + scaleOut(spring(stiffness = Spring.StiffnessMediumLow))
                ) {
                    Column(
                        verticalArrangement = Arrangement.spacedBy(12.dp),
                        horizontalAlignment = Alignment.CenterHorizontally
                    ) {
                        actions.forEach { action ->
                            SmallFloatingActionButton(
                                onClick = {
                                    action.onClick()
                                    isExpanded = false
                                },
                                containerColor = MaterialTheme.colorScheme.secondaryContainer,
                                contentColor = MaterialTheme.colorScheme.onSecondaryContainer,
                                elevation = FloatingActionButtonDefaults.elevation(defaultElevation = 4.dp)
                            ) {
                                Icon(
                                    imageVector = action.icon,
                                    contentDescription = action.contentDescription
                                )
                            }
                        }
                    }
                }

                // Main Toggle Button
                FloatingActionButton(
                    onClick = { isExpanded = !isExpanded },
                    containerColor = if (isExpanded) MaterialTheme.colorScheme.tertiary else MaterialTheme.colorScheme.primary,
                    contentColor = if (isExpanded) MaterialTheme.colorScheme.onTertiary else MaterialTheme.colorScheme.onPrimary,
                    shape = CircleShape,
                    elevation = FloatingActionButtonDefaults.elevation(defaultElevation = 8.dp)
                ) {
                    Icon(
                        imageVector = Icons.Default.Add,
                        contentDescription = "Toggle Menu",
                        modifier = Modifier.rotate(if (isExpanded) 45f else 0f)
                    )
                }
            }
        }
    }
}
