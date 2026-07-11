package kh.mcnc.lib.components

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Info
import androidx.compose.material.icons.filled.Warning
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp

@Composable
fun BizInfoCard(
    text: String,
    modifier: Modifier = Modifier,
    type: BizInfoCardType = BizInfoCardType.Warning
) {
    Row(
        modifier = modifier
            .fillMaxWidth()
            .background(Color(0xFFF8F9FA), RoundedCornerShape(12.dp))
            .border(1.dp, Color(0xFFF1F3F5), RoundedCornerShape(12.dp))
            .padding(16.dp),
        verticalAlignment = Alignment.Top
    ) {
        val icon = if (type == BizInfoCardType.Warning) Icons.Default.Warning else Icons.Default.Info
        val iconTint = Color(0xFF1A2A5E) // --biz-primary-variant

        Icon(
            imageVector = icon,
            contentDescription = null,
            tint = iconTint,
            modifier = Modifier.size(20.dp)
        )
        
        Spacer(modifier = Modifier.width(12.dp))
        
        Text(
            text = text,
            style = MaterialTheme.typography.bodyMedium,
            color = Color(0xFF333333),
            modifier = Modifier.weight(1f)
        )
    }
}

enum class BizInfoCardType {
    Warning,
    Info
}
