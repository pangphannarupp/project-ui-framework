package kh.mcnc.lib.ui.components

import androidx.compose.animation.AnimatedVisibility
import androidx.compose.animation.expandVertically
import androidx.compose.animation.shrinkVertically
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.CloudDone
import androidx.compose.material.icons.filled.CloudOff
import androidx.compose.material.icons.filled.Sync
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import kotlinx.coroutines.delay

enum class NetworkState {
    ONLINE, OFFLINE, SYNCING
}

@Composable
fun AppNetworkStatus(
    state: NetworkState,
    modifier: Modifier = Modifier,
    autoHideOnline: Boolean = true
) {
    var isVisible by remember { mutableStateOf(false) }

    LaunchedEffect(state) {
        isVisible = true
        if (state == NetworkState.ONLINE && autoHideOnline) {
            delay(2000)
            isVisible = false
        }
    }

    AnimatedVisibility(
        visible = isVisible,
        enter = expandVertically(expandFrom = Alignment.Top),
        exit = shrinkVertically(shrinkTowards = Alignment.Top),
        modifier = modifier.fillMaxWidth()
    ) {
        val (bgColor, icon, text) = when (state) {
            NetworkState.ONLINE -> Triple(Color(0xFF4CAF50), Icons.Default.CloudDone, "Back Online")
            NetworkState.OFFLINE -> Triple(Color(0xFFF44336), Icons.Default.CloudOff, "No Internet Connection")
            NetworkState.SYNCING -> Triple(Color(0xFFFF9800), Icons.Default.Sync, "Syncing Data...")
        }

        Row(
            modifier = Modifier
                .fillMaxWidth()
                .background(bgColor)
                .padding(vertical = 8.dp, horizontal = 16.dp),
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.Center
        ) {
            Icon(
                imageVector = icon,
                contentDescription = text,
                tint = Color.White,
                modifier = Modifier.size(20.dp)
            )
            Spacer(modifier = Modifier.width(8.dp))
            Text(
                text = text,
                color = Color.White,
                style = MaterialTheme.typography.labelMedium,
                fontWeight = FontWeight.Bold
            )
        }
    }
}
