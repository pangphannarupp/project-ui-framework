package kh.mcnc.lib.ui.components

import androidx.compose.animation.AnimatedVisibility
import androidx.compose.animation.expandVertically
import androidx.compose.animation.shrinkVertically
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ChevronRight
import androidx.compose.material.icons.filled.ExpandMore
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp

data class TreeNode(
    val id: String,
    val label: String,
    val children: List<TreeNode> = emptyList()
)

@Composable
fun AppTreeSelect(
    nodes: List<TreeNode>,
    onNodeSelected: (TreeNode) -> Unit,
    modifier: Modifier = Modifier
) {
    Column(modifier = modifier.fillMaxWidth()) {
        nodes.forEach { node ->
            TreeItem(node = node, level = 0, onNodeSelected = onNodeSelected)
        }
    }
}

@Composable
private fun TreeItem(
    node: TreeNode,
    level: Int,
    onNodeSelected: (TreeNode) -> Unit
) {
    var isExpanded by remember { mutableStateOf(false) }
    val hasChildren = node.children.isNotEmpty()
    
    Column(modifier = Modifier.fillMaxWidth()) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .clickable {
                    if (hasChildren) {
                        isExpanded = !isExpanded
                    } else {
                        onNodeSelected(node)
                    }
                }
                .padding(vertical = 12.dp, horizontal = 16.dp)
                .padding(start = (level * 24).dp), // Indentation
            verticalAlignment = Alignment.CenterVertically
        ) {
            if (hasChildren) {
                Icon(
                    imageVector = if (isExpanded) Icons.Default.ExpandMore else Icons.Default.ChevronRight,
                    contentDescription = if (isExpanded) "Collapse" else "Expand",
                    tint = MaterialTheme.colorScheme.onSurfaceVariant,
                    modifier = Modifier.size(24.dp)
                )
            } else {
                Spacer(modifier = Modifier.size(24.dp)) // Placeholder for alignment
            }
            
            Spacer(modifier = Modifier.width(8.dp))
            
            Text(
                text = node.label,
                style = MaterialTheme.typography.bodyLarge,
                color = if (hasChildren) MaterialTheme.colorScheme.onSurface else MaterialTheme.colorScheme.onSurfaceVariant
            )
        }
        
        if (hasChildren) {
            AnimatedVisibility(
                visible = isExpanded,
                enter = expandVertically(),
                exit = shrinkVertically()
            ) {
                Column {
                    node.children.forEach { child ->
                        TreeItem(node = child, level = level + 1, onNodeSelected = onNodeSelected)
                    }
                }
            }
        }
    }
}
