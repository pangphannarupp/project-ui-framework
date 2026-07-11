package kh.mcnc.lib.ui.components

import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.defaultMinSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.OutlinedButton
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import kh.mcnc.lib.ui.theme.AppButtonHeight
import kh.mcnc.lib.ui.theme.AppSpacing

@Composable
fun AppPrimaryButton(
    text: String,
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
    enabled: Boolean = true,
    isLoading: Boolean = false
) {
    Button(
        onClick = onClick,
        modifier = modifier.defaultMinSize(minHeight = AppButtonHeight.md),
        enabled = enabled && !isLoading
    ) {
        if (isLoading) {
            CircularProgressIndicator(
                modifier = Modifier.size(20.dp),
                color = androidx.compose.material3.MaterialTheme.colorScheme.onPrimary,
                strokeWidth = 2.dp
            )
        } else {
            Text(text = text)
        }
    }
}

@Composable
fun AppSecondaryButton(
    text: String,
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
    enabled: Boolean = true,
    isLoading: Boolean = false
) {
    Button(
        onClick = onClick,
        modifier = modifier.defaultMinSize(minHeight = AppButtonHeight.md),
        enabled = enabled && !isLoading,
        colors = ButtonDefaults.buttonColors(
            containerColor = androidx.compose.material3.MaterialTheme.colorScheme.secondaryContainer,
            contentColor = androidx.compose.material3.MaterialTheme.colorScheme.onSecondaryContainer
        )
    ) {
        if (isLoading) {
            CircularProgressIndicator(
                modifier = Modifier.size(20.dp),
                color = androidx.compose.material3.MaterialTheme.colorScheme.onSecondaryContainer,
                strokeWidth = 2.dp
            )
        } else {
            Text(text = text)
        }
    }
}

@Composable
fun AppOutlinedButton(
    text: String,
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
    enabled: Boolean = true,
    isLoading: Boolean = false
) {
    OutlinedButton(
        onClick = onClick,
        modifier = modifier.defaultMinSize(minHeight = AppButtonHeight.md),
        enabled = enabled && !isLoading
    ) {
        if (isLoading) {
            CircularProgressIndicator(
                modifier = Modifier.size(20.dp),
                color = androidx.compose.material3.MaterialTheme.colorScheme.primary,
                strokeWidth = 2.dp
            )
        } else {
            Text(text = text)
        }
    }
}
