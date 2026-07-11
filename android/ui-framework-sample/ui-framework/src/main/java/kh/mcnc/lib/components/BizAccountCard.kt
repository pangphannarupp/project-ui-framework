package kh.mcnc.lib.components

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ChevronRight
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

@Composable
fun BizAccountCard(
    count: Int,
    balance: Double,
    currency: String = "KHR",
    type: BizAccountCardType = BizAccountCardType.Deposit,
    onClick: () -> Unit = {}
) {
    var isHidden by remember { mutableStateOf(false) }

    val gradientColors = when (type) {
        BizAccountCardType.Deposit -> listOf(Color(0xFF1A75FF), Color(0xFF4DA6FF))
        BizAccountCardType.Loan -> listOf(Color(0xFFFF3366), Color(0xFFFF809F))
    }

    Box(
        modifier = Modifier
            .fillMaxWidth()
            .shadow(8.dp, RoundedCornerShape(20.dp))
            .clip(RoundedCornerShape(20.dp))
            .background(Brush.linearGradient(gradientColors))
            .clickable(onClick = onClick)
            .padding(start = 20.dp, end = 20.dp, top = 16.dp, bottom = 24.dp)
    ) {
        // Watermark
        Text(
            text = "$",
            color = Color.White.copy(alpha = 0.15f),
            fontSize = 200.sp,
            fontWeight = FontWeight.Black,
            modifier = Modifier.offset(x = (-20).dp, y = (-20).dp)
        )

        Column {
            // Header
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Row(verticalAlignment = Alignment.CenterVertically) {
                    Box(
                        modifier = Modifier
                            .size(20.dp)
                            .clip(RoundedCornerShape(10.dp))
                            .background(Color.White),
                        contentAlignment = Alignment.Center
                    ) {
                        Text(
                            text = count.toString(),
                            color = gradientColors[0],
                            fontSize = 12.sp,
                            fontWeight = FontWeight.Bold
                        )
                    }
                    Spacer(modifier = Modifier.width(8.dp))
                    Text(
                        text = "Account(s)",
                        color = Color.White,
                        fontSize = 13.sp,
                        fontWeight = FontWeight.SemiBold
                    )
                }

                Icon(
                    imageVector = Icons.Default.ChevronRight,
                    contentDescription = null,
                    tint = Color.White.copy(alpha = 0.8f),
                    modifier = Modifier.size(20.dp)
                )
            }

            Spacer(modifier = Modifier.height(24.dp))

            // Body
            Column(
                modifier = Modifier.fillMaxWidth(),
                horizontalAlignment = Alignment.End
            ) {
                Text(
                    text = "Total Balance",
                    color = Color.White.copy(alpha = 0.9f),
                    fontSize = 13.sp,
                    modifier = Modifier.padding(bottom = 4.dp)
                )

                Row(
                    verticalAlignment = Alignment.CenterVertically,
                    horizontalArrangement = Arrangement.End
                ) {
                    val formattedBalance = if (isHidden) {
                        "***,***.**"
                    } else {
                        String.format("%,.2f", balance)
                    }

                    Text(
                        text = currency,
                        color = Color.White,
                        fontSize = 20.sp,
                        fontWeight = FontWeight.Bold
                    )
                    Spacer(modifier = Modifier.width(6.dp))
                    Text(
                        text = formattedBalance,
                        color = Color.White,
                        fontSize = 28.sp,
                        fontWeight = FontWeight.Bold,
                        letterSpacing = (-0.5).sp
                    )
                }
            }
        }
    }
}

enum class BizAccountCardType {
    Deposit,
    Loan
}
