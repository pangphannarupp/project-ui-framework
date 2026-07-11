package kh.mcnc.lib.components

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Check
import androidx.compose.material.icons.filled.Close
import androidx.compose.material.icons.filled.Lock
import androidx.compose.material3.Icon
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
fun BizFeedbackSheet(
    isVisible: Boolean,
    icon: String = "error", // "error", "success", "locked"
    title: String = "Action Required",
    description: String? = null,
    buttonText: String = "Okay",
    onAction: () -> Unit = {},
    onDismissRequest: () -> Unit,
    content: (@Composable () -> Unit)? = null
) {
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
            Box(
                modifier = Modifier.padding(top = 8.dp, bottom = 20.dp)
            ) {
                when (icon) {
                    "error" -> {
                        Box(
                            modifier = Modifier
                                .size(72.dp)
                                .background(Color(0xFFFFEDED), CircleShape),
                            contentAlignment = Alignment.Center
                        ) {
                            Box(
                                modifier = Modifier
                                    .size(48.dp)
                                    .background(Color(0xFFD93025), CircleShape),
                                contentAlignment = Alignment.Center
                            ) {
                                Icon(
                                    imageVector = Icons.Default.Close,
                                    contentDescription = "Error",
                                    tint = Color.White,
                                    modifier = Modifier.size(28.dp)
                                )
                            }
                        }
                    }
                    "locked" -> {
                        Box(
                            modifier = Modifier
                                .size(72.dp)
                                .background(Color(0xFFFFEDED), CircleShape),
                            contentAlignment = Alignment.Center
                        ) {
                            Box(
                                modifier = Modifier
                                    .size(48.dp)
                                    .background(Color(0xFFD93025), CircleShape),
                                contentAlignment = Alignment.Center
                            ) {
                                Icon(
                                    imageVector = Icons.Default.Lock,
                                    contentDescription = "Locked",
                                    tint = Color.White,
                                    modifier = Modifier.size(24.dp)
                                )
                            }
                        }
                    }
                    "success" -> {
                        Box(
                            modifier = Modifier
                                .size(72.dp)
                                .background(Color(0xFFE6F4EA), CircleShape),
                            contentAlignment = Alignment.Center
                        ) {
                            Box(
                                modifier = Modifier
                                    .size(48.dp)
                                    .background(Color(0xFF1E8E3E), CircleShape),
                                contentAlignment = Alignment.Center
                            ) {
                                Icon(
                                    imageVector = Icons.Default.Check,
                                    contentDescription = "Success",
                                    tint = Color.White,
                                    modifier = Modifier.size(28.dp)
                                )
                            }
                        }
                    }
                }
            }

            Text(
                text = title,
                fontSize = 18.sp,
                fontWeight = FontWeight.Bold,
                color = Color(0xFF1A2A5E),
                textAlign = TextAlign.Center,
                modifier = Modifier.padding(bottom = 10.dp)
            )

            if (!description.isNullOrEmpty()) {
                Text(
                    text = description,
                    fontSize = 13.sp,
                    color = Color(0xFF555555),
                    textAlign = TextAlign.Center,
                    lineHeight = 18.sp,
                    modifier = Modifier.padding(horizontal = 16.dp).padding(bottom = 24.dp)
                )
            } else if (content == null) {
                Spacer(modifier = Modifier.height(24.dp))
            }

            if (content != null) {
                Box(modifier = Modifier.fillMaxWidth().padding(bottom = 24.dp)) {
                    content()
                }
            }

            BizButton(
                text = buttonText,
                variant = BizButtonVariant.Primary,
                block = true,
                onClick = {
                    onAction()
                    onDismissRequest()
                }
            )
        }
    }
}
