package kh.mcnc.lib.ui.components

import androidx.compose.foundation.Canvas
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.CornerRadius
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.geometry.Rect
import androidx.compose.ui.geometry.RoundRect
import androidx.compose.ui.geometry.Size
import androidx.compose.ui.graphics.ClipOp
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Path
import androidx.compose.ui.graphics.SolidColor
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.graphics.drawscope.clipPath
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp

@Composable
fun AppDocumentScannerView(
    modifier: Modifier = Modifier,
    instructionText: String = "Align document within the frame",
    frameAspectRatio: Float = 1.58f // Standard ID card aspect ratio (85.60 × 53.98 mm)
) {
    val overlayColor = Color.Black.copy(alpha = 0.6f)
    val frameColor = MaterialTheme.colorScheme.primary

    Box(modifier = modifier.fillMaxSize()) {
        Canvas(modifier = Modifier.fillMaxSize()) {
            val canvasWidth = size.width
            val canvasHeight = size.height

            val frameWidth = canvasWidth * 0.85f
            val frameHeight = frameWidth / frameAspectRatio

            val left = (canvasWidth - frameWidth) / 2
            val top = (canvasHeight - frameHeight) / 2
            val right = left + frameWidth
            val bottom = top + frameHeight

            val cornerRadius = CornerRadius(24f, 24f)
            val rectPath = Path().apply {
                addRoundRect(
                    RoundRect(
                        rect = Rect(left, top, right, bottom),
                        cornerRadius = cornerRadius
                    )
                )
            }

            // Draw semi-transparent overlay with clear cutout
            clipPath(rectPath, clipOp = ClipOp.Difference) {
                drawRect(SolidColor(overlayColor))
            }

            // Draw corner brackets
            val bracketLength = 60f
            val strokeWidth = 12f
            
            val bracketStroke = Stroke(width = strokeWidth)

            // Top Left
            drawPath(
                path = Path().apply {
                    moveTo(left, top + bracketLength)
                    lineTo(left, top + cornerRadius.y)
                    quadraticBezierTo(left, top, left + cornerRadius.x, top)
                    lineTo(left + bracketLength, top)
                },
                color = frameColor,
                style = bracketStroke
            )

            // Top Right
            drawPath(
                path = Path().apply {
                    moveTo(right - bracketLength, top)
                    lineTo(right - cornerRadius.x, top)
                    quadraticBezierTo(right, top, right, top + cornerRadius.y)
                    lineTo(right, top + bracketLength)
                },
                color = frameColor,
                style = bracketStroke
            )

            // Bottom Left
            drawPath(
                path = Path().apply {
                    moveTo(left, bottom - bracketLength)
                    lineTo(left, bottom - cornerRadius.y)
                    quadraticBezierTo(left, bottom, left + cornerRadius.x, bottom)
                    lineTo(left + bracketLength, bottom)
                },
                color = frameColor,
                style = bracketStroke
            )

            // Bottom Right
            drawPath(
                path = Path().apply {
                    moveTo(right - bracketLength, bottom)
                    lineTo(right - cornerRadius.x, bottom)
                    quadraticBezierTo(right, bottom, right, bottom - cornerRadius.y)
                    lineTo(right, bottom - bracketLength)
                },
                color = frameColor,
                style = bracketStroke
            )
        }

        Text(
            text = instructionText,
            color = Color.White,
            style = MaterialTheme.typography.titleMedium,
            fontWeight = FontWeight.SemiBold,
            modifier = Modifier
                .align(Alignment.BottomCenter)
                .padding(bottom = 64.dp)
        )
    }
}
