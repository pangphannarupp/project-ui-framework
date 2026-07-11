package kh.mcnc.lib.ui.components

import androidx.compose.foundation.Canvas
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.geometry.Size
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.drawscope.rotate
import kotlin.random.Random
import kotlinx.coroutines.isActive

data class ConfettiParticle(
    val startX: Float,
    val startY: Float,
    val speedY: Float,
    val speedX: Float,
    val rotationSpeed: Float,
    val color: Color,
    val size: Float
)

@Composable
fun AppConfetti(
    modifier: Modifier = Modifier,
    particleCount: Int = 100,
    colors: List<Color> = listOf(
        Color(0xFFE2B714), Color(0xFF328332), 
        Color(0xFF8B2252), Color(0xFF4A708B), 
        Color(0xFFFF8C00)
    )
) {
    // Generate particles once
    val particles = remember {
        List(particleCount) {
            ConfettiParticle(
                startX = Random.nextFloat(), // relative to width 0..1
                startY = Random.nextFloat() * -1f, // start above screen
                speedY = Random.nextFloat() * 1000f + 500f, // pixels per second
                speedX = (Random.nextFloat() - 0.5f) * 400f,
                rotationSpeed = (Random.nextFloat() - 0.5f) * 360f,
                color = colors[Random.nextInt(colors.size)],
                size = Random.nextFloat() * 20f + 10f
            )
        }
    }

    var timeMs by remember { mutableStateOf(0L) }

    LaunchedEffect(Unit) {
        val startTime = System.currentTimeMillis()
        while (isActive) {
            withFrameMillis { 
                timeMs = System.currentTimeMillis() - startTime
            }
        }
    }

    Canvas(modifier = modifier.fillMaxSize()) {
        val width = size.width
        val height = size.height
        val timeSec = timeMs / 1000f

        particles.forEach { particle ->
            // Calculate current position
            val currentX = (particle.startX * width) + (particle.speedX * timeSec)
            val currentY = (particle.startY * height) + (particle.speedY * timeSec)
            val currentRotation = particle.rotationSpeed * timeSec

            // Loop back to top if it goes off bottom
            val wrappedY = currentY % (height + 100f)
            
            // Wrap X to stay on screen
            val wrappedX = ((currentX % width) + width) % width

            if (wrappedY > -50f) {
                rotate(degrees = currentRotation, pivot = Offset(wrappedX, wrappedY)) {
                    drawRect(
                        color = particle.color,
                        topLeft = Offset(wrappedX, wrappedY),
                        size = Size(particle.size, particle.size * 0.6f)
                    )
                }
            }
        }
    }
}
