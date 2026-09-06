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
 * BizDynamicIsland - Jetpack Compose component matching Web UI-Framework `PPDynamicIsland.vue`.
 */
@Composable
fun BizDynamicIsland(
    modifier: Modifier = Modifier,
    modelValue: Boolean = false,
    state: String = "",
    position: String = "",
    offset: Int = 0,
    fullWidth: Boolean = false,
    wrapperClass: String = "",
    autoHideTimeout: Int = 0,
    dismissOnOutsideClick: Boolean = false,
    bgColor: String = "",
    textColor: String = "",
    onClick: () -> Unit = {},
    onValueChange: ((String) -> Unit)? = null,
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
                    text = "DynamicIsland",
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
 * Web UI-Framework parity alias for [BizDynamicIsland].
 */
@Composable
fun PPDynamicIsland(
    modifier: Modifier = Modifier,
    modelValue: Boolean = false,
    state: String = "",
    position: String = "",
    offset: Int = 0,
    fullWidth: Boolean = false,
    wrapperClass: String = "",
    autoHideTimeout: Int = 0,
    dismissOnOutsideClick: Boolean = false,
    bgColor: String = "",
    textColor: String = "",
    onClick: () -> Unit = {},
    onValueChange: ((String) -> Unit)? = null,
    content: @Composable (() -> Unit)? = null
) = BizDynamicIsland(
        modifier = modifier,
        modelValue = modelValue,
        state = state,
        position = position,
        offset = offset,
        fullWidth = fullWidth,
        wrapperClass = wrapperClass,
        autoHideTimeout = autoHideTimeout,
        dismissOnOutsideClick = dismissOnOutsideClick,
        bgColor = bgColor,
        textColor = textColor,
        onClick = onClick,
        onValueChange = onValueChange,
        content = content
)
