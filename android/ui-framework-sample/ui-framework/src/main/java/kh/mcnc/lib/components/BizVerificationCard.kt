package kh.mcnc.lib.components

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

@Composable
fun BizVerificationCard(
    title: String = "",
    description: String = "",
    icon: @Composable () -> Unit = {}
) {
    // We simulate the left position of the icon using a Row with a specific negative offset or just padding.
    // The CSS uses absolute position left: -41px.
    // In Compose, since it's a list context typically, we can use a Row.
    Row(
        modifier = Modifier.fillMaxWidth()
    ) {
        Box(
            modifier = Modifier
                .offset(x = (-41).dp) // Adjust this offset according to the parent container padding if necessary
                .size(24.dp)
                .background(Color(0xFFF0F5FF), CircleShape)
                .border(4.dp, Color.White, CircleShape),
            contentAlignment = Alignment.Center
        ) {
            icon()
        }

        Column(
            modifier = Modifier
                .offset(x = (-41 + 12).dp) // We adjust to keep the gap of 12px
                .weight(1f)
        ) {
            if (title.isNotEmpty()) {
                Text(
                    text = title,
                    fontSize = 14.sp,
                    fontWeight = FontWeight.SemiBold,
                    color = Color(0xFF1A2A5E),
                    lineHeight = 18.sp,
                    modifier = Modifier.padding(bottom = 4.dp)
                )
            }

            if (description.isNotEmpty()) {
                Text(
                    text = description,
                    fontSize = 13.sp,
                    color = Color(0xFF555555),
                    lineHeight = 18.sp
                )
            }
        }
    }
}
