package kh.mcnc.lib.ui.components.branch

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp

@OptIn(ExperimentalLayoutApi::class)
@Composable
fun AppFilterDialog(
    selectedFacilities: Set<String>,
    onFacilityClick: (String) -> Unit,
    modifier: Modifier = Modifier
) {
    val facilities = listOf(
        "Korean Desk",
        "Japanese Desk",
        "Chinese Desk",
        "SME Center",
        "Coffee"
    )

    Column(
        modifier = modifier
            .fillMaxWidth()
            .background(Color.White)
            .padding(24.dp)
    ) {
        Text(
            text = "Filter",
            style = MaterialTheme.typography.titleLarge,
            fontWeight = FontWeight.Bold,
            color = Color.Black
        )
        
        Spacer(modifier = Modifier.height(4.dp))
        
        Text(
            text = "Search branch you wish to visit faster.",
            style = MaterialTheme.typography.bodyMedium,
            color = Color.Gray
        )
        
        Spacer(modifier = Modifier.height(24.dp))
        
        Text(
            text = "Branch Facility",
            style = MaterialTheme.typography.titleMedium,
            fontWeight = FontWeight.Bold,
            color = Color.Black
        )
        
        Spacer(modifier = Modifier.height(16.dp))
        
        FlowRow(
            horizontalArrangement = Arrangement.spacedBy(8.dp),
            verticalArrangement = Arrangement.spacedBy(12.dp),
            modifier = Modifier.fillMaxWidth()
        ) {
            facilities.forEach { facility ->
                val isSelected = selectedFacilities.contains(facility)
                
                Box(
                    modifier = Modifier
                        .clip(RoundedCornerShape(24.dp))
                        .background(if (isSelected) Color(0xFF1E3A8A) else Color.White)
                        .border(
                            width = 1.dp,
                            color = if (isSelected) Color(0xFF1E3A8A) else Color(0xFFE5E7EB),
                            shape = RoundedCornerShape(24.dp)
                        )
                        .clickable { onFacilityClick(facility) }
                        .padding(horizontal = 16.dp, vertical = 8.dp)
                ) {
                    Text(
                        text = facility,
                        style = MaterialTheme.typography.bodyMedium,
                        fontWeight = if (isSelected) FontWeight.SemiBold else FontWeight.Normal,
                        color = if (isSelected) Color.White else Color.Black
                    )
                }
            }
        }
        
        Spacer(modifier = Modifier.height(24.dp))
    }
}

@androidx.compose.ui.tooling.preview.Preview(showBackground = true)
@Composable
fun AppFilterDialogPreview() {
    MaterialTheme {
        AppFilterDialog(
            selectedFacilities = setOf("Japanese Desk"),
            onFacilityClick = {}
        )
    }
}
