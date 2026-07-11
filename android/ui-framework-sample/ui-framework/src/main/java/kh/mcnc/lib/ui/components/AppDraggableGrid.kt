package kh.mcnc.lib.ui.components

import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.background
import androidx.compose.foundation.gestures.detectDragGesturesAfterLongPress
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.scale
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.zIndex

data class DashboardWidget(val id: String, val title: String, val color: Color)

@OptIn(ExperimentalFoundationApi::class)
@Composable
fun AppDraggableGrid(
    widgets: List<DashboardWidget>,
    onReorder: (from: Int, to: Int) -> Unit,
    modifier: Modifier = Modifier
) {
    var draggingId by remember { mutableStateOf<String?>(null) }
    
    // In a full implementation, we'd calculate intersection of dragging item with others.
    // For this UI component, we'll simulate the layout and styling of a draggable grid.

    LazyVerticalGrid(
        columns = GridCells.Fixed(2),
        contentPadding = PaddingValues(16.dp),
        horizontalArrangement = Arrangement.spacedBy(16.dp),
        verticalArrangement = Arrangement.spacedBy(16.dp),
        modifier = modifier.fillMaxWidth().height(400.dp)
    ) {
        items(widgets, key = { it.id }) { widget ->
            val isDragging = draggingId == widget.id
            val scale by animateFloatAsState(if (isDragging) 1.05f else 1f, label = "scale")
            val elevation = if (isDragging) 12.dp else 2.dp
            
            Card(
                modifier = Modifier
                    .height(120.dp)
                    .zIndex(if (isDragging) 1f else 0f)
                    .scale(scale)
                    .pointerInput(Unit) {
                        detectDragGesturesAfterLongPress(
                            onDragStart = { draggingId = widget.id },
                            onDragEnd = { draggingId = null },
                            onDragCancel = { draggingId = null },
                            onDrag = { change, dragAmount -> 
                                change.consume()
                                // Drag logic to determine 'to' index would go here
                            }
                        )
                    },
                elevation = CardDefaults.cardElevation(defaultElevation = elevation),
                shape = RoundedCornerShape(16.dp)
            ) {
                Box(
                    modifier = Modifier
                        .fillMaxSize()
                        .background(widget.color.copy(alpha = 0.2f))
                        .padding(16.dp),
                    contentAlignment = Alignment.Center
                ) {
                    Text(
                        text = widget.title,
                        style = MaterialTheme.typography.titleMedium,
                        fontWeight = FontWeight.Bold,
                        color = MaterialTheme.colorScheme.onSurface
                    )
                }
            }
        }
    }
}
