package kh.mcnc.lib.ui.components

import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Check
import androidx.compose.material.icons.filled.Close
import androidx.compose.material.icons.filled.RotateRight
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.geometry.Size
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.unit.dp

@Composable
fun AppImageCropper(
    modifier: Modifier = Modifier,
    onConfirm: () -> Unit = {},
    onCancel: () -> Unit = {}
) {
    Box(
        modifier = modifier
            .fillMaxWidth()
            .aspectRatio(1f)
            .background(Color.Black)
    ) {
        // Mock Image (gray box)
        Box(
            modifier = Modifier
                .fillMaxSize(0.8f)
                .align(Alignment.Center)
                .background(Color.DarkGray)
        ) {
            Text("MOCK IMAGE", modifier = Modifier.align(Alignment.Center), color = Color.Gray)
        }

        // Overlay Grid
        Canvas(modifier = Modifier.fillMaxSize()) {
            val cropWidth = size.width * 0.7f
            val cropHeight = size.height * 0.7f
            val offsetX = (size.width - cropWidth) / 2
            val offsetY = (size.height - cropHeight) / 2

            // Dimmed background
            drawRect(
                color = Color.Black.copy(alpha = 0.5f),
                size = size
            )
            // Punch out center (simulated by drawing stroke over it)
            // Draw Crop Border
            drawRect(
                color = Color.White,
                topLeft = Offset(offsetX, offsetY),
                size = Size(cropWidth, cropHeight),
                style = Stroke(width = 4f)
            )

            // Draw grid lines (Rule of thirds)
            val color = Color.White.copy(alpha = 0.5f)
            
            // Verticals
            drawLine(color, Offset(offsetX + cropWidth / 3, offsetY), Offset(offsetX + cropWidth / 3, offsetY + cropHeight), strokeWidth = 2f)
            drawLine(color, Offset(offsetX + 2 * cropWidth / 3, offsetY), Offset(offsetX + 2 * cropWidth / 3, offsetY + cropHeight), strokeWidth = 2f)
            // Horizontals
            drawLine(color, Offset(offsetX, offsetY + cropHeight / 3), Offset(offsetX + cropWidth, offsetY + cropHeight / 3), strokeWidth = 2f)
            drawLine(color, Offset(offsetX, offsetY + 2 * cropHeight / 3), Offset(offsetX + cropWidth, offsetY + 2 * cropHeight / 3), strokeWidth = 2f)

            // Corner handles
            val handleLen = 30f
            val handleColor = Color.White
            
            // Top Left
            drawLine(handleColor, Offset(offsetX, offsetY), Offset(offsetX + handleLen, offsetY), strokeWidth = 8f)
            drawLine(handleColor, Offset(offsetX, offsetY), Offset(offsetX, offsetY + handleLen), strokeWidth = 8f)
            // Top Right
            drawLine(handleColor, Offset(offsetX + cropWidth, offsetY), Offset(offsetX + cropWidth - handleLen, offsetY), strokeWidth = 8f)
            drawLine(handleColor, Offset(offsetX + cropWidth, offsetY), Offset(offsetX + cropWidth, offsetY + handleLen), strokeWidth = 8f)
            // Bottom Left
            drawLine(handleColor, Offset(offsetX, offsetY + cropHeight), Offset(offsetX + handleLen, offsetY + cropHeight), strokeWidth = 8f)
            drawLine(handleColor, Offset(offsetX, offsetY + cropHeight), Offset(offsetX, offsetY + cropHeight - handleLen), strokeWidth = 8f)
            // Bottom Right
            drawLine(handleColor, Offset(offsetX + cropWidth, offsetY + cropHeight), Offset(offsetX + cropWidth - handleLen, offsetY + cropHeight), strokeWidth = 8f)
            drawLine(handleColor, Offset(offsetX + cropWidth, offsetY + cropHeight), Offset(offsetX + cropWidth, offsetY + cropHeight - handleLen), strokeWidth = 8f)
        }

        // Toolbar
        Row(
            modifier = Modifier
                .align(Alignment.BottomCenter)
                .fillMaxWidth()
                .background(Color.Black.copy(alpha = 0.7f))
                .padding(16.dp),
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            IconButton(onClick = onCancel) {
                Icon(Icons.Default.Close, "Cancel", tint = Color.White)
            }
            IconButton(onClick = { /* Rotate */ }) {
                Icon(Icons.Default.RotateRight, "Rotate", tint = Color.White)
            }
            IconButton(onClick = onConfirm) {
                Icon(Icons.Default.Check, "Confirm", tint = MaterialTheme.colorScheme.primary)
            }
        }
    }
}
