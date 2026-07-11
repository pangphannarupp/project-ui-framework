package kh.mcnc.lib.components

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.size
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Star
import androidx.compose.material.icons.outlined.Star
import androidx.compose.material3.Icon
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp

@Composable
fun BizRating(
    rating: Int,
    onRatingChange: (Int) -> Unit,
    modifier: Modifier = Modifier,
    max: Int = 5,
    readonly: Boolean = false,
    activeColor: Color = Color(0xFFFFC107),
    inactiveColor: Color = Color(0xFFE0E0E0)
) {
    Row(modifier = modifier) {
        for (i in 1..max) {
            val isActive = i <= rating
            Icon(
                imageVector = if (isActive) Icons.Filled.Star else Icons.Outlined.Star,
                contentDescription = "Star $i",
                tint = if (isActive) activeColor else inactiveColor,
                modifier = Modifier
                    .size(24.dp)
                    .then(
                        if (!readonly) {
                            Modifier.clickable { onRatingChange(i) }
                        } else {
                            Modifier
                        }
                    )
            )
        }
    }
}
