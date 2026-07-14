package kh.mcnc.lib.components

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

@Composable
fun BizUserCard(
    name: String,
    phone: String,
    status: String = "Active",
    isMaster: Boolean = false,
    hasSmartBiz: Boolean = false,
    hasSmartPay: Boolean = false,
    onMoreClick: () -> Unit = {}
) {
    val initials = if (name.contains(" ")) {
        val parts = name.split(" ")
        "${parts[0].firstOrNull() ?: ""}${parts.getOrNull(1)?.firstOrNull() ?: ""}".uppercase()
    } else {
        name.take(2).uppercase()
    }

    Row(
        modifier = Modifier
            .fillMaxWidth()
            .background(Color.White, RoundedCornerShape(16.dp))
            .border(1.dp, Color(0xFFEEF1F6), RoundedCornerShape(16.dp))
            .padding(16.dp),
        verticalAlignment = Alignment.Top
    ) {
        // Avatar
        Box(
            modifier = Modifier
                .size(44.dp)
                .background(Color(0xFFE6F0FF), CircleShape),
            contentAlignment = Alignment.Center
        ) {
            Text(
                text = initials,
                color = Color(0xFF1A2A5E),
                fontSize = 15.sp,
                fontWeight = FontWeight.Bold
            )
        }

        Spacer(modifier = Modifier.width(12.dp))

        // Info
        Column(modifier = Modifier.weight(1f)) {
            Row(verticalAlignment = Alignment.CenterVertically) {
                Text(
                    text = name,
                    fontSize = 15.sp,
                    fontWeight = FontWeight.Bold,
                    color = Color(0xFF111111),
                    maxLines = 1,
                    overflow = TextOverflow.Ellipsis
                )
                if (isMaster) {
                    Spacer(modifier = Modifier.width(6.dp))
                    Text("✓", color = Color(0xFF3B63CC), fontSize = 14.sp)
                }
            }
            
            Spacer(modifier = Modifier.height(4.dp))
            
            Row(verticalAlignment = Alignment.CenterVertically) {
                Text("📞", fontSize = 12.sp) // placeholder phone icon
                Spacer(modifier = Modifier.width(6.dp))
                Text(
                    text = phone,
                    color = Color(0xFF666666),
                    fontSize = 13.sp
                )
            }
            
            Spacer(modifier = Modifier.height(8.dp))
            
            Row(
                horizontalArrangement = Arrangement.spacedBy(8.dp)
            ) {
                if (hasSmartBiz) {
                    Row(
                        modifier = Modifier
                            .background(Color(0xFF3B63CC), RoundedCornerShape(6.dp))
                            .padding(horizontal = 8.dp, vertical = 4.dp),
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        Text("smartBiz", color = Color.White, fontSize = 11.sp, fontWeight = FontWeight.SemiBold)
                    }
                }
                if (hasSmartPay) {
                    Row(
                        modifier = Modifier
                            .background(Color(0xFF00A4E4), RoundedCornerShape(6.dp))
                            .padding(horizontal = 8.dp, vertical = 4.dp),
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        Text("smartPay", color = Color.White, fontSize = 11.sp, fontWeight = FontWeight.SemiBold)
                    }
                }
            }
        }

        // Actions
        Column(
            horizontalAlignment = Alignment.End,
            modifier = Modifier.height(IntrinsicSize.Min)
        ) {
            val statusBgColor = when (status.lowercase()) {
                "active" -> Color(0xFFF0F5FF)
                "inactive" -> Color(0xFFF5F5F5)
                "pending" -> Color(0xFFFFF8E5)
                "locked" -> Color(0xFFFFEBEB)
                else -> Color(0xFFF5F5F5)
            }
            val statusTextColor = when (status.lowercase()) {
                "active" -> Color(0xFF3B63CC)
                "inactive" -> Color(0xFF888888)
                "pending" -> Color(0xFFE59F00)
                "locked" -> Color(0xFFFF3B30)
                else -> Color(0xFF888888)
            }

            Box(
                modifier = Modifier
                    .background(statusBgColor, RoundedCornerShape(12.dp))
                    .padding(horizontal = 10.dp, vertical = 4.dp)
            ) {
                Text(
                    text = status,
                    color = statusTextColor,
                    fontSize = 12.sp,
                    fontWeight = FontWeight.SemiBold
                )
            }
            
            Spacer(modifier = Modifier.height(24.dp))
            
            // More button
            Text("•••", color = Color(0xFF888888)) // Placeholder
        }
    }
}
