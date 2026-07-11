package kh.mcnc.lib.ui.components

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp

data class HeatMapData(val dateLabel: String, val value: Int)

@Composable
fun AppHeatMap(
    data: List<HeatMapData>,
    modifier: Modifier = Modifier,
    columns: Int = 12,
    emptyColor: Color = Color(0xFFEEEEEE),
    baseColor: Color = Color(0xFF4CAF50)
) {
    val maxValue = data.maxOfOrNull { it.value }?.coerceAtLeast(1) ?: 1
    
    var selectedItem by remember { mutableStateOf<HeatMapData?>(null) }

    Column(modifier = modifier.fillMaxWidth(), horizontalAlignment = Alignment.CenterHorizontally) {
        LazyVerticalGrid(
            columns = GridCells.Fixed(columns),
            horizontalArrangement = Arrangement.spacedBy(4.dp),
            verticalArrangement = Arrangement.spacedBy(4.dp),
            modifier = Modifier.padding(16.dp).heightIn(max = 400.dp)
        ) {
            items(data.size) { index ->
                val item = data[index]
                val intensity = item.value.toFloat() / maxValue
                val cellColor = if (item.value == 0) emptyColor else baseColor.copy(alpha = (intensity * 0.8f + 0.2f).coerceIn(0.2f, 1f))
                
                Box(
                    modifier = Modifier
                        .aspectRatio(1f)
                        .clip(RoundedCornerShape(4.dp))
                        .background(cellColor)
                        .clickable { selectedItem = item }
                )
            }
        }
        
        Spacer(modifier = Modifier.height(16.dp))
        
        if (selectedItem != null) {
            Text(
                text = "${selectedItem!!.dateLabel}: ${selectedItem!!.value} activities",
                style = MaterialTheme.typography.bodyLarge,
                color = MaterialTheme.colorScheme.onSurface
            )
        } else {
            Text(
                text = "Tap a cell for details",
                style = MaterialTheme.typography.bodyMedium,
                color = MaterialTheme.colorScheme.onSurfaceVariant
            )
        }
    }
}
