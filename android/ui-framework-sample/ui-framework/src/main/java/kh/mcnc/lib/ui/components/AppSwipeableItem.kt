package kh.mcnc.lib.ui.components

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Delete
import androidx.compose.material.icons.filled.Edit
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.rememberUpdatedState
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.unit.dp

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun AppSwipeableItem(
    modifier: Modifier = Modifier,
    onDelete: (() -> Unit)? = null,
    onEdit: (() -> Unit)? = null,
    deleteIcon: ImageVector = Icons.Default.Delete,
    editIcon: ImageVector = Icons.Default.Edit,
    content: @Composable () -> Unit
) {
    val currentOnDelete by rememberUpdatedState(onDelete)
    val currentOnEdit by rememberUpdatedState(onEdit)

    val dismissState = rememberSwipeToDismissBoxState(
        confirmValueChange = { dismissValue ->
            when (dismissValue) {
                SwipeToDismissBoxValue.StartToEnd -> {
                    currentOnEdit?.invoke()
                    false
                }
                SwipeToDismissBoxValue.EndToStart -> {
                    currentOnDelete?.invoke()
                    false // Don't actually dismiss the UI automatically, let the caller handle list removal
                }
                SwipeToDismissBoxValue.Settled -> false
            }
        }
    )

    SwipeToDismissBox(
        state = dismissState,
        modifier = modifier,
        enableDismissFromStartToEnd = onEdit != null,
        enableDismissFromEndToStart = onDelete != null,
        backgroundContent = {
            val direction = dismissState.dismissDirection
            
            val color = when (direction) {
                SwipeToDismissBoxValue.StartToEnd -> Color(0xFF1976D2) // Edit (Blue)
                SwipeToDismissBoxValue.EndToStart -> Color(0xFFD32F2F) // Delete (Red)
                SwipeToDismissBoxValue.Settled -> Color.Transparent
            }
            
            val alignment = when (direction) {
                SwipeToDismissBoxValue.StartToEnd -> Alignment.CenterStart
                SwipeToDismissBoxValue.EndToStart -> Alignment.CenterEnd
                SwipeToDismissBoxValue.Settled -> Alignment.Center
            }
            
            val icon = when (direction) {
                SwipeToDismissBoxValue.StartToEnd -> editIcon
                SwipeToDismissBoxValue.EndToStart -> deleteIcon
                SwipeToDismissBoxValue.Settled -> Icons.Default.Edit // won't be visible
            }

            Box(
                modifier = Modifier
                    .fillMaxSize()
                    .background(color)
                    .padding(horizontal = 20.dp),
                contentAlignment = alignment
            ) {
                Icon(
                    imageVector = icon,
                    contentDescription = "Swipe Action",
                    tint = Color.White
                )
            }
        },
        content = {
            Surface(
                modifier = Modifier.fillMaxWidth(),
                color = MaterialTheme.colorScheme.surface
            ) {
                content()
            }
        }
    )
}
