package kh.mcnc.lib.ui.components.branch

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.AccountBalance
import androidx.compose.material.icons.filled.Call
import androidx.compose.material.icons.filled.Navigation
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

data class BranchData(
    val id: String,
    val name: String,
    val distance: String,
    val businessTime: String,
    val facilities: List<String>,
    val latitude: Double = 11.5564,
    val longitude: Double = 104.9282
)

@Composable
fun AppBranchCard(
    branch: BranchData,
    onCallClick: () -> Unit = {},
    onDirectionClick: () -> Unit = {},
    modifier: Modifier = Modifier
) {
    Card(
        shape = RoundedCornerShape(16.dp),
        colors = CardDefaults.cardColors(containerColor = Color.White),
        elevation = CardDefaults.cardElevation(defaultElevation = 0.dp),
        modifier = modifier
            .fillMaxWidth()
            .border(1.dp, Color(0xFFE5E7EB), RoundedCornerShape(16.dp))
    ) {
        Column(
            modifier = Modifier.padding(16.dp)
        ) {
            Row(
                modifier = Modifier.fillMaxWidth(),
                verticalAlignment = Alignment.Top
            ) {
                // Bank Icon
                Box(
                    modifier = Modifier
                        .size(40.dp)
                        .clip(CircleShape)
                        .background(Color(0xFFF3F4F6)),
                    contentAlignment = Alignment.Center
                ) {
                    Icon(
                        imageVector = Icons.Default.AccountBalance,
                        contentDescription = "Bank",
                        tint = Color(0xFF1E3A8A), // Dark blue
                        modifier = Modifier.size(20.dp)
                    )
                }

                Spacer(modifier = Modifier.width(12.dp))

                // Title and Time
                Column(modifier = Modifier.weight(1f)) {
                    Row(
                        modifier = Modifier.fillMaxWidth(),
                        horizontalArrangement = Arrangement.SpaceBetween,
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        Text(
                            text = branch.name,
                            style = MaterialTheme.typography.titleMedium,
                            fontWeight = FontWeight.Bold,
                            color = Color(0xFF111827)
                        )
                        
                        // Distance Badge
                        Surface(
                            shape = RoundedCornerShape(16.dp),
                            color = Color(0xFFF3F4F6),
                        ) {
                            Text(
                                text = branch.distance,
                                style = MaterialTheme.typography.labelSmall,
                                color = Color.DarkGray,
                                modifier = Modifier.padding(horizontal = 8.dp, vertical = 4.dp)
                            )
                        }
                    }

                    Text(
                        text = "Business Time: ${branch.businessTime}",
                        style = MaterialTheme.typography.bodySmall,
                        color = Color.Gray,
                        modifier = Modifier.padding(top = 2.dp)
                    )

                    Spacer(modifier = Modifier.height(12.dp))

                    // Facilities
                    Row(
                        horizontalArrangement = Arrangement.spacedBy(8.dp),
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        branch.facilities.forEach { facility ->
                            Row(verticalAlignment = Alignment.CenterVertically) {
                                // A small dot for facility separator/icon if needed, or emoji
                                Box(
                                    modifier = Modifier
                                        .size(4.dp)
                                        .clip(CircleShape)
                                        .background(Color.Gray)
                                )
                                Spacer(modifier = Modifier.width(4.dp))
                                Text(
                                    text = facility,
                                    style = MaterialTheme.typography.labelSmall,
                                    color = Color.DarkGray
                                )
                            }
                        }
                    }
                }
            }

            Spacer(modifier = Modifier.height(16.dp))

            // Buttons
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.spacedBy(12.dp)
            ) {
                // Call Now
                OutlinedButton(
                    onClick = onCallClick,
                    modifier = Modifier.weight(1f),
                    shape = RoundedCornerShape(24.dp),
                    contentPadding = PaddingValues(vertical = 10.dp)
                ) {
                    Icon(
                        imageVector = Icons.Default.Call,
                        contentDescription = "Call",
                        modifier = Modifier.size(16.dp),
                        tint = Color.DarkGray
                    )
                    Spacer(modifier = Modifier.width(8.dp))
                    Text(text = "Call Now", color = Color.DarkGray, fontSize = 14.sp)
                }

                // Direction
                OutlinedButton(
                    onClick = onDirectionClick,
                    modifier = Modifier.weight(1f),
                    shape = RoundedCornerShape(24.dp),
                    contentPadding = PaddingValues(vertical = 10.dp)
                ) {
                    Icon(
                        imageVector = Icons.Default.Navigation,
                        contentDescription = "Direction",
                        modifier = Modifier.size(16.dp),
                        tint = Color.DarkGray
                    )
                    Spacer(modifier = Modifier.width(8.dp))
                    Text(text = "Direction", color = Color.DarkGray, fontSize = 14.sp)
                }
            }
        }
    }
}

@androidx.compose.ui.tooling.preview.Preview(showBackground = true)
@Composable
fun AppBranchCardPreview() {
    MaterialTheme {
        AppBranchCard(
            branch = BranchData(
                id = "1",
                name = "Main Branch",
                distance = "0.01 km",
                businessTime = "8am - 4pm",
                facilities = listOf("Coffee", "Korean", "Chinese")
            ),
            modifier = Modifier.padding(16.dp)
        )
    }
}
