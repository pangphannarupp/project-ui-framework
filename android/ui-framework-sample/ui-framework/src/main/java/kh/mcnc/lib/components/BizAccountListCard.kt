package kh.mcnc.lib.components

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.scale
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import java.text.NumberFormat
import java.util.Locale

@Composable
fun BizAccountListCard(
    accountName: String,
    accountNumber: String,
    balance: Double,
    currency: String = "USD",
    type: String = "Savings",
    isHidden: Boolean = false,
    onClick: () -> Unit = {},
    onActionClick: () -> Unit = {},
    onUpdateIsHidden: (Boolean) -> Unit = {}
) {
    val formattedBalance = if (isHidden) {
        "***,***.**"
    } else {
        NumberFormat.getNumberInstance(Locale.US).apply {
            minimumFractionDigits = 2
            maximumFractionDigits = 2
        }.format(balance)
    }

    val currencySymbol = if (currency == "USD") "$" else "៛"
    val watermarkColor = if (currency == "USD") Color(0xFFEEF3FB) else Color(0xFFFFF0F5)
    val primaryColor = Color(0xFF1A2A5E)

    Box(
        modifier = Modifier
            .fillMaxWidth()
            .padding(bottom = 12.dp)
            .border(1.dp, Color(0xFFF0F2F5), RoundedCornerShape(20.dp))
            .clip(RoundedCornerShape(20.dp))
            .background(Color.White)
            .clickable(onClick = onClick)
    ) {
        // Watermark
        Text(
            text = currencySymbol,
            color = watermarkColor,
            fontSize = 140.sp,
            fontWeight = FontWeight.ExtraBold,
            modifier = Modifier
                .align(Alignment.CenterStart)
                .offset(x = (-20).dp)
        )

        // Content
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(16.dp),
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            // Left Column
            Column(
                modifier = Modifier.weight(1f),
                verticalArrangement = Arrangement.spacedBy(6.dp)
            ) {
                Box(
                    modifier = Modifier
                        .border(1.dp, primaryColor, RoundedCornerShape(12.dp))
                        .padding(horizontal = 10.dp, vertical = 2.dp)
                ) {
                    Text(
                        text = type,
                        color = primaryColor,
                        fontSize = 11.sp,
                        fontWeight = FontWeight.SemiBold
                    )
                }
                
                Text(
                    text = accountNumber,
                    color = primaryColor,
                    fontSize = 12.sp,
                    fontWeight = FontWeight.Medium,
                    modifier = Modifier.padding(top = 4.dp)
                )
                
                Text(
                    text = accountName,
                    color = primaryColor,
                    fontSize = 11.sp
                )
            }

            // Right Column
            Column(
                horizontalAlignment = Alignment.End,
                verticalArrangement = Arrangement.SpaceBetween
            ) {
                Box(modifier = Modifier.height(24.dp)) {
                    IconButton(
                        onClick = onActionClick,
                        modifier = Modifier.size(24.dp)
                    ) {
                        // Using a simple text representation for the dots or a custom icon could go here
                        Text("⋮", color = Color(0xFF999999), fontSize = 20.sp, fontWeight = FontWeight.Bold)
                    }
                }

                Column(horizontalAlignment = Alignment.End) {
                    Text(
                        text = "Total Balance",
                        color = Color(0xFF777777),
                        fontSize = 11.sp,
                        modifier = Modifier.padding(bottom = 2.dp)
                    )
                    
                    Row(
                        verticalAlignment = Alignment.CenterVertically,
                        horizontalArrangement = Arrangement.spacedBy(4.dp)
                    ) {
                        IconButton(
                            onClick = { onUpdateIsHidden(!isHidden) },
                            modifier = Modifier.size(20.dp)
                        ) {
                            Text(if (isHidden) "👁" else "👁\uFE0F", fontSize = 12.sp) // Replace with proper icons
                        }
                        
                        Row(verticalAlignment = Alignment.Baseline) {
                            Text(
                                text = currencySymbol,
                                color = primaryColor,
                                fontSize = 14.sp,
                                fontWeight = FontWeight.Bold,
                                modifier = Modifier.padding(end = 2.dp)
                            )
                            Text(
                                text = formattedBalance,
                                color = primaryColor,
                                fontSize = 18.sp,
                                fontWeight = FontWeight.Bold
                            )
                        }
                    }
                }
            }
        }
    }
}
