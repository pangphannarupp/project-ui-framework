package kh.mcnc.lib.ui.components

import androidx.compose.animation.core.*
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Mic
import androidx.compose.material.icons.filled.Stop
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.CornerRadius
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.geometry.Size
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import kotlinx.coroutines.delay
import kotlin.random.Random

@Composable
fun AppAudioRecorder(
    modifier: Modifier = Modifier
) {
    var isRecording by remember { mutableStateOf(false) }
    var seconds by remember { mutableStateOf(0) }

    LaunchedEffect(isRecording) {
        while (isRecording) {
            delay(1000)
            seconds++
        }
        if (!isRecording && seconds > 0) {
            // keep seconds for preview, or reset if desired
        }
    }

    Surface(
        modifier = modifier.fillMaxWidth(),
        shape = RoundedCornerShape(16.dp),
        color = MaterialTheme.colorScheme.surfaceVariant,
        shadowElevation = 2.dp
    ) {
        Column(
            modifier = Modifier.padding(16.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            // Waveform
            Box(
                modifier = Modifier.fillMaxWidth().height(80.dp),
                contentAlignment = Alignment.Center
            ) {
                if (isRecording || seconds > 0) {
                    AudioWaveform(isAnimating = isRecording)
                } else {
                    Text("Tap mic to record", color = MaterialTheme.colorScheme.onSurfaceVariant)
                }
            }
            
            Spacer(modifier = Modifier.height(16.dp))
            
            // Timer
            Text(
                text = String.format("%02d:%02d", seconds / 60, seconds % 60),
                style = MaterialTheme.typography.titleLarge,
                color = if (isRecording) MaterialTheme.colorScheme.error else MaterialTheme.colorScheme.onSurface
            )
            
            Spacer(modifier = Modifier.height(16.dp))
            
            // Controls
            FloatingActionButton(
                onClick = {
                    if (!isRecording && seconds > 0) seconds = 0 // reset on new recording
                    isRecording = !isRecording 
                },
                containerColor = if (isRecording) MaterialTheme.colorScheme.error else MaterialTheme.colorScheme.primary,
                contentColor = Color.White,
                shape = CircleShape
            ) {
                Icon(
                    imageVector = if (isRecording) Icons.Default.Stop else Icons.Default.Mic,
                    contentDescription = if (isRecording) "Stop" else "Record"
                )
            }
        }
    }
}

@Composable
fun AudioWaveform(isAnimating: Boolean) {
    val barCount = 30
    
    // Instead of complex individual animations, we'll use a single infinite transition
    // and offset it by the bar index for a wave effect, blended with random noise if animating.
    val transition = rememberInfiniteTransition(label = "wave")
    val phase by transition.animateFloat(
        initialValue = 0f,
        targetValue = 2f * Math.PI.toFloat(),
        animationSpec = infiniteRepeatable(
            animation = tween(1500, easing = LinearEasing),
            repeatMode = RepeatMode.Restart
        ),
        label = "phase"
    )

    Canvas(modifier = Modifier.fillMaxSize()) {
        val barWidth = size.width / (barCount * 1.5f)
        val maxBarHeight = size.height * 0.8f
        val centerY = size.height / 2f
        
        val color = Color.Gray

        for (i in 0 until barCount) {
            val startX = i * (size.width / barCount)
            
            // Generate a height based on sine wave + noise if animating
            val targetHeight = if (isAnimating) {
                val wave = Math.sin((phase + (i * 0.5f)).toDouble()).toFloat()
                val noise = Random.nextFloat() * 0.5f
                (Math.abs(wave) * 0.5f + noise) * maxBarHeight
            } else {
                maxBarHeight * 0.3f // Static state
            }
            
            drawRoundRect(
                color = color,
                topLeft = Offset(startX, centerY - targetHeight / 2f),
                size = Size(barWidth, targetHeight.coerceAtLeast(4f)), // min height
                cornerRadius = CornerRadius(barWidth / 2f, barWidth / 2f)
            )
        }
    }
}
