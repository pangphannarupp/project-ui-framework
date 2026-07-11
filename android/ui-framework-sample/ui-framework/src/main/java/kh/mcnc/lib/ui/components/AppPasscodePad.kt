package kh.mcnc.lib.ui.components

import androidx.compose.animation.core.*
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp

@Composable
fun AppPasscodePad(
    passcodeLength: Int = 4,
    onPasscodeComplete: (String) -> Unit,
    modifier: Modifier = Modifier,
    title: String = "Enter Passcode",
    subtitle: String = "Please enter your PIN to continue",
    isError: Boolean = false,
    errorMessage: String? = null
) {
    var passcode by remember { mutableStateOf("") }
    
    // Shake animation state for error
    val shakeOffset = remember { Animatable(0f) }
    
    LaunchedEffect(isError) {
        if (isError) {
            passcode = "" // Clear on error
            shakeOffset.animateTo(
                targetValue = 10f,
                animationSpec = keyframes {
                    durationMillis = 400
                    0f at 0
                    -10f at 50
                    10f at 100
                    -10f at 150
                    10f at 200
                    -10f at 250
                    10f at 300
                    0f at 400
                }
            )
        }
    }

    Column(
        modifier = modifier
            .fillMaxWidth()
            .padding(24.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Text(
            text = title,
            style = MaterialTheme.typography.headlineSmall,
            fontWeight = FontWeight.Bold,
            color = MaterialTheme.colorScheme.onBackground
        )
        Spacer(modifier = Modifier.height(8.dp))
        Text(
            text = if (isError && errorMessage != null) errorMessage else subtitle,
            style = MaterialTheme.typography.bodyMedium,
            color = if (isError) MaterialTheme.colorScheme.error else MaterialTheme.colorScheme.onSurfaceVariant
        )
        
        Spacer(modifier = Modifier.height(48.dp))
        
        // Dots
        Row(
            horizontalArrangement = Arrangement.spacedBy(24.dp),
            modifier = Modifier.offset(x = shakeOffset.value.dp)
        ) {
            repeat(passcodeLength) { index ->
                val isFilled = index < passcode.length
                Box(
                    modifier = Modifier
                        .size(16.dp)
                        .clip(CircleShape)
                        .background(
                            if (isError) MaterialTheme.colorScheme.error
                            else if (isFilled) MaterialTheme.colorScheme.primary 
                            else Color.LightGray
                        )
                )
            }
        }
        
        Spacer(modifier = Modifier.height(64.dp))
        
        // Keypad
        AppCurrencyKeypad(
            onKeyPress = { key ->
                if (passcode.length < passcodeLength && !isError) {
                    passcode += key
                    if (passcode.length == passcodeLength) {
                        onPasscodeComplete(passcode)
                    }
                }
            },
            onBackspace = {
                if (passcode.isNotEmpty()) {
                    passcode = passcode.dropLast(1)
                }
            },
            specialKey = ""
        )
    }
}
