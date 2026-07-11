package kh.mcnc.lib.ui.components

import androidx.compose.animation.AnimatedVisibility
import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ExpandMore
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.rotate
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.PathEffect
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

data class ApprovalNodeData(
    val dateText: String,
    val name: String,
    val roleLabel: String = "Position",
    val role: String = "",
    val statusText: String,
    val statusContainerColor: Color,
    val statusContentColor: Color = Color.White,
    val isCompleted: Boolean,
    val remarkLabel: String = "Remark",
    val remark: String = "",
)

@Composable
fun AppApprovalLine(
    nodes: List<ApprovalNodeData>,
    modifier: Modifier = Modifier
) {
    val lastCompletedIndex = nodes.indexOfLast { it.isCompleted }

    Column(
        modifier = modifier
            .fillMaxWidth()
            .background(Color(0xFFF2F2F2)) // Light gray background like screenshot
            .padding(horizontal = 16.dp, vertical = 24.dp)
    ) {
        nodes.forEachIndexed { index, node ->
            val isLast = index == nodes.size - 1
            val isLineSolid = index <= lastCompletedIndex
            ApprovalNodeItem(
                node = node,
                isLast = isLast,
                isLineSolid = isLineSolid
            )
        }
    }
}

@Composable
private fun ApprovalNodeItem(
    node: ApprovalNodeData,
    isLast: Boolean,
    isLineSolid: Boolean
) {
    var expanded by remember { mutableStateOf(node.isCompleted) }

    val rotationState by animateFloatAsState(targetValue = if (expanded) 180f else 0f, label = "chevron_rotate")

    Row(
        modifier = Modifier
            .fillMaxWidth()
            .height(IntrinsicSize.Min)
    ) {
        // Timeline Column
        Column(
            horizontalAlignment = Alignment.CenterHorizontally,
            modifier = Modifier.width(32.dp)
        ) {
            // Dot
            val dotColor = if (node.isCompleted) Color(0xFF3B82F6) else Color(0xFF6B7280)
            val haloColor = if (node.isCompleted) Color(0xFFDBEAFE) else Color(0xFFE5E7EB)
            
            Box(
                modifier = Modifier
                    .padding(top = 4.dp)
                    .size(20.dp)
                    .clip(CircleShape)
                    .background(haloColor),
                contentAlignment = Alignment.Center
            ) {
                Box(
                    modifier = Modifier
                        .size(12.dp)
                        .clip(CircleShape)
                        .background(dotColor)
                )
            }

            // Line
            if (!isLast) {
                val lineColor = if (isLineSolid) Color(0xFF3B82F6) else Color(0xFF9CA3AF)
                val isDashed = !isLineSolid
                
                Canvas(
                    modifier = Modifier
                        .weight(1f)
                        .width(2.dp)
                        .padding(vertical = 4.dp)
                ) {
                    if (isDashed) {
                        val pathEffect = PathEffect.dashPathEffect(floatArrayOf(10f, 10f), 0f)
                        drawLine(
                            color = lineColor,
                            start = Offset(size.width / 2, 0f),
                            end = Offset(size.width / 2, size.height),
                            strokeWidth = size.width,
                            pathEffect = pathEffect
                        )
                    } else {
                        drawLine(
                            color = lineColor,
                            start = Offset(size.width / 2, 0f),
                            end = Offset(size.width / 2, size.height),
                            strokeWidth = size.width
                        )
                    }
                }
            }
        }

        Spacer(modifier = Modifier.width(12.dp))

        // Content Column
        Column(
            modifier = Modifier
                .weight(1f)
                .padding(bottom = if (isLast) 0.dp else 24.dp)
        ) {
            Text(
                text = node.dateText,
                style = MaterialTheme.typography.bodyMedium,
                color = Color.Black,
                fontWeight = FontWeight.SemiBold,
                modifier = Modifier.padding(bottom = 8.dp)
            )

            Card(
                shape = RoundedCornerShape(12.dp),
                colors = CardDefaults.cardColors(containerColor = Color.White),
                elevation = CardDefaults.cardElevation(defaultElevation = 0.dp),
                modifier = Modifier
                    .fillMaxWidth()
                    .clickable { expanded = !expanded }
            ) {
                Column(
                    modifier = Modifier.padding(16.dp)
                ) {
                    Row(
                        modifier = Modifier.fillMaxWidth(),
                        horizontalArrangement = Arrangement.SpaceBetween,
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        Text(
                            text = node.name,
                            style = MaterialTheme.typography.titleMedium,
                            fontWeight = FontWeight.Bold,
                            color = Color.Black
                        )
                        
                        Row(verticalAlignment = Alignment.CenterVertically) {
                            // Status Badge
                            Surface(
                                shape = RoundedCornerShape(8.dp),
                                color = node.statusContainerColor,
                                modifier = Modifier.padding(end = 8.dp)
                            ) {
                                Text(
                                    text = node.statusText,
                                    color = node.statusContentColor,
                                    fontSize = 12.sp,
                                    fontWeight = FontWeight.Medium,
                                    modifier = Modifier.padding(horizontal = 12.dp, vertical = 6.dp)
                                )
                            }
                            
                            Icon(
                                imageVector = Icons.Default.ExpandMore,
                                contentDescription = "Expand",
                                modifier = Modifier.rotate(rotationState),
                                tint = Color.Black
                            )
                        }
                    }

                    AnimatedVisibility(visible = expanded) {
                        Column {
                            Spacer(modifier = Modifier.height(16.dp))
                            Row(
                                modifier = Modifier.fillMaxWidth(),
                                horizontalArrangement = Arrangement.SpaceBetween
                            ) {
                                Text(
                                    text = node.roleLabel,
                                    style = MaterialTheme.typography.bodyMedium,
                                    color = Color.Gray
                                )
                                Text(
                                    text = node.role,
                                    style = MaterialTheme.typography.bodyMedium,
                                    fontWeight = FontWeight.Bold,
                                    color = Color.Black
                                )
                            }
                            if (node.remark != "") {
                                Spacer(modifier = Modifier.height(4.dp))
                                Row(
                                    modifier = Modifier.fillMaxWidth(),
                                    horizontalArrangement = Arrangement.SpaceBetween
                                ) {
                                    Text(
                                        text = node.remarkLabel,
                                        style = MaterialTheme.typography.bodyMedium,
                                        color = Color.Gray
                                    )
                                    Text(
                                        text = node.remark,
                                        style = MaterialTheme.typography.bodyMedium,
                                        fontWeight = FontWeight.Bold,
                                        color = Color.Black
                                    )
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

@androidx.compose.ui.tooling.preview.Preview(showBackground = true, backgroundColor = 0xFFF2F2F2)
@Composable
fun AppApprovalLinePreview() {
    MaterialTheme {
        val approvalNodes = listOf(
            ApprovalNodeData(
                dateText = "25 Jun, 2026 14:41:13",
                name = "Phanna Pang",
                role = "Credit Officer",
                statusText = "Requested",
                statusContainerColor = Color(0xFF3B82F6), // Blue
                isCompleted = true,
                remark = "No remark"
            ),
            ApprovalNodeData(
                dateText = "28 Jun, 2026 (Optional)",
                name = "Bun Mit",
                role = "Manager",
                statusText = "Skipped",
                statusContainerColor = Color(0xFF9CA3AF), // Gray
                isCompleted = false,
                remark = ""
            ),
            ApprovalNodeData(
                dateText = "28 Jun, 2026 (Optional)",
                name = "Lim Ban",
                role = "Senior Manager",
                statusText = "Skipped",
                statusContainerColor = Color(0xFF9CA3AF), // Gray
                isCompleted = false,
                remark = ""
            ),
            ApprovalNodeData(
                dateText = "28 Jun, 2026 (Optional)",
                name = "Sopheak Thy",
                role = "Director",
                statusText = "Approved",
                statusContainerColor = Color(0xFF10B981), // Green
                isCompleted = false,
                remark = ""
            )
        )
        AppApprovalLine(nodes = approvalNodes)
    }
}
