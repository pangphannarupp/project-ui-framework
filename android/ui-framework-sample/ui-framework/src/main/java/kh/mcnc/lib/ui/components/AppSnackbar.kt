package kh.mcnc.lib.ui.components

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.CheckCircle
import androidx.compose.material.icons.filled.Error
import androidx.compose.material.icons.filled.Info
import androidx.compose.material.icons.filled.Warning
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.unit.dp

enum class AppSnackbarType {
    Success, Error, Warning, Info
}

@Composable
fun AppSnackbar(
    snackbarData: SnackbarData,
    type: AppSnackbarType = AppSnackbarType.Info
) {
    val (containerColor, icon, iconColor) = when (type) {
        AppSnackbarType.Success -> Triple(Color(0xFFE8F5E9), Icons.Default.CheckCircle, Color(0xFF2E7D32))
        AppSnackbarType.Error -> Triple(Color(0xFFFFEBEE), Icons.Default.Error, Color(0xFFC62828))
        AppSnackbarType.Warning -> Triple(Color(0xFFFFF8E1), Icons.Default.Warning, Color(0xFFF9A825))
        AppSnackbarType.Info -> Triple(Color(0xFFE3F2FD), Icons.Default.Info, Color(0xFF1565C0))
    }

    Snackbar(
        modifier = Modifier.padding(16.dp),
        shape = RoundedCornerShape(8.dp),
        containerColor = containerColor,
        contentColor = Color.Black,
        action = snackbarData.visuals.actionLabel?.let { actionLabel ->
            {
                TextButton(onClick = { snackbarData.performAction() }) {
                    Text(
                        text = actionLabel,
                        color = iconColor
                    )
                }
            }
        }
    ) {
        Row(
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.spacedBy(12.dp)
        ) {
            Icon(
                imageVector = icon,
                contentDescription = type.name,
                tint = iconColor
            )
            Text(
                text = snackbarData.visuals.message,
                color = Color.Black.copy(alpha = 0.8f),
                style = MaterialTheme.typography.bodyMedium
            )
        }
    }
}
