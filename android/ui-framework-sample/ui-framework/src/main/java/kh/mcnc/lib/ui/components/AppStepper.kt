package kh.mcnc.lib.ui.components

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Check
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp

@Composable
fun AppStepper(
    steps: List<String>,
    currentStepIndex: Int,
    modifier: Modifier = Modifier,
    onStepClicked: ((Int) -> Unit)? = null
) {
    Row(
        modifier = modifier
            .fillMaxWidth()
            .padding(vertical = 16.dp),
        horizontalArrangement = Arrangement.SpaceBetween,
        verticalAlignment = Alignment.CenterVertically
    ) {
        steps.forEachIndexed { index, title ->
            val isCompleted = index < currentStepIndex
            val isCurrent = index == currentStepIndex
            val isActive = isCompleted || isCurrent

            Column(
                horizontalAlignment = Alignment.CenterHorizontally,
                modifier = Modifier
                    .weight(1f)
                    .clickable(enabled = onStepClicked != null && index <= currentStepIndex) {
                        onStepClicked?.invoke(index)
                    }
            ) {
                // Step Circle
                Box(
                    modifier = Modifier
                        .size(32.dp)
                        .clip(CircleShape)
                        .background(
                            if (isActive) MaterialTheme.colorScheme.primary else Color.LightGray
                        ),
                    contentAlignment = Alignment.Center
                ) {
                    if (isCompleted) {
                        Icon(
                            imageVector = Icons.Default.Check,
                            contentDescription = "Completed",
                            tint = Color.White,
                            modifier = Modifier.size(20.dp)
                        )
                    } else {
                        Text(
                            text = (index + 1).toString(),
                            color = if (isActive) Color.White else Color.Gray,
                            fontWeight = FontWeight.Bold
                        )
                    }
                }

                Spacer(modifier = Modifier.height(8.dp))

                // Step Title
                Text(
                    text = title,
                    style = MaterialTheme.typography.bodySmall,
                    color = if (isActive) MaterialTheme.colorScheme.onSurface else Color.Gray,
                    fontWeight = if (isCurrent) FontWeight.Bold else FontWeight.Normal,
                    textAlign = TextAlign.Center
                )
            }

            // Line separator between steps
            if (index < steps.size - 1) {
                Box(
                    modifier = Modifier
                        .weight(0.5f)
                        .height(2.dp)
                        .background(
                            if (isCompleted) MaterialTheme.colorScheme.primary else Color.LightGray
                        )
                        .align(Alignment.Top)
                        .offset(y = 15.dp) // Align with the middle of the circles (32.dp / 2 - 1.dp)
                )
            }
        }
    }
}
