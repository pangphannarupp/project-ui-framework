package kh.mcnc.lib.ui.components

import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.background
import androidx.compose.foundation.basicMarquee
import androidx.compose.foundation.layout.*
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp

data class TickerItem(
    val label: String,
    val value: String,
    val isPositive: Boolean
)

@OptIn(ExperimentalFoundationApi::class)
@Composable
fun AppStockTicker(
    items: List<TickerItem>,
    modifier: Modifier = Modifier,
    backgroundColor: Color = MaterialTheme.colorScheme.surfaceVariant
) {
    Box(
        modifier = modifier
            .fillMaxWidth()
            .height(48.dp)
            .background(backgroundColor),
        contentAlignment = Alignment.CenterStart
    ) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .basicMarquee(
                    iterations = Int.MAX_VALUE,
                    velocity = 40.dp // scrolling speed
                )
                .padding(horizontal = 16.dp),
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.spacedBy(32.dp)
        ) {
            items.forEach { item ->
                Row(verticalAlignment = Alignment.CenterVertically) {
                    Text(
                        text = "${item.label}: ",
                        style = MaterialTheme.typography.labelLarge,
                        color = MaterialTheme.colorScheme.onSurfaceVariant
                    )
                    Text(
                        text = item.value,
                        style = MaterialTheme.typography.labelLarge,
                        fontWeight = FontWeight.Bold,
                        color = if (item.isPositive) Color(0xFF388E3C) else Color(0xFFD32F2F)
                    )
                }
            }
        }
    }
}
