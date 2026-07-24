package kh.mcnc.lib.components

import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Info
import androidx.compose.material.icons.filled.Lock
import androidx.compose.material3.Icon
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

@Composable
fun BizBiometricSheet(
    isVisible: Boolean,
    type: String = "both", // "both", "face", "fingerprint"
    onDismissRequest: () -> Unit,
    onSetup: (String) -> Unit = {},
    onLater: () -> Unit = {}
) {
    val titleName = when (type) {
        "face" -> "Face ID"
        "fingerprint" -> "Fingerprint ID"
        else -> "Biometrics"
    }

    val subtitleName = when (type) {
        "face" -> "Face ID"
        "fingerprint" -> "Fingerprint"
        else -> "Face ID or Fingerprint"
    }

    val buttonName = when (type) {
        "face" -> "Face"
        "fingerprint" -> "Fingerprint"
        else -> "Biometrics"
    }

    BizBottomSheet(
        isVisible = isVisible,
        onDismissRequest = onDismissRequest
    ) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = 24.dp)
                .padding(bottom = 32.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            // Shield Icon
            Box(
                modifier = Modifier.padding(top = 8.dp, bottom = 24.dp)
            ) {
                Box(
                    modifier = Modifier
                        .size(72.dp)
                        .background(Color(0xFFE6F0FF), CircleShape),
                    contentAlignment = Alignment.Center
                ) {
                    Box(
                        modifier = Modifier
                            .size(48.dp)
                            .background(Color(0xFF003399), CircleShape),
                        contentAlignment = Alignment.Center
                    ) {
                        Icon(
                            imageVector = Icons.Default.Lock,
                            contentDescription = "Shield",
                            tint = Color.White,
                            modifier = Modifier.size(24.dp)
                        )
                    }
                }
            }

            Text(
                text = "Unlock faster with $titleName",
                fontSize = 20.sp,
                fontWeight = FontWeight.Bold,
                color = Color(0xFF1A2A5E),
                textAlign = TextAlign.Center,
                modifier = Modifier.padding(bottom = 12.dp)
            )

            Text(
                text = "Skip PIN entry and securely access your account using $subtitleName.",
                fontSize = 13.sp,
                color = Color(0xFF555555),
                textAlign = TextAlign.Center,
                lineHeight = 18.sp,
                modifier = Modifier.padding(horizontal = 16.dp).padding(bottom = 32.dp)
            )

            // Selection Cards
            Box(
                modifier = Modifier.fillMaxWidth().padding(bottom = 32.dp)
            ) {
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = if (type == "both") Arrangement.SpaceBetween else Arrangement.Center
                ) {
                    if (type == "both" || type == "face") {
                        Surface(
                            modifier = Modifier
                                .weight(if (type == "both") 1f else 0f)
                                .width(if (type != "both") 160.dp else 0.dp),
                            shape = RoundedCornerShape(16.dp),
                            color = Color.White,
                            border = BorderStroke(1.dp, Color(0xFFEAEAEA)),
                            shadowElevation = 2.dp
                        ) {
                            Column(
                                modifier = Modifier.padding(vertical = 24.dp, horizontal = 16.dp),
                                horizontalAlignment = Alignment.CenterHorizontally
                            ) {
                                // Simplified icon for Face ID
                                Icon(
                                    imageVector = Icons.Default.Info, // Use appropriate icon resource
                                    contentDescription = "Face ID",
                                    tint = Color(0xFF0066CC),
                                    modifier = Modifier.size(40.dp).padding(bottom = 16.dp)
                                )
                                Text("Face ID", fontSize = 14.sp, fontWeight = FontWeight.Bold, color = Color(0xFF1A2A5E))
                                Text("Use facial recognition", fontSize = 11.sp, color = Color(0xFF777777), textAlign = TextAlign.Center)
                            }
                        }
                    }

                    if (type == "both") {
                        Spacer(modifier = Modifier.width(16.dp))
                    }

                    if (type == "both" || type == "fingerprint") {
                        Surface(
                            modifier = Modifier
                                .weight(if (type == "both") 1f else 0f)
                                .width(if (type != "both") 160.dp else 0.dp),
                            shape = RoundedCornerShape(16.dp),
                            color = Color.White,
                            border = BorderStroke(1.dp, Color(0xFFEAEAEA)),
                            shadowElevation = 2.dp
                        ) {
                            Column(
                                modifier = Modifier.padding(vertical = 24.dp, horizontal = 16.dp),
                                horizontalAlignment = Alignment.CenterHorizontally
                            ) {
                                // Simplified icon for Fingerprint
                                Icon(
                                    imageVector = Icons.Default.Info, // Use appropriate icon resource
                                    contentDescription = "Fingerprint",
                                    tint = Color(0xFF0066CC),
                                    modifier = Modifier.size(40.dp).padding(bottom = 16.dp)
                                )
                                Text("Fingerprint ID", fontSize = 14.sp, fontWeight = FontWeight.Bold, color = Color(0xFF1A2A5E))
                                Text("Use your fingerprint", fontSize = 11.sp, color = Color(0xFF777777), textAlign = TextAlign.Center)
                            }
                        }
                    }
                }

                if (type == "both") {
                    Box(
                        modifier = Modifier
                            .align(Alignment.Center)
                            .size(32.dp)
                            .background(Color(0xFFF8F9FA), CircleShape),
                        contentAlignment = Alignment.Center
                    ) {
                        Text("Or", fontSize = 12.sp, fontWeight = FontWeight.SemiBold, color = Color(0xFF1A2A5E))
                    }
                }
            }

            // Info Banner
            Row(
                modifier = Modifier.fillMaxWidth().padding(bottom = 32.dp),
                verticalAlignment = Alignment.Top,
                horizontalArrangement = Arrangement.spacedBy(12.dp)
            ) {
                Icon(
                    imageVector = Icons.Default.Info,
                    contentDescription = "Info",
                    tint = Color(0xFF0066CC),
                    modifier = Modifier.size(20.dp).padding(top = 2.dp)
                )
                Column {
                    Text("Face / Fingerprint ID", fontSize = 13.sp, fontWeight = FontWeight.Bold, color = Color(0xFF1A2A5E), modifier = Modifier.padding(bottom = 4.dp))
                    Text(
                        "Link your Face or Fingerprint ID for quick and easy access to your account. Enjoy seamless logins and hassle-free payments by setting it up now.",
                        fontSize = 11.sp,
                        color = Color(0xFF666666),
                        lineHeight = 16.sp
                    )
                }
            }

            BizButton(
                text = "Set $buttonName ID",
                variant = BizButtonVariant.Primary,
                block = true,
                onClick = {
                    onSetup(type)
                    onDismissRequest()
                }
            )
            Spacer(modifier = Modifier.height(12.dp))
            BizButton(
                text = "Maybe Later",
                variant = BizButtonVariant.Outline,
                block = true,
                onClick = {
                    onLater()
                    onDismissRequest()
                }
            )
        }
    }
}
