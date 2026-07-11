package kh.mcnc.lib.components

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

@Composable
fun BizActionCard(
    title: String,
    subtitle: String = "",
    badgeCount: String? = null,
    badgeColor: String = "pink",
    onClick: () -> Unit = {},
    icon: @Composable () -> Unit = {}
) {
    val (bgColor, fgColor) = when (badgeColor) {
        "pink" -> Color(0xFFFFE6EB) to Color(0xFFFF4D6D)
        "orange" -> Color(0xFFFFF3E0) to Color(0xFFFF9800)
        "teal" -> Color(0xFFE0F2F1) to Color(0xFF009688)
        "blue" -> Color(0xFFE6F0FF) to Color(0xFF0066CC)
        else -> Color(0xFFFFE6EB) to Color(0xFFFF4D6D)
    }

    Box(
        modifier = Modifier
            .fillMaxWidth()
            .shadow(elevation = 2.dp, shape = RoundedCornerShape(16.dp), spotColor = Color(0x08000000))
            .clip(RoundedCornerShape(16.dp))
            .background(Color.White)
            .clickable(onClick = onClick)
            .padding(horizontal = 12.dp, vertical = 16.dp)
    ) {
        Column(modifier = Modifier.fillMaxWidth()) {
            Box(modifier = Modifier.padding(bottom = 12.dp)) {
                if (badgeCount != null) {
                    Box(
                        modifier = Modifier
                            .size(32.dp)
                            .background(bgColor, CircleShape),
                        contentAlignment = Alignment.Center
                    ) {
                        Text(
                            text = badgeCount,
                            color = fgColor,
                            fontSize = 16.sp,
                            fontWeight = FontWeight.Bold
                        )
                    }
                } else {
                    Box(
                        modifier = Modifier
                            .size(40.dp)
                            .background(if (badgeColor == "blue" || badgeColor == "pink") Color.Transparent else bgColor, CircleShape),
                        contentAlignment = Alignment.Center
                    ) {
                        icon()
                    }
                }
            }

            Text(
                text = title,
                fontSize = 14.sp,
                fontWeight = FontWeight.Bold,
                color = Color(0xFF1A2A5E),
                lineHeight = 16.sp
            )

            if (subtitle.isNotEmpty()) {
                Spacer(modifier = Modifier.height(2.dp))
                Text(
                    text = subtitle,
                    fontSize = 12.sp,
                    color = Color(0xFF666666),
                    lineHeight = 14.sp
                )
            }
        }
    }
}
