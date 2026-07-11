package kh.mcnc.lib.ui.components

import androidx.compose.foundation.background
import androidx.compose.foundation.horizontalScroll
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.itemsIndexed
import androidx.compose.foundation.rememberScrollState
import androidx.compose.material3.Divider
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp

data class DataColumn<T>(
    val header: String,
    val width: Dp = 120.dp,
    val cellContent: @Composable (T) -> Unit
)

@Composable
fun <T> AppDataTable(
    items: List<T>,
    columns: List<DataColumn<T>>,
    modifier: Modifier = Modifier,
    headerBackgroundColor: Color = MaterialTheme.colorScheme.surfaceVariant,
    rowBackgroundColor: Color = MaterialTheme.colorScheme.surface,
    alternateRowBackgroundColor: Color = MaterialTheme.colorScheme.surfaceVariant.copy(alpha = 0.3f)
) {
    val horizontalScrollState = rememberScrollState()

    Column(
        modifier = modifier
            .fillMaxWidth()
            .horizontalScroll(horizontalScrollState)
    ) {
        // Header Row
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .background(headerBackgroundColor)
                .padding(vertical = 12.dp)
        ) {
            columns.forEach { column ->
                Box(
                    modifier = Modifier
                        .width(column.width)
                        .padding(horizontal = 16.dp),
                    contentAlignment = Alignment.CenterStart
                ) {
                    Text(
                        text = column.header,
                        style = MaterialTheme.typography.labelLarge,
                        fontWeight = FontWeight.Bold,
                        color = MaterialTheme.colorScheme.onSurfaceVariant
                    )
                }
            }
        }

        // Data Rows
        LazyColumn(
            modifier = Modifier.fillMaxWidth()
        ) {
            itemsIndexed(items) { index, item ->
                val bgColor = if (index % 2 == 0) rowBackgroundColor else alternateRowBackgroundColor
                
                Column {
                    Row(
                        modifier = Modifier
                            .fillMaxWidth()
                            .background(bgColor)
                            .padding(vertical = 16.dp),
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        columns.forEach { column ->
                            Box(
                                modifier = Modifier
                                    .width(column.width)
                                    .padding(horizontal = 16.dp),
                                contentAlignment = Alignment.CenterStart
                            ) {
                                column.cellContent(item)
                            }
                        }
                    }
                    Divider(color = Color.LightGray.copy(alpha = 0.5f), thickness = 1.dp)
                }
            }
            
            if (items.isEmpty()) {
                item {
                    Box(
                        modifier = Modifier
                            .fillMaxWidth()
                            .padding(32.dp),
                        contentAlignment = Alignment.Center
                    ) {
                        Text(
                            text = "No data available",
                            color = MaterialTheme.colorScheme.onSurfaceVariant
                        )
                    }
                }
            }
        }
    }
}
