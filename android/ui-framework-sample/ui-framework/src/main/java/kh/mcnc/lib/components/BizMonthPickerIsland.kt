package kh.mcnc.lib.components

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

/**
 * BizMonthPickerIsland - Jetpack Compose component matching Web UI-Framework `PPMonthPickerIsland.vue`.
 */
@Composable
fun BizMonthPickerIsland(
    modifier: Modifier = Modifier,
    modelValue: Boolean = false,
    title: String = "",
    config: String = "",
    initialDate: String = "",
    showActionButtons: Boolean = false,
    cancelText: String = "",
    confirmText: String = "",
    position: String = "top",
    fullWidth: Boolean = false,
    offset: Int = 16,
    onClick: () -> Unit = {},
    content: @Composable (() -> Unit)? = null
) {
    val primaryNavy = Color(0xFF1A2A5E)
    val primaryBlue = Color(0xFF003399)
    val secondaryBg = Color(0xFFF1F5F9)
    val borderColor = Color(0xFFCBD5E1)

    Box(
        modifier = modifier
            .fillMaxWidth()
            .defaultMinSize(minHeight = 44.dp)
            .background(Color.White, shape = RoundedCornerShape(12.dp))
            .border(1.dp, borderColor, shape = RoundedCornerShape(12.dp))
            .padding(16.dp)
            .clickable(onClick = onClick),
        contentAlignment = Alignment.CenterStart
    ) {
        Row(
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.SpaceBetween,
            modifier = Modifier.fillMaxWidth()
        ) {
            Column(modifier = Modifier.weight(1f)) {
                Text(
                    text = "MonthPickerIsland",
                    fontSize = 16.sp,
                    fontWeight = FontWeight.SemiBold,
                    color = primaryNavy
                )
                if (content != null) {
                    Spacer(modifier = Modifier.height(8.dp))
                    content()
                }
            }
        }
    }
}

/**
 * Web UI-Framework parity alias for [BizMonthPickerIsland].
 */
@Composable
fun PPMonthPickerIsland(
    modifier: Modifier = Modifier,
    modelValue: Boolean = false,
    title: String = "",
    config: String = "",
    initialDate: String = "",
    showActionButtons: Boolean = false,
    cancelText: String = "",
    confirmText: String = "",
    position: String = "top",
    fullWidth: Boolean = false,
    offset: Int = 16,
    onClick: () -> Unit = {},
    content: @Composable (() -> Unit)? = null
) = BizMonthPickerIsland(
        modifier = modifier,
        modelValue = modelValue,
        title = title,
        config = config,
        initialDate = initialDate,
        showActionButtons = showActionButtons,
        cancelText = cancelText,
        confirmText = confirmText,
        position = position,
        fullWidth = fullWidth,
        offset = offset,
        onClick = onClick,
        content = content
)
