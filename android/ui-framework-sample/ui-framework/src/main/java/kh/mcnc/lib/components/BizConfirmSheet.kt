package kh.mcnc.lib.components

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
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
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Warning

@Composable
fun BizConfirmSheet(
    isVisible: Boolean,
    title: String,
    subtitle: String? = null,
    confirmText: String? = "Confirm",
    cancelText: String? = "Cancel",
    onConfirm: () -> Unit = {},
    onDismissRequest: () -> Unit,
    icon: (@Composable () -> Unit)? = null
) {
    BizBottomSheet(
        isVisible = isVisible,
        onDismissRequest = onDismissRequest
    ) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = 20.dp)
                .padding(bottom = 40.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Box(modifier = Modifier.padding(bottom = 24.dp)) {
                if (icon != null) {
                    icon()
                } else {
                    Box(
                        modifier = Modifier
                            .size(90.dp)
                            .background(Color(0xFFFFF8E6), CircleShape),
                        contentAlignment = Alignment.Center
                    ) {
                        Icon(
                            imageVector = Icons.Default.Warning,
                            contentDescription = "Warning",
                            modifier = Modifier.size(48.dp),
                            tint = Color(0xFFF5A623)
                        )
                    }
                }
            }

            Text(
                text = title,
                fontSize = 22.sp,
                fontWeight = FontWeight.Bold,
                color = Color(0xFF1A2A5E),
                modifier = Modifier.padding(bottom = 8.dp),
                textAlign = TextAlign.Center
            )

            if (subtitle != null) {
                Text(
                    text = subtitle,
                    fontSize = 15.sp,
                    color = Color(0xFF666666),
                    modifier = Modifier.padding(bottom = 32.dp),
                    textAlign = TextAlign.Center
                )
            } else {
                Spacer(modifier = Modifier.height(24.dp))
            }

            Column(
                modifier = Modifier.fillMaxWidth(),
                verticalArrangement = Arrangement.spacedBy(16.dp)
            ) {
                if (confirmText != null) {
                    BizButton(
                        text = confirmText,
                        variant = BizButtonVariant.OutlineDanger,
                        block = true,
                        onClick = onConfirm
                    )
                }
                if (cancelText != null) {
                    BizButton(
                        text = cancelText,
                        variant = BizButtonVariant.Outline,
                        block = true,
                        onClick = onDismissRequest
                    )
                }
            }
        }
    }
}
