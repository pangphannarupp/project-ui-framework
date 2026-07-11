package kh.mcnc.lib.components

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import java.text.NumberFormat
import java.util.Locale

@Composable
fun BizAccountSavingCard(
    accountName: String,
    accountNumber: String,
    balance: Double,
    currency: String = "USD",
    type: String = "Savings",
    selected: Boolean = false,
    onSelect: () -> Unit = {}
) {
    val formattedBalance = NumberFormat.getNumberInstance(Locale.US).apply {
        minimumFractionDigits = if (currency == "USD") 2 else 0
        maximumFractionDigits = if (currency == "USD") 2 else 0
    }.format(balance)

    val currencySymbol = if (currency == "USD") "$" else "៛"
    val watermarkColor = if (currency == "USD") Color(0xFFEEF3FB) else Color(0xFFFFF0F5)
    val primaryColor = Color(0xFF1A2A5E)

    val borderColor = if (selected) primaryColor else Color(0xFFF0F0F0)
    val borderWidth = if (selected) 1.5.dp else 1.dp
    val backgroundColor = if (selected) Color.White else Color(0xFFFCFCFC)

    Box(
        modifier = Modifier
            .fillMaxWidth()
            .padding(bottom = 12.dp)
            .border(borderWidth, borderColor, RoundedCornerShape(12.dp))
            .clip(RoundedCornerShape(12.dp))
            .background(backgroundColor)
            .clickable(onClick = onSelect)
    ) {
        // Watermark
        Text(
            text = currencySymbol,
            color = watermarkColor,
            fontSize = 140.sp,
            fontWeight = FontWeight.ExtraBold,
            modifier = Modifier
                .align(Alignment.CenterEnd)
                .offset(x = (-20).dp)
        )

        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(16.dp),
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            Column(modifier = Modifier.weight(1f)) {
                Box(
                    modifier = Modifier
                        .border(1.dp, Color(0xFFD0D0D0), RoundedCornerShape(12.dp))
                        .padding(horizontal = 8.dp, vertical = 2.dp)
                ) {
                    Text(
                        text = type,
                        color = Color(0xFF666666),
                        fontSize = 10.sp
                    )
                }
                
                Spacer(modifier = Modifier.height(8.dp))
                
                Text(
                    text = accountName,
                    color = primaryColor,
                    fontSize = 13.sp,
                    fontWeight = FontWeight.Bold,
                    modifier = Modifier.padding(bottom = 2.dp)
                )
                
                Text(
                    text = accountNumber,
                    color = Color(0xFF777777),
                    fontSize = 11.sp
                )
                
                Spacer(modifier = Modifier.height(8.dp))
                
                Text(
                    text = "Total Balance",
                    color = Color(0xFF777777),
                    fontSize = 11.sp,
                    modifier = Modifier.padding(bottom = 2.dp)
                )
                
                Row(verticalAlignment = Alignment.CenterVertically) {
                    Text(
                        text = currencySymbol,
                        color = primaryColor,
                        fontSize = 16.sp,
                        fontWeight = FontWeight.ExtraBold,
                        modifier = Modifier.padding(end = 4.dp)
                    )
                    Text(
                        text = formattedBalance,
                        color = primaryColor,
                        fontSize = 16.sp,
                        fontWeight = FontWeight.ExtraBold
                    )
                }
            }
            
            // Radio Button
            Box(
                modifier = Modifier
                    .padding(start = 16.dp)
                    .size(22.dp)
                    .border(
                        width = if (selected) 3.dp else 2.dp,
                        color = if (selected) primaryColor else Color(0xFFE0E0E0),
                        shape = CircleShape
                    )
                    .background(Color.White, CircleShape),
                contentAlignment = Alignment.Center
            ) {
                // Mockup shows just a thick border when selected
            }
        }
    }
}
