package kh.mcnc.lib.ui.components.pin

import androidx.compose.animation.core.Animatable
import androidx.compose.animation.core.keyframes
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.Backspace
import androidx.compose.material.icons.automirrored.filled.KeyboardArrowLeft
import androidx.compose.material.icons.filled.ArrowBackIosNew
import androidx.compose.material.icons.filled.ErrorOutline
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.toArgb
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import kotlinx.coroutines.launch

@Composable
fun AppPinScreen(
    title: String,
    subtitle: String,
    isError: Boolean = false,
    errorMessage: String? = null,
    passcodeLength: Int = 6,
    onPasscodeComplete: (String) -> Unit,
    onBack: () -> Unit,
    modifier: Modifier = Modifier
) {
    var passcode by remember { mutableStateOf("") }
    
    val view = androidx.compose.ui.platform.LocalView.current
    if (!view.isInEditMode) {
        SideEffect {
            val window = (view.context as android.app.Activity).window
            window.statusBarColor = android.graphics.Color.TRANSPARENT
            androidx.core.view.WindowCompat.getInsetsController(window, view).isAppearanceLightStatusBars = false
        }
        
        DisposableEffect(Unit) {
            onDispose {
                val window = (view.context as android.app.Activity).window
                window.statusBarColor = kh.mcnc.lib.ui.theme.AppPrimary.toArgb() // Revert to theme primary
            }
        }
    }
    
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
            .fillMaxSize()
            .background(Color(0xFF3271D5)) // Matches the bottom of the gradient
    ) {
        // Top section
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .background(
                    androidx.compose.ui.graphics.Brush.verticalGradient(
                        colors = listOf(Color(0xFF0E1B34), Color(0xFF3271D5))
                    )
                )
                .statusBarsPadding()
                .padding(top = 16.dp, start = 24.dp, end = 24.dp, bottom = 32.dp)
        ) {
            IconButton(onClick = onBack) {
                Icon(
                    imageVector = Icons.Default.ArrowBackIosNew,
                    contentDescription = "Back",
                    tint = Color.White
                )
            }
            
            Spacer(modifier = Modifier.height(16.dp))
            
            Text(
                text = title,
                color = Color.White,
                fontSize = 28.sp,
                fontWeight = FontWeight.Bold
            )
            
            Spacer(modifier = Modifier.height(8.dp))
            
            Text(
                text = subtitle,
                color = Color.White.copy(alpha = 0.9f),
                fontSize = 14.sp,
                lineHeight = 20.sp
            )
        }
        
        // Bottom sheet style container
        Box(
            modifier = Modifier
                .fillMaxWidth()
                .weight(1f)
                .background(
                    color = Color.White,
                    shape = RoundedCornerShape(topStart = 24.dp, topEnd = 24.dp)
                )
        ) {
            Column(
                modifier = Modifier
                    .fillMaxSize()
                    .navigationBarsPadding(),
                horizontalAlignment = Alignment.CenterHorizontally
            ) {
                Spacer(modifier = Modifier.height(48.dp))
                
                // Dots container
                Box(
                    modifier = Modifier.height(64.dp),
                    contentAlignment = Alignment.Center
                ) {
                    Column(horizontalAlignment = Alignment.CenterHorizontally) {
                        Row(
                            horizontalArrangement = Arrangement.spacedBy(16.dp),
                            modifier = Modifier.offset(x = shakeOffset.value.dp)
                        ) {
                            repeat(passcodeLength) { index ->
                                val isFilled = index < passcode.length
                                Box(
                                    modifier = Modifier
                                        .size(16.dp)
                                        .clip(CircleShape)
                                        .then(
                                            when {
                                                isError -> Modifier.background(Color(0xFFE02424)) // Red
                                                isFilled -> Modifier.background(Color(0xFF1E3A8A)) // Dark Blue
                                                else -> Modifier.border(1.dp, Color(0xFFD1D5DB), CircleShape) // Outline
                                            }
                                        )
                                )
                            }
                        }
                        
                        if (isError && errorMessage != null) {
                            Spacer(modifier = Modifier.height(12.dp))
                            Row(
                                verticalAlignment = Alignment.CenterVertically,
                                horizontalArrangement = Arrangement.Center
                            ) {
                                Icon(
                                    imageVector = Icons.Default.ErrorOutline,
                                    contentDescription = "Error",
                                    tint = Color(0xFFE02424),
                                    modifier = Modifier.size(14.dp)
                                )
                                Spacer(modifier = Modifier.width(4.dp))
                                Text(
                                    text = errorMessage,
                                    color = Color(0xFFE02424),
                                    fontSize = 12.sp,
                                    fontWeight = FontWeight.Medium
                                )
                            }
                        }
                    }
                }
                
                Spacer(modifier = Modifier.weight(1f))
                
                // Keypad Area
                Box(
                    modifier = Modifier
                        .fillMaxWidth()
//                        .padding(24.dp)
                        .clip(RoundedCornerShape(24.dp))
                        .background(Color(0xFFF3F4F6)) // Light gray background for keypad area
                        .padding(24.dp)
                ) {
                    AppPinKeypad(
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
                        }
                    )
                }
            }
        }
    }
}

@Composable
fun AppPinKeypad(
    onKeyPress: (String) -> Unit,
    onBackspace: () -> Unit,
    modifier: Modifier = Modifier
) {
    val rows = listOf(
        listOf("1", "2", "3"),
        listOf("4", "5", "6"),
        listOf("7", "8", "9"),
        listOf("", "0", "DEL")
    )

    Column(
        modifier = modifier.fillMaxWidth(),
        verticalArrangement = Arrangement.spacedBy(12.dp)
    ) {
        rows.forEach { row ->
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.spacedBy(12.dp)
            ) {
                row.forEach { key ->
                    Box(modifier = Modifier.weight(1f)) {
                        if (key.isNotEmpty()) {
                            KeypadButton(
                                key = key,
                                onClick = {
                                    if (key == "DEL") {
                                        onBackspace()
                                    } else {
                                        onKeyPress(key)
                                    }
                                }
                            )
                        }
                    }
                }
            }
        }
    }
}

@Composable
private fun KeypadButton(
    key: String,
    onClick: () -> Unit
) {
    Surface(
        onClick = onClick,
        shape = RoundedCornerShape(12.dp),
        color = Color.White,
        modifier = Modifier
            .fillMaxWidth()
            .height(56.dp)
    ) {
        Box(contentAlignment = Alignment.Center) {
            if (key == "DEL") {
                Icon(
                    imageVector = Icons.AutoMirrored.Filled.Backspace,
                    contentDescription = "Backspace",
                    tint = Color.Black,
                    modifier = Modifier.size(24.dp)
                )
            } else {
                Text(
                    text = key,
                    fontSize = 24.sp,
                    fontWeight = FontWeight.Medium,
                    color = Color.Black
                )
            }
        }
    }
}
