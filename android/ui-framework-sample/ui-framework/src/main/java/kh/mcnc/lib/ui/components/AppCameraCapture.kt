package kh.mcnc.lib.ui.components

import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.CameraAlt
import androidx.compose.material.icons.filled.Close
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.CornerRadius
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.geometry.Size
import androidx.compose.ui.graphics.BlendMode
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp

@Composable
fun AppCameraCapture(
    modifier: Modifier = Modifier,
    onCaptureClick: () -> Unit = {},
    onCloseClick: () -> Unit = {}
) {
    Box(modifier = modifier.fillMaxWidth().aspectRatio(3f / 4f).background(Color.DarkGray)) {
        // Mock Camera Feed Content
        Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
            Text(
                text = "Camera Feed Active",
                color = Color.White.copy(alpha = 0.3f),
                style = MaterialTheme.typography.titleLarge
            )
        }

        // Overlay with Cutout
        Canvas(
            modifier = Modifier
                .fillMaxSize()
                .graphicsLayer { alpha = 0.99f } // Needed for BlendMode.Clear
        ) {
            val canvasWidth = size.width
            val canvasHeight = size.height

            val cutoutWidth = canvasWidth * 0.85f
            val cutoutHeight = cutoutWidth * 0.63f // Standard ID card ratio
            val cutoutOffsetX = (canvasWidth - cutoutWidth) / 2f
            val cutoutOffsetY = (canvasHeight - cutoutHeight) / 2f

            // Draw dark overlay
            drawRect(color = Color.Black.copy(alpha = 0.7f), size = size)

            // Punch out hole
            drawRoundRect(
                color = Color.Transparent,
                topLeft = Offset(cutoutOffsetX, cutoutOffsetY),
                size = Size(cutoutWidth, cutoutHeight),
                cornerRadius = CornerRadius(16.dp.toPx()),
                blendMode = BlendMode.Clear
            )
        }

        // UI Controls
        Column(
            modifier = Modifier.fillMaxSize().padding(16.dp),
            verticalArrangement = Arrangement.SpaceBetween,
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            // Top Bar
            Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.End) {
                IconButton(onClick = onCloseClick) {
                    Icon(imageVector = Icons.Default.Close, contentDescription = "Close", tint = Color.White)
                }
            }

            // Bottom Bar
            Column(horizontalAlignment = Alignment.CenterHorizontally) {
                Text(
                    text = "Align ID card within the frame",
                    color = Color.White,
                    style = MaterialTheme.typography.bodyLarge,
                    fontWeight = FontWeight.Medium
                )
                Spacer(modifier = Modifier.height(24.dp))
                IconButton(
                    onClick = onCaptureClick,
                    modifier = Modifier.size(72.dp).background(Color.White.copy(alpha = 0.3f), CircleShape)
                ) {
                    Icon(
                        imageVector = Icons.Default.CameraAlt,
                        contentDescription = "Capture",
                        tint = Color.White,
                        modifier = Modifier.size(36.dp)
                    )
                }
            }
        }
    }
}
