package kh.mcnc.lib.ui.components

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.CheckCircle
import androidx.compose.material.icons.outlined.Circle
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp

data class TimelineItemData(
    val title: String,
    val description: String? = null,
    val time: String? = null,
    val isCompleted: Boolean = false,
    val isCurrent: Boolean = false
)

@Composable
fun AppTimeline(
    items: List<TimelineItemData>,
    modifier: Modifier = Modifier
) {
    Column(modifier = modifier.fillMaxWidth()) {
        items.forEachIndexed { index, item ->
            val isLast = index == items.size - 1
            
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .height(IntrinsicSize.Min) // Allows the vertical line to stretch correctly
            ) {
                // Left Column: Line & Indicator
                Column(
                    horizontalAlignment = Alignment.CenterHorizontally,
                    modifier = Modifier.width(40.dp)
                ) {
                    // Indicator Icon
                    if (item.isCompleted) {
                        Icon(
                            imageVector = Icons.Default.CheckCircle,
                            contentDescription = "Completed",
                            tint = MaterialTheme.colorScheme.primary,
                            modifier = Modifier.size(24.dp)
                        )
                    } else if (item.isCurrent) {
                        Box(
                            modifier = Modifier
                                .size(24.dp)
                                .clip(CircleShape)
                                .background(MaterialTheme.colorScheme.primary.copy(alpha = 0.2f)),
                            contentAlignment = Alignment.Center
                        ) {
                            Box(
                                modifier = Modifier
                                    .size(12.dp)
                                    .clip(CircleShape)
                                    .background(MaterialTheme.colorScheme.primary)
                            )
                        }
                    } else {
                        Icon(
                            imageVector = Icons.Outlined.Circle,
                            contentDescription = "Pending",
                            tint = Color.LightGray,
                            modifier = Modifier.size(24.dp)
                        )
                    }
                    
                    // Vertical Line
                    if (!isLast) {
                        Box(
                            modifier = Modifier
                                .width(2.dp)
                                .fillMaxHeight()
                                .padding(vertical = 4.dp)
                                .background(
                                    if (item.isCompleted) MaterialTheme.colorScheme.primary else Color.LightGray
                                )
                        )
                    }
                }
                
                // Right Column: Content
                Column(
                    modifier = Modifier
                        .weight(1f)
                        .padding(start = 12.dp, bottom = if (isLast) 0.dp else 24.dp)
                ) {
                    Row(
                        modifier = Modifier.fillMaxWidth(),
                        horizontalArrangement = Arrangement.SpaceBetween,
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        Text(
                            text = item.title,
                            style = MaterialTheme.typography.titleMedium,
                            fontWeight = if (item.isCurrent) FontWeight.Bold else FontWeight.SemiBold,
                            color = if (item.isCompleted || item.isCurrent) MaterialTheme.colorScheme.onSurface else Color.Gray
                        )
                        
                        if (item.time != null) {
                            Text(
                                text = item.time,
                                style = MaterialTheme.typography.bodySmall,
                                color = Color.Gray
                            )
                        }
                    }
                    
                    if (item.description != null) {
                        Spacer(modifier = Modifier.height(4.dp))
                        Text(
                            text = item.description,
                            style = MaterialTheme.typography.bodyMedium,
                            color = Color.Gray
                        )
                    }
                }
            }
        }
    }
}
