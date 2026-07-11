package kh.mcnc.lib.ui.components.branch

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp

enum class SortOption {
    BY_DISTANCE,
    BY_NAME
}

@Composable
fun AppSortDialog(
    selectedOption: SortOption,
    onOptionSelected: (SortOption) -> Unit,
    modifier: Modifier = Modifier
) {
    Column(
        modifier = modifier
            .fillMaxWidth()
            .background(Color.White)
            .padding(24.dp)
    ) {
        Text(
            text = "Sort",
            style = MaterialTheme.typography.titleLarge,
            fontWeight = FontWeight.Bold,
            color = Color.Black
        )
        
        Spacer(modifier = Modifier.height(4.dp))
        
        Text(
            text = "More convenient to locate the branch you wish to visit.",
            style = MaterialTheme.typography.bodyMedium,
            color = Color.Gray
        )
        
        Spacer(modifier = Modifier.height(24.dp))
        
        // By Distance
        SortOptionRow(
            text = "By Distance",
            isSelected = selectedOption == SortOption.BY_DISTANCE,
            onClick = { onOptionSelected(SortOption.BY_DISTANCE) }
        )
        
        Spacer(modifier = Modifier.height(16.dp))
        
        // By Name
        SortOptionRow(
            text = "By Name",
            isSelected = selectedOption == SortOption.BY_NAME,
            onClick = { onOptionSelected(SortOption.BY_NAME) }
        )
        
        Spacer(modifier = Modifier.height(24.dp))
    }
}

@Composable
private fun SortOptionRow(
    text: String,
    isSelected: Boolean,
    onClick: () -> Unit
) {
    val borderColor = if (isSelected) Color(0xFF1E3A8A) else Color(0xFFE5E7EB)
    val textColor = if (isSelected) Color.Black else Color.Gray

    Row(
        modifier = Modifier
            .fillMaxWidth()
            .clip(RoundedCornerShape(12.dp))
            .border(1.dp, borderColor, RoundedCornerShape(12.dp))
            .clickable { onClick() }
            .padding(16.dp),
        horizontalArrangement = Arrangement.SpaceBetween,
        verticalAlignment = Alignment.CenterVertically
    ) {
        Text(
            text = text,
            style = MaterialTheme.typography.bodyLarge,
            fontWeight = if (isSelected) FontWeight.SemiBold else FontWeight.Normal,
            color = textColor
        )
        
        // Custom Radio Button
        Box(
            modifier = Modifier
                .size(24.dp)
                .clip(CircleShape)
                .border(2.dp, if (isSelected) Color(0xFF1E3A8A) else Color(0xFFE5E7EB), CircleShape),
            contentAlignment = Alignment.Center
        ) {
            if (isSelected) {
                Box(
                    modifier = Modifier
                        .size(12.dp)
                        .clip(CircleShape)
                        .background(Color(0xFF1E3A8A))
                )
            }
        }
    }
}

@androidx.compose.ui.tooling.preview.Preview(showBackground = true)
@Composable
fun AppSortDialogPreview() {
    MaterialTheme {
        AppSortDialog(
            selectedOption = SortOption.BY_DISTANCE,
            onOptionSelected = {}
        )
    }
}
